#!/bin/bash
set -euo pipefail

SCRIPT_DIR=$(dirname $0)
ARTIFACTS_DIR=${SCRIPT_DIR}/artifacts

install -D {${ARTIFACTS_DIR},}/etc/yum.repos.d/adoptium.repo
