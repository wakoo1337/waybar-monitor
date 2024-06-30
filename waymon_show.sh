#!/bin/bash
VALUE=`cat ~/.waymon_num 2>/dev/null`
if [[ $? -ne 0 ]]; then
	VALUE=0;
fi
case $VALUE in
	0 ) cat /proc/stat | grep cpu | tail -1 | awk '{print "ЦП: " 100-(($5*100)/($2+$3+$4+$5+$6+$7+$8+$9+$10)) " %"}' ;;
	1 ) free -hL | awk '{print "ОЗУ: " $6 }' ;;
	2 ) cat /sys/class/thermal/thermal_zone5/temp | awk '{print ($1/1000) " °C" }' ;;
	3 ) paste /sys/class/power_supply/BAT0/capacity /sys/class/power_supply/BAT0/energy_now /sys/class/power_supply/BAT0/power_now | awk '{print "Батарея: " ($1) " % " ($2/$3) " ч"}';;
esac
