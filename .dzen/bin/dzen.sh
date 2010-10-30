#!/bin/sh

date_format='%a %b %d %H:%M'
icons="/home/mytoh/.dzen/icons"
byte=`expr 1024 \* 1024`
interval=2


while :; do
  date=`date +"${date_format}"`

  cpu=`top -b -d 2 | grep ^CPU | gawk '{print $2,$6}'`

  rx=`bwm-ng -o plain -c 1 -I em0 -t 1 -T avg| grep em0 | gawk '{print $2,$3}'`

  tx=`bwm-ng -o plain -c 1 -I em0 -t 1 -T avg| grep em0 | gawk '{print $4,$5}'`

  free=`sysctl -n vm.stats.vm.v_free_count` 
  count=`sysctl -n vm.stats.vm.v_page_count`
  size=`sysctl -n hw.pagesize`
  freemem=`expr ${free} \* ${size} / ${byte}`

  echo "^i(${icons}/cpu.xbm) ${cpu} ^i(${icons}/mem.xbm) ${freemem}M  ^i(${icons}/net_up_02.xbm) ${tx} ^i(${icons}/net_down_02.xbm) ${rx}    ^i(${icons}/cat.xbm) ${date}"

  sleep ${interval}

done | dzen2 -p -ta r -x 400 -y 0 -w 880 -h 12 -fn '-adobe-helvetica-medium-r-normal--11-*' -e 'onexit=ungrabmouse'

