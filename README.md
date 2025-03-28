# git-time-hooks

A pair of git hooks to automatically track time spent in feature development.

My blog post is [here](https://doocot.sh/blog/2025/03/28/time-tracking-with-git), which describes the motivation and how it works.

## TL;DR

These hooks automatically create tags when you merge a feature branch.
You can use this time data to infer entropy in your process/code.

```
$ git tag -n | grep time_
time_23ccc3b_fix_githooks          0d:0h:5m    secs=301
time_4aeeb7a_refactor_filestore    0d:22h:26m  secs=80685
time_8f0da2d_webui_blog_template   0d:19h:15m  secs=69313
time_c78833f_webui_try_now         2d:4h:12m   secs=18792
```

## Version Pinning

I'm not sure of the best way to version pin these git hooks, while making them easy to install.

```
$ cat Makefile 

githooks:
        @for i in $(shell ls -1 .githooks); do \
                echo "installing git hook $$i"; \
                cp -f ".githooks/$$i" .git/hooks; \
                chmod +x ".git/hooks/$$i"; \
        done

$ make githooks
installing git hook https://raw.githubusercontent.com/thisdougb/git-time-hooks/main/commit-msg
installing git hook https://raw.githubusercontent.com/thisdougb/git-time-hooks/main/pre-push
```
