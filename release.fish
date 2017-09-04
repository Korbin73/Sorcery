#! /usr/bin/fish

echo "***** Building to release directory *****"

# set current_path pwd
set -l current_dir (pwd)

mix deps.get
mix deps.clean --unused

set -l sorcery_dir "$current_dir/apps/sorcery"
cd $sorcery_dir

mix escript.build