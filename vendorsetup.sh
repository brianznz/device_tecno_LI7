#!/bin/bash

# SKIP_LOCAL_PATCHES=1 to skip

apply_local_patches() {
  local top dir entry repo p r rc=0
  local list=(
    "frameworks/base|0001-SystemUI-biometrics-Add-HBM-Trigger-for-Transsion-UDFPS.patch"
  )

  if [ -n "$SKIP_LOCAL_PATCHES" ]; then
    echo "local patches skipped"
    return 0
  fi

  top=$(gettop) || return 1
  dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd) || return 1
  dir=$dir/patches

  for entry in "${list[@]}"; do
    repo=${entry%%|*}
    p=${entry##*|}
    r=$top/$repo

    if [ ! -f "$dir/$p" ] || ! git -C "$r" rev-parse --git-dir >/dev/null 2>&1; then
      echo "$p: patch file missing or $repo is not a git repo"
      rc=1
      continue
    fi

    if git -C "$r" apply --reverse --check "$dir/$p" >/dev/null 2>&1; then
      echo "$p: already applied"
      continue
    fi

    [ -d "$(git -C "$r" rev-parse --absolute-git-dir)/rebase-apply" ] &&
      { echo "$p: am/rebase in progress in $repo"; rc=1; continue; }
    git -C "$r" diff --quiet HEAD 2>/dev/null ||
      { echo "$p: $repo has uncommitted changes"; rc=1; continue; }
    git -C "$r" var GIT_COMMITTER_IDENT >/dev/null 2>&1 ||
      { echo "$p: git identity not set"; rc=1; continue; }
    git -C "$r" apply --check "$dir/$p" >/dev/null 2>&1 ||
      { echo "$p: does not apply to $repo"; rc=1; continue; }

    if git -C "$r" am -q "$dir/$p" >/dev/null 2>&1; then
      echo "$p: applied"
    else
      git -C "$r" am --abort >/dev/null 2>&1
      echo "$p: git am failed"
      rc=1
    fi
  done

  [ $rc -ne 0 ] && echo "some local patches failed, check above"
  return $rc
}

apply_local_patches
unset -f apply_local_patches

