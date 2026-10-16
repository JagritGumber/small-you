# Ticket runner

Each run moves one of <name>'s tickets forward in its own worktree and leaves it for their review. Read `.small-you/RULES.md` and `.small-you/scope.md` first.

Schedule it with a one-line prompt, "Read .small-you/playbook.md and follow it", and a precheck so it only starts when there is work.

## Pick

A candidate:

- is code work: <the kinds of tickets an agent can take, e.g. titles starting `BUILD ·`>. Tickets that need people, such as <decisions, specs or docs <name> approves>, are out;
- is in Todo or In Progress, with every blocker done. In Review waits on people;
- builds or changes nothing `.small-you/scope.md` marks as cut or waiting. Judge by its deliverables: a ticket that names such an area only as context stays in;
- has no line or recent comment saying it waits on a person or a decision;
- has no worktree <name> is in right now: a file changed there in the last hour counts.

Prefer started over unstarted, then higher priority, then the earlier due date. With no candidate, stop with "Nothing for you" and the reason each ticket was skipped.

## Work

1. Read the ticket, its comments and the docs it links. List each deliverable as done, partly done or not started, with the evidence. A deliverable that needs a decision the ticket and docs don't make becomes a question in `.small-you/questions.md`, and you leave it alone.
2. Work in the ticket's own worktree (`git worktree add`), never in <name>'s checkout. Write the test first where the behaviour can be tested.
3. Run the tests and the typecheck. Review your own diff once as a strict reviewer would, and fix what's real.
4. Leave the change uncommitted unless `.small-you/RULES.md` says otherwise. Don't push or open a pull request.

## Last message

First line: "Ready for your review: <ticket>, in <worktree path>", or "Nothing for you". Then what changed, what you tested, and any question you wrote down.
