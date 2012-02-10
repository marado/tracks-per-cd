#!/bin/env bash
wget -o /dev/null --user-agent="Firefox" "http://www.discogs.com/explore?fmt=CD&decade=2010&year=2011" -O sample
grep \/release\/[0123456789] sample -A1 |grep "(CD" -B1|grep release|cut -d\" -f2|sort -u > releases
for i in `seq 1 $(cat releases|wc -l)`; do wget -o /dev/null -O $i.txt --user-agent="Firefox" http://www.discogs.com/$(head -n$i releases|tail -1); done
echo "Medium:" > result
echo "$(for i in `ls *txt`; do echo -n "$(grep "<td class=\"track\"" $i|wc -l)+"; done|sed 's/\+$/\n/'|bc)/$(ls *txt|wc -l)"|bc >> result
cat result
