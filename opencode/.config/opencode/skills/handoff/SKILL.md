---
name: handoff
description: Creates a compact handoff document so a fresh agent can continue the current work. Use when the user asks to hand off, summarize work for another agent, or continue in a new session.
---

# Handoff

Write a handoff document summarizing the current conversation so a fresh agent can continue the work. Save it to the operating system's temporary directory, not the current workspace.

Include a "Suggested Skills" section that recommends skills the next agent should invoke.

Do not duplicate content already captured in other artifacts, such as specs, plans, ADRs, issues, commits, or diffs. Reference them by path or URL instead.

Redact sensitive information, including API keys, passwords, and personally identifiable information.

If the user supplied arguments, treat them as a description of the next session's focus and tailor the document accordingly.
