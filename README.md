# git-time-hooks

A pair of git hooks to automatically track time spent in feature development.

My blog post is [here](https://doocot.sh/blog/2025/03/28/time-tracking-with-git.html), which describes the motivation and how it works.

## TL;DR

These hooks automatically add time tracking commit messages when you merge a feature branch.
You can use this time data to infer entropy in your process/code.

```
$ git log -1
commit 75c017e90eb491f9a6901aea41aed4f9317ff4ee (HEAD -> main)
Merge: 412cab8 2a97c3a
Author: Doug Bridgens 
Date:   Fri Apr 4 10:36:37 2025 +0100

    Merge branch 'feat_githooks'
    
    Time spent on feat_githooks: 0d:0h:3m secs=194
```

Here I can see how many days I've spent editing code on the webui component in the past month:

```
$ git log --since="1 month ago" | grep Time | grep webui | cut -f2 -d= | paste -s -d+ - | bc | paste -s -ds - | sed -e 's/$/\/60\/60\/24/g'  | bc
4
```

## Install

You can simply copy the two hooks into `./git/hooks/` and make them executable.
Or use a Makefile to automate the process.

```
$ cat Makefile 
HOOKS= \
	   https://raw.githubusercontent.com/thisdougb/git-time-hooks/main/commit-msg \
	   https://raw.githubusercontent.com/thisdougb/git-time-hooks/main/prepare-commit-msg

githooks:
	@cd .git/hooks && \
	for i in $(HOOKS); do \
		echo "installing git hook $$i"; \
		curl -sO $$i; \
		chmod +x "`echo $$i | rev | cut -f1 -d'/' | rev`"; \
	done

$ make githooks
installing git hook https://raw.githubusercontent.com/thisdougb/git-time-hooks/main/commit-msg
installing git hook https://raw.githubusercontent.com/thisdougb/git-time-hooks/main/prepare-commit-msg
```

## Changelog

#### 22 Apr 2025

A minor fix to catch a printed error from commit-msg when run on the very first repo commit, when reflog does not yet exist.

#### 04 Apr 2025

Refactored to make the hooks add time data into the merge commit messages.
This is cleaner and a little bit simpler.

#### 28 Mar 2025

Initial git hooks, creating tags to store the time data.
