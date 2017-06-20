#!/usr/bin/env sh

realpath() {
    [[ $1 = /* ]] && echo "$1" || echo "$PWD/${1#./}"
}

SCRIPT=`realpath $0`
echo $SCRIPT
SCRIPTPATH=`dirname $SCRIPT`

cd "$SCRIPTPATH"
mix deps.get
mix deps.clean --unused

rm -rf "$SCRIPTPATH"/release
mkdir release
cp bin/exscript* release/

cd "$SCRIPTPATH"/apps/sorcery
mix escript.build
