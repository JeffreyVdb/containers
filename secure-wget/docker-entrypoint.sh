#!/bin/bash
# Usage:
#   $0 sha256:<sha256sum> <output> <wget flags>

set -o errexit
set -o noclobber

SHA_ALG="$(cut -d':' -f1 <<< $1)"
SHA_CMD="${SHA_ALG}sum"

function usage() {
    cat <<EOF
usage:
    $0 sha256:<sha256sum> <destination> <wget_args>
EOF
}

if [[ $# -lt 3 ]]; then
    usage
    exit 1
fi

SHASUM="$(cut -d':' -f2 <<< $1)"
DEST="$2"
shift 2

wget -O "$DEST" "$@"

SUMFILE="/tmp/CHECK.${SHA_ALG}"
cat >$SUMFILE <<EOF
${SHASUM}  ${DEST}
EOF

$SHA_CMD -c $SUMFILE