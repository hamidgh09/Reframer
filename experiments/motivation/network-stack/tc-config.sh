#!/bin/bash

interleave=$1
minburst=$2
ifname=$3
echo "sudo tc qdisc del dev $ifname root"
echo "sudo tc qdisc add dev $ifname root handle 1: htb default 20"
echo "sudo tc class add dev $ifname parent 1: classid 1:1 htb rate 8gbit ceil 8gbit"
echo "sudo tc class add dev $ifname parent 1:1 classid 1:10 htb rate 8gbit ceil 8gbit"
echo "sudo tc class add dev $ifname parent 1:1 classid 1:20 htb rate 1mbit ceil 1mbit"
echo "sudo tc qdisc add dev $ifname parent 1:10 handle 2: drr"

for i in {1..256}
do
	h=$(printf "%x\n" $i)
	echo "sudo tc class add dev $ifname parent 2: classid 2:$h drr quantum $interleave"
	echo "sudo tc qdisc add dev $ifname parent 2:$h tbf rate 600mbit burst 10240kbit latency 10ms minburst $minburst peakrate 40960mbit"
done

echo "sudo tc filter add dev $ifname protocol ip parent 1:0 prio 1 u32 match ip dport 8224 0xffff classid 1:10"
echo "sudo tc filter add dev $ifname protocol ip parent 2:0 prio 1 handle 30 flow hash keys proto-src divisor 256"
