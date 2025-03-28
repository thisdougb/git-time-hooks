# Makefile
#
# This snippet can be used to install the git hooks that enable time-tracking. It
# downloads the hooks into the .git/hooks dir, and sets them to be executable.
#

GIT_TIME_HOOKS= \
	https://raw.githubusercontent.com/thisdougb/git-time-hooks/main/commit-msg \
	https://raw.githubusercontent.com/thisdougb/git-time-hooks/main/pre-push

.PHONY: githooks
githooks:
	@cd .git/hooks && \
	for i in $(GIT_TIME_HOOKS); do \
		echo "installing git hook $$i"; \
		curl -sO $$i; \
		chmod +x "`echo $$i | rev | cut -f1 -d'/' | rev`"; \
	done

