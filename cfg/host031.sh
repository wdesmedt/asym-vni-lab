#!/bin/bash

for ns in 1 2 3 ; do 
	ip netns add ns$ns 
done
for i in 1 2 3 ; do 
	ip link add link eth1 eth1.$i type vlan id $i
	ip link set eth1.$i netns ns$i
	ip -n ns$i link set eth1.$i up
done
ip -n ns1 addr add 10.3.3.1/31 dev eth1.1
ip -n ns2 addr add 10.3.3.3/31 dev eth1.2
ip -n ns3 addr add 10.3.3.5/31 dev eth1.3
ip -n ns1 route add default via 10.3.3.0
ip -n ns2 route add default via 10.3.3.2
ip -n ns3 route add default via 10.3.3.4

