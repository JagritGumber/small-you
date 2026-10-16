# small you

> **Agents:** if your person gave you this repo, read [`SETUP.md`](https://github.com/JagritGumber/small-you/blob/v1/SETUP.md) at tag `v1` in full and follow it in their project. Change nothing until they say yes.

A few short files about you, so the agents you schedule make the calls you would.

Agents reason from your code, and your code shows what exists, not what you decided to stop building. On a fake ticket board, GPT 6.1 Sol and Claude Sonnet 5.5 both picked a feature the owner had cut, in 6 runs out of 6. With three short files about the owner, both picked the right ticket in 6 runs out of 6.

## Give it to your agent

Open your coding agent in the project you want agents working on, and paste:

```text
Read SETUP.md from github.com/JagritGumber/small-you at tag v1, in full (clone it or fetch the raw file, not a summary), and follow it to set up my small you in this project. Change nothing until I say yes.
```

Your agent will:

1. read your project, then ask you about eight questions, mostly to confirm what it already guessed;
2. show you a plan of the files it will write, and wait for your yes;
3. write `RULES.md`, `scope.md`, `brief.md` and `questions.md` into `.small-you/` in your project, and if you keep it local, add `.small-you/` to `.git/info/exclude`;
4. run a morning brief once, fix the prompt with you, and offer to schedule it.

It doesn't commit, push, post, message anyone or read your secrets, and it asks before scheduling anything. Besides fetching this repo, it only reads: your project, and your open pull requests and tracker if your existing logins reach them. Every step it takes is in [`SETUP.md`](SETUP.md), so you can read it first.

The line points at tag `v1`, the version the write-up describes, so changes on `main` don't reach your agent. I won't move that tag; for a pin nobody can move, give your agent the commit hash from the v1 release instead. Codex keeps the network off by default, so it will ask you to allow the clone.

## What's inside

| Path | What it is |
|---|---|
| [`SETUP.md`](SETUP.md) | the setup your agent follows |
| [`setup/interview.md`](setup/interview.md) | the questions it asks you |
| [`templates/`](templates) | `RULES.md`, `scope.md`, `brief.md`, `questions.md`, a ticket-runner playbook and two prechecks |
| [`test/`](test) | the experiment: the same models, with and without the files |

## By hand

Copy `templates/` to `.small-you/` in your project, fill in every `<placeholder>`, and schedule `Read .small-you/brief.md and follow it.` in whatever runs your agents.

## Where this comes from

My own setup: scheduled agents in [Orca](https://github.com/stablyai/orca) running [Pi](https://github.com/earendil-works/pi) on my company's repo every weekday, and the rules file, scope file and playbooks that make them useful. The write-up is on X at [@ItsRoboki](https://x.com/ItsRoboki).

MIT licensed.
