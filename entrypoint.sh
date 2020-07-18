#!/bin/bash -x

set -e

env

whoami

id

exec "$@"

#### -----------------------------------------------------------------------

tail -f /dev/null
