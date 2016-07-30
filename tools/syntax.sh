#!/bin/bash
# ------------------------------------------------------------------
# Tanky Woo (2016-07-30)
# Show code syntax theme with Pygments
# Ref:
#   - http://stackoverflow.com/questions/7314044/use-bash-to-read-line-by-line-and-keep-space
#   - http://stackoverflow.com/questions/5349718/how-can-i-repeat-a-character-in-bash
# ------------------------------------------------------------------

IFS=''

# pygmentize -L styles | grep '* ' | cut -d ' ' -f2 | cut -d ':' -f1  # get style list
THEMES=("manni" "igor" "lovelace" "xcode" "vim" "autumn" "vs" "rrt"
        "native" "perldoc" "borland" "tango" "emacs" "friendly" "monokai" "paraiso-dark"
        "colorful" "murphy" "bw" "pastie" "algol_nu" "paraiso-light" "trac"
        "default" "algol" "fruity")

CODE='#!/usr/bin/env python\n# -*- coding: utf-8 -*-\nimport sys\n\nif __name__ == "__name__":\n    print("Hello, World!")\n    print(sys.version)\n'

for theme in ${THEMES[@]}; do
  printf '=%.0s' {1..30}; printf "%s" " $theme "; printf '=%.0s' {1..30}; echo
  echo -e ${CODE} | pygmentize -f terminal256 -O style=$theme -l python -s
done
