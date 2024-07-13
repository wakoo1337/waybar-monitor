#!/bin/bash
MODULO=5
echo $(((`cat ~/.waymon_num 2>/dev/null` + 1) % $MODULO )) > ~/.waymon_num
