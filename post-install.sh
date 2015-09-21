#!/bin/bash
set -e

bash-it enable alias all
bash-it enable plugins all
bash-it enable completion all

bash-it disable plugin chruby
bash-it disable plugin chruby-auto
bash-it disable plugin postgres
bash-it disable plugin z
bash-it disable plugin postgres
bash-it disable plugin todo
bash-it disable completion conda
bash-it disable alias emacs