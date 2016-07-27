#!/bin/bash
# ------------------------------------------------------------------
# Tanky Woo (2016-07-27)
# Show 256 colors under terminal
# Ref: http://misc.flogisoft.com/bash/tip_colors_and_formatting
# ------------------------------------------------------------------

for fb in 38 48; do  # fg with 38 or bg with 48
  for code in {0..255}; do  # 256-colors
    printf "\e[%s;05;%sm%-4s\e[0m " "${fb}" "${code}" "${code}"
    if ! (( ( $code + 1 ) % 16 )); then
      echo  # or `echo -n -e '\n'`
    fi
  done
  echo -n -e "\n\n"
done
