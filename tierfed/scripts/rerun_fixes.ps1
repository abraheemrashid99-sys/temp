# Reruns every run affected by the three v3.1 fixes:
#   (1) fixed schedule no longer sends a fallback tier (period K_med now takes effect)
#   (2) compressors act on the update with error feedback (not on raw weights)
#   (3) deterministic attention kernel on CUDA (affects the FT-Transformer arm)
# Deletes ONLY the affected logs, then reruns them with skip-existing.
#   powershell -ExecutionPolicy Bypass -File scripts\rerun_fixes.ps1 -Part cpu   # now, alongside the GPU job
#   powershell -ExecutionPolicy Bypass -File scripts\rerun_fixes.ps1 -Part gpu   # after the GPU job has finished
param([ValidateSet("cpu","gpu")][string]$Part = "cpu", [int]$Jobs = 6)
$ErrorActionPreference = "Continue"
$env:PYTHONHASHSEED = "0"
$py = (Resolve-Path ".\.venv\Scripts\python.exe").Path
$seeds = "42 43 44 45 46 47 48 49 50 51" -split " "
$L = "results\logs"
function Drop($pattern) { Get-ChildItem "$L\$pattern" -ErrorAction SilentlyContinue | Remove-Item -Force }

function Run-Parallel([string[]]$ArgList) {
  $procs = @()
  foreach ($a in $ArgList) {
    while (($procs | Where-Object { -not $_.HasExited }).Count -ge $Jobs) { Start-Sleep -Seconds 3 }
    $procs += Start-Process -FilePath $py -ArgumentList $a -NoNewWindow -PassThru
  }
  $procs | ForEach-Object { $_.WaitForExit() }
}

if ($Part -eq "cpu") {
  # affected CPU families: every 'fixed' MLP run on diabetes except architecture, and all compressed runs
  Get-ChildItem "$L\diabetes_mlp_fixed_*" | Where-Object { $_.Name -notmatch "_architecture_" } | Remove-Item -Force
  Get-ChildItem "$L\*_comp_*" | Where-Object { $_.Name -notmatch "_comp_none" } | Remove-Item -Force
  $cmds = @()
  foreach ($s in $seeds) {
    $cmds += "-m src.experiments.run_one --dataset diabetes --strategy fixed --seed $s --rounds 60 --clients 20 --device cpu --strategy-kwargs `"{\`"k_slow\`":5,\`"k_med\`":2}`" --skip-existing"
    $cmds += "-m src.experiments.run_one --dataset diabetes --strategy fixed --seed $s --rounds 60 --clients 20 --device cpu --tag _factorial_fixed --strategy-kwargs `"{\`"private_head\`":true,\`"schedule\`":true}`" --skip-existing"
    $cmds += "-m src.experiments.run_one --dataset diabetes --strategy fixed --seed $s --rounds 60 --clients 20 --device cpu --tag _factorial_sched_only --strategy-kwargs `"{\`"private_head\`":false,\`"schedule\`":true}`" --skip-existing"
    $cmds += "-m src.experiments.run_one --dataset diabetes --strategy fixed --seed $s --rounds 60 --clients 20 --device cpu --tag _attack --attack-every 1 --membership-inference --skip-existing"
    foreach ($sg in @("0.5","1.0","2.0","4.0")) {
      $cmds += "-m src.experiments.run_one --dataset diabetes --strategy fixed --seed $s --rounds 60 --clients 20 --device cpu --dp-sigma $sg --tag _dp$sg --skip-existing"
    }
    foreach ($ks in 2,4,8) { foreach ($km in 1,2,4,8) { if ($km -le $ks) {
      $cmds += "-m src.experiments.run_one --dataset diabetes --strategy fixed --seed $s --rounds 60 --clients 20 --device cpu --tag _periods_ks${ks}_km${km} --strategy-kwargs `"{\`"k_slow\`":$ks,\`"k_med\`":$km}`" --skip-existing"
    }}}
    foreach ($st in @("fedavg","fedper","tierfed")) {
      $sk = '{}'; if ($st -eq "tierfed") { $sk = '{\"warmup\":5,\"rho\":0.25}' }
      foreach ($c in @("quant8","quant4","topk","stc","sketch")) {
        $cmds += "-m src.experiments.run_one --dataset diabetes --strategy $st --compressor $c --seed $s --rounds 60 --clients 20 --device cpu --tag _comp_$c --strategy-kwargs `"$sk`" --skip-existing"
      }
    }
  }
  Write-Host "CPU reruns: $($cmds.Count) runs with $Jobs workers"
  Run-Parallel $cmds
}

if ($Part -eq "gpu") {
  # architecture 'fixed' arms (all three backbones) and the transformer arm (deterministic attention)
  Drop "diabetes_*_fixed_*_architecture_*"
  Drop "diabetes_transformer_*_architecture_*"
  & $py -m src.experiments.run_ablation --kind architecture --dataset diabetes --seeds 42 43 44 45 46 --device cuda --out results
}

& $py -m src.analysis.collect --results results --dataset diabetes --model mlp
& $py -m src.analysis.make_figures --results results --dataset diabetes --model mlp
Write-Host "RERUN DONE ($Part)"
