#!/bin/bash
set -eou pipefail

# 9418 is the standard git port, DEFAULT_GIT_PORT is the environment
# variable used internally by git-daemon
PORT=${DEFAULT_GIT_PORT:-9418}
echo "Now serving on port $PORT, set DEFAULT_GIT_PORT to change"

args=()

if [ ${GIT_SERVE_ALLOW_PUSH:-0} = 1 ]; then
    echo "receive-pack (git push) service enabled, be careful who this is exposed to!"
    args+=( '--enable=receive-pack' )
else
    echo "receive-pack (git push) service disabled, set GIT_SERVE_ALLOW_PUSH=1 to enable"
fi

# If we're already in a git directory, print a more relevant message
if [ -d .git ]; then
    echo "Access via git://localhost:$PORT/"
    echo "ex: git pull git://localhost:$PORT/ branch"
else
    echo "Access via git://localhost:$PORT/relative_path_to_repo"
    echo "ex: git pull git://localhost:$PORT/repo branch"
fi

if [ ${GIT_SERVE_DETACH:-0} = 1 ]; then
    echo "Detaching from shell"
    args+=( '--detach' )
fi

exec git daemon --base-path=. --export-all --reuseaddr --informative-errors --verbose "${args[@]}"
