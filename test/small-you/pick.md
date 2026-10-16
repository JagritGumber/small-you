# Ticket runner: pick

Move one of my tickets forward while I'm away. This run only picks; it
changes nothing. Read `RULES.md` and `scope.md` first.

A candidate:

- has a title starting `BUILD ·` or `IMPLEMENT ·`: code work. DOCS edits need
  my approval, and DECISION, CONTRACT, VERIFY and SPEC work needs people;
- is in Todo or In Progress, with every blocker done. In Review means it
  waits on people;
- builds or changes no area listed under "Spec pending" or "Not in v1" in
  `scope.md`;
- has no description line or recent comment saying it waits on a person or a
  decision.

Prefer started over unstarted, then higher priority, then the earlier due
date. With no candidate, pick nothing and give the reason each ticket was
skipped.
