#!/bin/bash


# This script creates an htb qdisc on top of 256 sub tbf queue disciplines to shape outgoing packets according to a given SLF value. 
# Note that, the maximum sending rate is limited to 8Gbps as forcing a real TCP stack to exhibit a specific SLF at high speeds is extremely hard.

# INPUT VALUES:
# interleave = SLF * PACKETS_SIZE_IN_BYTE
# minburst = Minimum burst size for tbf qdisc. You can set it to a value more than PACKETS_SIZE_IN_BYTE (e.g., if packets size is 1500, minburst=1700 would be fine!).
# ifname = Interface name

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
