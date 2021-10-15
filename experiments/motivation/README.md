## Synthetic Experiments (Motivation)

This directory contains some NPF configuration files that we used to show the impact of packets locality on network applications, Linux kernel stack, and kernel based OpenVSwitch (OVS).

### TestBed

To run these experiments you need two servers connected back to back to each other.
One of the servers acts as a client that sends packets toward the second server. 
The other server acts as a server that processes incoming packets. We evaluate the impact of various Spatial Locality Factors (SLF) on the performance of this machine!
We call this server the Device Under Test (DUT).

**Please note that you need to have NPF and DPDK configured on both servers according to the [testbed guideline][testbed-guide]**

### Experiments Run

- **Network Functions' Effects:** 
In this experiment the client generates a synthetic trace file with various Spatial Locality Factors (SLF) to evaluate the impact of packets locality on performance of two different network functions (a NAT and a Firewall). 
You can use `make network-functions` to run this experiment. 

- **Network Stack Effects:** This experiment shows the impact of packets locality (SLF) on performance of Linux kernel networking stack!
We use `iperf` to make hundreds of parallel TCP connection between the client and DUT. We also modify the default Linux `tc` queuing discipline to form the desired SLF value. You can use `make network-stack` to run this experiment.

[testbed-guide]: https://github.com/hamidgh09/Reframer/blob/main/README.md#testbed
