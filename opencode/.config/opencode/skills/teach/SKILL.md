---
name: teach
description: Teaches the user a new skill or concept through a stateful workspace course. Use when the user asks to learn or be taught a topic over multiple sessions.
---

# Teach

The user has asked you to teach them something. This is a stateful request: they intend to learn the topic over multiple sessions.

## Teaching Workspace

Treat the current directory as a teaching workspace. The state of their learning is captured in these files:

- `MISSION.md`: Captures why the user is interested in the topic. Ground all teaching in it. Use [MISSION-FORMAT.md](./MISSION-FORMAT.md).
- `reference/*.html`: Compressed learning reference materials: cheat sheets, algorithms, syntax, poses, or glossaries. These should be beautiful, printable, and designed for quick reference.
- `RESOURCES.md`: Trusted resources that ground teaching in contextual knowledge. Use [RESOURCES-FORMAT.md](./RESOURCES-FORMAT.md).
- `learning-records/*.md`: Records of what the user has learned, prior knowledge, and insights that should affect future sessions. Use `0001-dash-case-name.md`, incrementing each time, and [LEARNING-RECORD-FORMAT.md](./LEARNING-RECORD-FORMAT.md).
- `lessons/*.html`: Self-contained lessons. A lesson teaches one tightly scoped thing tied to the mission.
- `assets/*`: Reusable components shared across lessons.
- `NOTES.md`: A scratchpad for user preferences and working notes.

## Philosophy

Deep learning needs three things:

- Knowledge from high-quality, high-trust resources.
- Skills acquired through highly relevant interactive lessons based on that knowledge.
- Wisdom from interacting with other learners and practitioners.

Before `RESOURCES.md` is well populated, find high-quality resources that help the user acquire knowledge. Never rely solely on parametric knowledge.

Some topics need more skill than knowledge. Theoretical physics may be knowledge-based; yoga may be skill-based.

### Fluency And Storage Strength

Separate two types of learning:

- Fluency strength: in-the-moment retrieval of knowledge.
- Storage strength: long-term retention of knowledge.

Fluency can create an illusory sense of mastery; storage strength is the goal. Design lessons for long-term retention through desirable difficulty:

- Retrieval practice: recall from memory.
- Spacing: distribute practice over time.
- Interleaving: mix related skills in practice.

## Lessons

A lesson is the primary unit through which knowledge and skills reach the user. Save each as a self-contained HTML file in `lessons/`, named `0001-dash-case-name.html` with sequential numbering.

Lessons should be beautiful, clean, and readable because the user will revisit them. Think Tufte. Keep them short and quickly completable. Working memory is small, but every lesson should provide one tangible win tied directly to the mission and in the user's zone of proximal development.

When feasible, open the lesson file for the user with a CLI command.

Each lesson must:

- Link with HTML anchors to other lessons and reference documents.
- Recommend one high-quality, high-trust primary source to read or watch.
- Remind the user to ask follow-up questions.

## Assets

Lessons use reusable components in `assets/`, including stylesheets, quiz widgets, simulators, and diagram helpers. Reuse is the default. Before authoring a lesson, read `assets/` and build from what is already there.

When a lesson needs a new reusable component, create it in `assets/` and link to it; do not inline code that future lessons would duplicate. The first component every workspace earns is a shared stylesheet so lessons look like a consistent course.

## Mission

Every lesson must be tied to the user's mission: why they are learning the topic. If the mission is unclear or `MISSION.md` is absent or incomplete, first ask why they want to learn it.

Missions can change. Confirm with the user before changing `MISSION.md`, then add a learning record that captures the change.

## Zone Of Proximal Development

Each lesson should challenge the user just enough. If they do not specify what to learn, determine the right next topic by reading the learning records, considering the mission, and selecting the most relevant skill in their zone of proximal development.

## Knowledge

Design lessons around a skill the user will acquire. Include only the knowledge required for that skill, then let the user practice through an interactive feedback loop.

Gather knowledge from trusted resources first and maintain them in `RESOURCES.md`. Cite external sources throughout lessons to support claims and increase trustworthiness. Difficulty consumes working memory needed for knowledge acquisition, so keep explanations clear.

## Skills

Skills build durability and flexibility. Use difficulty deliberately: effortful retrieval builds storage strength. Teach through interactive lessons with a tight feedback loop that gives immediate, ideally automatic, feedback.

Possible approaches include interactive quizzes, light in-browser tasks, and lessons that guide real-world actions such as yoga poses. For quizzes, make each answer use the same number of words, and preferably characters, to avoid formatting clues.

## Acquiring Wisdom

Wisdom comes from real-world interaction. When a question appears to require wisdom, attempt an answer but ultimately direct the user to a community where they can test their skills in practice.

Find high-reputation online or offline communities, such as well-moderated forums, subreddits, classes within budget, or local interest groups. Respect a user's preference not to join a community.

## Reference Documents

Create reference documents while creating lessons. Lessons can link to them, and they track raw units of knowledge useful across lessons.

Lessons are rarely revisited; references are. Make references the compressed essence of a lesson and optimized for quick consultation. Good candidates include programming syntax and snippets, algorithms and flowcharts, yoga sequences, fitness routines, and glossaries.

Glossaries are especially important. Once created, use their terminology in every lesson. Use [GLOSSARY-FORMAT.md](./GLOSSARY-FORMAT.md).

## Notes

Record user teaching preferences and other durable considerations in `NOTES.md` so they guide future lessons.
