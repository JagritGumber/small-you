# Set up a small you

You are a coding agent, and the person you work for gave you this file. Set up their **small you**: a few short files that tell the agents they schedule how they judge, what they have decided, and what they are still unsure about.

Agents reason from the code, and the code shows what exists, not what your person decided to stop building. In the test in `test/`, two frontier models picked a feature the owner had already cut in 6 runs out of 6. With three short files about the owner, both picked the right ticket in 6 runs out of 6.

The setup takes about ten minutes of your person's time. Follow the steps in order.

## Ground rules

- Set up the small you in the project your person is working in now. This repo only holds the instructions and templates; leave it unchanged.
- Change nothing until your person has seen the plan in step 4 and said yes. Then write only the files in that plan.
- Don't commit, push, open pull requests, comment on tickets, post or message anyone.
- Don't read `.env` files, keys or other secrets. Nothing here needs them.
- Besides fetching this repo, use the network only for read commands that run on logins your person already has, such as `gh pr list`.
- Setup executes nothing from this repo. The prechecks in `templates/` are copied, shown, and run only if your person agrees. The test in `test/` calls paid models, so you don't run it.
- Keep their words. Every line you write should be one an agent would otherwise get wrong; drop the rest.

## 0. Get the files

Read every file you use in full, not a summary. Either clone the repo into a new temporary folder outside their project:

```sh
git clone --depth 1 --branch v1 https://github.com/JagritGumber/small-you "$(mktemp -d)/small-you"
```

or fetch each file raw, for example `https://raw.githubusercontent.com/JagritGumber/small-you/v1/setup/interview.md`. You need `setup/interview.md` and the files in `templates/`.

## 1. Say what you'll do

Tell your person, in three sentences or fewer: you'll ask a few questions, show them a plan, write a few short files into `.small-you/`, and set up a morning brief that reads them. Nothing gets committed or sent.

## 2. Read before you ask

Without changing anything, learn what you can: the README, any `AGENTS.md` or `CLAUDE.md`, recent commits, open pull requests (`gh pr list` if it's available), and their ticket tracker if you can read it. Note what's in flight and who works on what.

Done when you could draft an answer to most questions in `setup/interview.md`.

## 3. Interview

Ask the questions in `setup/interview.md`. For each one you could infer, show your draft answer and ask them to correct it; ask the rest plainly. Ask a few at a time.

Question 4, what they decided to stop building, matters most. Press for specific features with dates, because nothing in their repo or tracker says it.

## 4. Show the plan and wait

**Stop here before writing anything.** Send the plan as a message of its own, even if your person approved it in advance, and write nothing until they have seen it and said yes. Show exactly what you'll write:

| File in their project | Holds |
|---|---|
| `.small-you/RULES.md` | how they judge: what agents may touch, and how to report back |
| `.small-you/scope.md` | what's decided, cut or waiting, each with who decided and when |
| `.small-you/brief.md` | the morning brief prompt |
| `.small-you/questions.md` | where agents write down what they couldn't answer |

If the schedule in step 7 will log to a file, add `.small-you/briefs.log` to the plan.

Ask whether `.small-you/` should be shared with their team or stay on their machine. If it stays local, the plan adds one line, `.small-you/`, to `.git/info/exclude`, which hides it from git without changing any tracked file. If it's shared, they commit it themselves.

Some sandboxes block writes inside `.git/` (Codex's default one does). If yours does, don't work around it: give your person the command to run themselves, `printf '.small-you/\n' >> .git/info/exclude`, and repeat it in your last message.

## 5. Write the small you

Copy the four templates into `.small-you/` and fill every `<placeholder>` from their answers. Change the read-only line in `RULES.md` to match their answer to question 2. Delete any line they disagree with instead of softening it. Keep `RULES.md` under about 30 lines and `scope.md` to what's true today.

Show them `RULES.md` and `scope.md` and ask for changes. Done when they say both are right.

## 6. Run the brief once, the way the schedule will

A run inside this conversation already knows the interview, so it would look better than a scheduled run. Run it fresh instead: show your person the headless command for their agent and, after a yes, run it from the project folder.

- Claude Code: `claude -p "Read .small-you/brief.md and follow it." --allowedTools "Read Grep Glob Bash(git log *) Bash(gh pr list *)"`
- Codex: `codex exec "Read .small-you/brief.md and follow it."`
- Pi: `pi -p "Read .small-you/brief.md and follow it."`

Add any tool their tracker needs to the allowed list. If the command can't run inside your sandbox, don't loosen the sandbox: give your person the command to run in their own terminal. If they have no headless agent, or until they've run it, follow the brief yourself and say the result had the interview's help. Show the result and ask what's wrong with it. Fix the prompt, not the output, and run it again.

Done when your person says they would read it at the start of their day.

## 7. Schedule it (ask first)

Offer the scheduler they already use, at the time and timezone they gave in the interview. Show the exact command and run it only after a yes.

- **Orca:** `orca automations create --name "Morning brief" --trigger weekdays --time <HH:MM> --timezone <IANA zone> --provider <claude|codex|gemini> --repo path:<project> --prompt "Read .small-you/brief.md and follow it."`
- **cron:** cron starts with a minimal PATH and the machine's timezone. Use the agent's full path (`command -v claude`) and convert the time to the machine's zone (`date`), or set `CRON_TZ=<zone>` above the line where their cron supports it:

  ```
  <min> <hour> * * 1-5 cd "<project>" && <full path>/claude -p "Read .small-you/brief.md and follow it." --allowedTools "Read Grep Glob Bash(git log *) Bash(gh pr list *)" >> .small-you/briefs.log 2>&1
  ```

  The same works with `codex exec "<prompt>"` or `pi -p "<prompt>"`.
- Anything else they use, in its own syntax.

## 8. Next automations (offer, don't build)

Tell them what comes next, one automation at a time, each with a precheck so it skips runs when there's nothing to do:

- `templates/playbook.md`: a ticket runner that works in its own worktree and hands back a change for review.
- `templates/precheck-pr-review.sh` (needs `gh` logged in) and `templates/precheck-main-moved.sh` (needs an `origin` remote): a scheduled run starts only when its precheck exits 0.

## 9. Point them to the test

`test/` holds the experiment: a fake board of ten tickets where the obvious pick is a feature the owner cut. Tell them it exists and that `test/README.md` says how to run it on their own model. Don't run it yourself: it calls paid models with their keys.

## 10. Last message

The first line says what your person should do next, for example "Read tomorrow's brief and tell me what's wrong with it". Then:

- the files you wrote and where, and the schedule if you made one;
- how to undo it: delete `.small-you/`, remove its line from `.git/info/exclude`, and remove the schedule (give the exact command).

End with one sentence: when an agent asks a question, answer it with a line in `.small-you/`, not in chat, so no agent has to ask it again.
