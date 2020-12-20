#!/bin/sh

set -e

if [ -n "$OVERRIDE_PYTHON_VERSION" ]; then
  $HOME/.pyenv/bin/pyenv install $OVERRIDE_PYTHON_VERSION
  $HOME/.pyenv/bin/pyenv global $OVERRIDE_PYTHON_VERSION
fi

exec /tmp/init.sh "$@"
