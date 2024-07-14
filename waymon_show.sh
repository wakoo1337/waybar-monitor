#!/bin/bash
VALUE=`cat ~/.waymon_num 2>/dev/null`
if [[ $? -ne 0 ]]; then
	VALUE=0;
fi
case $VALUE in
	0 ) grep cpu /proc/stat | tail -1 | awk '{print "ЦП: " 100-(($5*100)/($2+$3+$4+$5+$6+$7+$8+$9+$10)) " %"}' ;;
	1 ) grep cpu\ MHz /proc/cpuinfo | awk ' BEGIN { sum_freq=0; cores=0 } {(cores++); (sum_freq += $(NF)) } END {print (sum_freq / cores) " МГц"}' ;;
	2 ) awk 'BEGIN { total = 0;avail=0 } { if ($1 == "MemTotal:") total=$2 ; if ($1 == "MemAvailable:") avail=$2 } END {print "ОЗУ: " (((total-avail) >= 1048576) ? ((total-avail)/1048576 " ГБ") : ((total-avail)/1024 " МБ")) } ' /proc/meminfo ;;
	3 ) cat /sys/class/thermal/thermal_zone0/temp | awk '{print ($1/1000) " °C" }' ;;
esac

