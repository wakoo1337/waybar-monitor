#!/bin/bash
VALUE=`cat ~/.waymon_num 2>/dev/null`
if [[ $? -ne 0 ]]; then
	VALUE=0;
fi
case $VALUE in
	0 ) grep cpu /proc/stat | tail -1 | awk '{print "ЦП: " 100-(($5*100)/($2+$3+$4+$5+$6+$7+$8+$9+$10)) " %"}' ;;
	1 ) grep cpu\ MHz /proc/cpuinfo | awk ' BEGIN { sum_freq=0; cores=0 } {(cores++); (sum_freq += $(NF)) } END {print (sum_freq / cores) " МГц"}' ;;
	2 ) free -kL | awk '{print "ОЗУ: " (($6 > 1048576)?(($6/1048576) " ГБ"):(($6 / 1024) " МБ")) }' ;;
	3 ) cat /sys/class/thermal/thermal_zone5/temp | awk '{print ($1/1000) " °C" }' ;;
	4 ) paste /sys/class/power_supply/BAT0/capacity /sys/class/power_supply/BAT0/energy_now /sys/class/power_supply/BAT0/power_now | awk '{print "Батарея: " ($1) " %" ($3 != 0?" " ($2/$3) " ч":"") }' ;;
esac

