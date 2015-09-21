#!/bin/bash
set -e

/bin/bash-it enable alias all
/bin/bash-it enable plugins all
/bin/bash-it enable completion all

/bin/bash-it disable plugin chruby
/bin/bash-it disable plugin chruby-auto
/bin/bash-it disable plugin postgres
/bin/bash-it disable plugin z
/bin/bash-it disable plugin postgres
/bin/bash-it disable plugin todo
/bin/bash-it disable completion conda
/bin/bash-it disable alias emacs