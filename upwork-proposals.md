# Ready-to-send proposals — 21 Oct 2026

Connects balance is 0, so none of these can be submitted yet. Total Connects needed for all four: **75** (Freelancer Plus gives 100/month; code FLPLS50 halves the first month). Once Connects are in, say "send 1" (or 1–4) and each goes out exactly as written below, with the portfolio items listed attached.

Priority order is by fit × competition × client quality.

---

## 1. Senior AI Engineer: Production Multi-Agent RAG Workflow (LangGraph, MCP)
Client: Egypt (Cairo), new client, verified payment. Hourly $60–100, 10–20 h/week, 1–3 months + extension. **13 Connects.** No invites sent yet, nobody interviewed.
Why first: this is your profile almost line for line (LangGraph + MCP + RAG evaluation + guardrails + Docker/CI handover) and the client has defined acceptance criteria, which is how serious clients behave.
Bid: **$65/hr**. Attach portfolio: Intellect Chat, Oracle ERP Logic Extraction for AI Agents, TokenGuard.

**Cover letter**

> One similar system: Intellect Chat, a self-hosted multi-agent RAG platform for an enterprise that could not send data to the cloud. I personally built the supervisor-and-domain-agent orchestration, the hybrid retrieval layer (dense + sparse + re-ranking) and the evaluation harness, over a gRPC/Docker deployment. What went wrong: the first version used dense retrieval only and sat at 76% answer accuracy on our question set, and the agents handled retrieval misses by answering anyway. The fix was hybrid retrieval with a re-ranker, a "no grounded answer" path with a fallback, and an evaluation set that ran on every change. Accuracy went to 89% at under 200 ms, and we could see it move per commit.
>
> Your six acceptance criteria map directly onto work I have done more than once, so here is how I would run the 4 to 8 weeks:
>
> Week 1: architecture review in writing, prioritised (keep / fix / replace), with reasons. I say plainly when something should be deleted.
> Weeks 2–3: retrieval evaluation set of 50+ real questions with graded answers; baseline scores; then chunking, hybrid search and re-ranking changes measured against that baseline, not against opinion.
> Weeks 3–5: guardrails, retries, fallbacks and tool-error handling across agents and MCP tools, each covered by an automated test in CI.
> Weeks 5–6: tracing (LangSmith or Langfuse), per-request cost and latency view, Docker build, environment config, README and a handover call.
>
> Relevant recent work: a read-only MCP server exposing a 434-table Oracle ERP to LLM agents (Global Exports, 2026); an LLM-based SIEM in production for Pakistan's national CERT at 25M+ logs/day; and TokenGuard, my published evaluation work on when reasoning models should stop (12 benchmark/model settings, 54,812 graded answers). I am an AWS Certified Solutions Architect and have 13 peer-reviewed papers, so the evaluation side is not an afterthought.
>
> I am in London (UTC+1), which overlaps your UTC+2 to +4 window fully. I can commit 15–20 hours a week for the next 8 weeks and send short written updates twice a week.

**Screening answers**

1. *Describe one LLM or agent system you took to production: what you personally built, and the result.*
   > Intellect Chat: self-hosted multi-agent RAG for an enterprise with a no-cloud constraint. I built the supervisor/domain-agent orchestration, hybrid retrieval (dense, sparse, re-ranking) and the evaluation harness, deployed over gRPC and Docker. Result: answer accuracy from 76% to 89%, responses under 200 ms, no data leaving the client's servers, and a handover the client's team now runs. Separately, an LLM-based SIEM for Pakistan's national CERT processing 25M+ logs a day across 200+ organisations, where I led design and build.

2. *How would you measure whether a RAG pipeline improved? Name the metrics and how you would build the test set.*
   > Build the test set from real traffic and real documents, not synthetic questions: 50+ questions sampled across document types and difficulty, each with the gold passage(s) and a reference answer, labelled by someone who knows the domain; include unanswerable questions so abstention is measured. Retrieval metrics: recall@k and MRR against the gold passages. Answer metrics: faithfulness (is the answer supported by the retrieved context) and answer correctness against the reference, graded by an LLM judge that is itself checked against a human-graded subset; plus abstention precision on the unanswerable set. Operational metrics on the same run: p50/p95 latency and cost per query. Run it in CI on every change and report deltas against a frozen baseline; a change that raises correctness but lowers faithfulness or abstention is not an improvement.

3. *What is your hourly rate, and how many hours a week can you commit over the next 4 to 8 weeks?*
   > $65/hr. 15–20 hours a week for the next 8 weeks, with a weekly call and written updates in between.

---

## 2. Technical Architect for GDPR Review
Client: Norway, 5.0 rating, 3 hires, verified. Hourly $25–90, under 1 week, part time. **14 Connects.** 5 invites sent, 4 in interview — move fast.
Why: it is exactly the "Reviews and audits" product on your profile; short, high-rate, and a first review on the profile.
Bid: **$70/hr**. Attach portfolio: Intellect Chat, ZazuAI (both on-premise / data-residency designs).

**Cover letter**

> I review AI architectures for a living and most of my production work has been for clients who could not let data leave their own infrastructure, which is the same constraint GDPR puts on you in practice.
>
> What you would get in a one-week engagement:
>
> 1. A data-flow map of the planned application: every place personal data enters, is stored, is sent to a model or a third party, and leaves. This is the document a DPIA is built on.
> 2. A written architecture review with practical recommendations, split into "change before launch", "change within three months" and "fine as is", with reasons.
> 3. A GDPR and security gap list: lawful basis per flow, retention, data-subject requests, sub-processors (including any model API), encryption and access control, logging of model inputs and outputs, and prompt-injection and data-leakage controls for anything user-facing.
> 4. A plain list of what needs a specialist (DPO sign-off, legal review of processor agreements, penetration test) and how to obtain it, so you spend on specialists only where required.
>
> Relevant background: I shipped a fully on-premise meeting-intelligence system for a UAE enterprise (no cloud service touched the audio), a self-hosted multi-agent RAG platform where no data left the client estate, and an LLM-based SIEM for a national CERT. I am an AWS Certified Solutions Architect, hold an MSc in AI with Distinction from Brunel University London, and my published research includes work on privacy-preserving and federated learning and on how LLM agents relocate privacy exposure rather than remove it.
>
> I can start this week and deliver within five working days of receiving your plan.

**Screening answers**

1. *Describe your recent experience with similar projects.*
   > Architecture and data-protection reviews for AI systems on client infrastructure: an on-premise meeting-intelligence platform for a UAE enterprise (2024–25), a self-hosted multi-agent RAG platform with a no-data-egress requirement, and an LLM-based security platform for Pakistan's national CERT (2025), where logging, access control and data handling were reviewed with government security staff. In 2026 I mapped the data and business-logic flows of a 434-table Oracle ERP before exposing it to LLM agents through a read-only interface.

2. *Please list any certifications related to this project.*
   > AWS Certified Solutions Architect; MSc Artificial Intelligence (Distinction), Brunel University London, including Ethics and Governance of Digital Systems; selected participant, CISPA Helmholtz Center for Information Security Summer School 2026 (privacy-preserving learning track).

---

## 3. LLMOps Engineer: Self-Hosted Model Serving on GKE (vLLM, GPUs)
Client: Saudi Arabia-based programme (same client as job 4), 4 hires, verified, $3.6K spent. Hourly $31–61, 8 weeks full time. **26 Connects.** Nobody invited yet. Saudi-based candidates "preferred", not required.
Why: self-hosted inference, quantisation and Kubernetes are your strongest infrastructure line, and competition for pure LLMOps profiles is thin.
Bid: **$55/hr**. Attach portfolio: National-Scale LLM SIEM, Intellect Chat.

**Cover letter**

> Three similar projects and my role in each:
>
> 1. Digital-twin platform for a European 6G programme (EMS, 2026): I owned the end-to-end production deployment on Kubernetes (Knative serverless, RabbitMQ, PostgreSQL) including autoscaling, runbooks and operational handover.
> 2. LLM-based SIEM for Pakistan's national CERT (2025): I led design and build, including quantised model inference serving 25M+ logs a day across 200+ organisations, with data that could not leave government infrastructure.
> 3. Intellect Chat and ZazuAI (Neura-X, 2024–25): self-hosted inference for retrieval and speech on client hardware, with INT8/INT4 quantisation to fit the GPUs available, no external API calls.
>
> For your 8-week PoC I would: deploy vLLM and a text-embedding service on GKE with L4 nodes and GPU node pools; set horizontal autoscaling on queue depth and token throughput with a hard cost ceiling; stand up self-hosted Langfuse for traces and evaluation; put secrets in Secret Manager with KMS-managed keys and workload identity, and document the residency controls so your auditors can read them. AWQ/GPTQ quantised serving is in scope if the L4 budget needs it.
>
> I am an AWS Certified Solutions Architect with hands-on GCP and Kubernetes delivery, MSc AI (Distinction), and I publish on efficient inference. I am London-based, can work Saudi hours, will sign your NDA before any details are shared, and am available full time for the next 8 weeks.
>
> Rate: $55/hr.

---

## 4. AI Engineer: LLM, RAG and Document Extraction (LangGraph, Arabic)
Same client as job 3. Hourly $35–60, 8 weeks full time. **26 Connects.**
Why: open-weight models, LangGraph, hybrid search with pgvector and re-ranking, Ragas/DeepEval evaluation — all on your profile. Apply to either 3 or 4, not both, unless you want both PoCs; the client is running several in parallel and may hire one person for two.
Bid: **$55/hr**. Attach portfolio: Intellect Chat, Oracle ERP Logic Extraction.

**Cover letter**

> Three relevant projects and my role:
>
> 1. Intellect Chat (Neura-X): self-hosted multi-agent RAG on open-weight models with hybrid retrieval (dense + sparse + re-ranking) over documents, images and audio. I built the retrieval layer and the evaluation harness; accuracy went from 76% to 89% at under 200 ms, no data leaving the client estate.
> 2. Global Exports (2026): document and schema extraction from a legacy Oracle ERP, 823 business rules recovered and verified against the live database, then exposed to LLM agents through a read-only MCP server. I led the work.
> 3. LLM-based SIEM for Pakistan's national CERT (2025): structured extraction and classification pipelines on quantised open-weight models at 25M+ logs/day. I led design and build.
>
> For your PoC: LangGraph pipelines for extraction, retrieval and draft generation; an OCR and VLM benchmark on your real scanned documents (PaddleOCR, Surya and Docling against Qwen-VL class models, reported per document type); pgvector plus full-text hybrid search with a re-ranker; and Ragas/DeepEval evaluation with a frozen test set so every change is measured. Arabic retrieval needs language-aware chunking and an embedding model evaluated on Arabic specifically; I would benchmark that in week one rather than assume.
>
> MSc AI (Distinction), AWS Certified Solutions Architect, 13 peer-reviewed papers including on RAG and agent evaluation. London-based, Saudi working hours are fine, NDA before details, full time for 8 weeks.
>
> Rate: $55/hr.

---

## Also worth watching (not drafted)
- **Senior AI Engineer and Solution Architect for AI Platform Architecture** (Saudi Arabia, $40–70/hr, 47 hires, 4.88 rating, 22 Connects). Strong fit, but the client has already invited 8 and interviewed 6, so it is late. Apply only if Connects remain after the four above.
- **Senior AI/ML Engineer to Critically Review a Production RAG Architecture** has already closed (hired).

## Standing rules for proposals from here on
- Only jobs with verified payment, posted in the last 48 hours, with your core stack in the description.
- First line answers the client's own question or names their problem; never a greeting.
- One number from your record that matches their problem; one small paid first step offered.
- Bid inside the client's range, towards the upper half; profile stays at $50 until Top Rated.
- Attach 2–3 portfolio items, never all 8.
- Reply to any client message within 2 hours in UK working hours.
