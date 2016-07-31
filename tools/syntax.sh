#!/bin/bash
# ------------------------------------------------------------------
# Tanky Woo (2016-07-30)
# Show code syntax theme with Pygments
# Ref:
#   - http://stackoverflow.com/questions/7314044/use-bash-to-read-line-by-line-and-keep-space
#   - http://stackoverflow.com/questions/5349718/how-can-i-repeat-a-character-in-bash
# ------------------------------------------------------------------

#IFS=''

# pygmentize -L styles | grep '* ' | cut -d ' ' -f2 | cut -d ':' -f1  # get style list
THEMES=("manni" "igor" "lovelace" "xcode" "vim" "autumn" "vs" "rrt"
        "native" "perldoc" "borland" "tango" "emacs" "friendly" "monokai" "paraiso-dark"
        "colorful" "murphy" "bw" "pastie" "algol_nu" "paraiso-light" "trac"
        "default" "algol" "fruity")

CODE=$(cat <<EOF
#!/usr/bin/env python
# -*- coding: utf-8 -*-
import sys

if __name__ == "__name__":
    print("Hello, World!")
    print(sys.version)
EOF
)

for theme in ${THEMES[@]}; do
  printf '=%.0s' {1..30}; printf "%s" " $theme "; printf '=%.0s' {1..30}; echo
  if [ -n "$1" ]; then
    pygmentize -f terminal256 -O style=$theme -g $1
  else
    echo -e "${CODE}" | pygmentize -f terminal256 -O style=$theme -l python -s  # with quote, no need to set $IFS
  fi
done
