#!/bin/bash
# 9418 is the standard git port, DEFAULT_GIT_PORT is the environment
# variable used internally by git-daemon
PORT=${DEFAULT_GIT_PORT:-9418}
echo "Now serving on port $PORT, set DEFAULT_GIT_PORT to change"
echo "Access via git://localhost:$PORT/relative_path_to_repo"
git daemon --base-path=. --export-all --reuseaddr --informative-errors --verbose
