# Reframer
Reframer is a [FastClick](https://github.com/tbarbette/fastclick) based Network Function (NF) that leverages the idea of briefly buffering, delaying, and reordering the (possibly paced) incoming packets to increase spatial locality for network traffic. In a nutshell, Reframer consists of 3 components: *(i)* a **classifier** that arranges input packets to a flow table, *(ii)* a **scheduler** that flushes flows from the table after a given buffering time or upon achieving a given burst-size, and *(iii)* a **compressor** that coalesces packets to eliminate redundancy.

<p align="center">
<br>
<img src="ref-diagram.png" alt="Reframer working diagram" width="45%"/>
<br>
</p>

Reframer is developed on [FastClick](https://github.com/tbarbette/fastclick), but it could be adapted to other packet processing frameworks!

For more information check out our paper at NSDI '22.

## Download

```
git clone --recursive https://github.com/hamidgh09/Reframer.git
```

## Repository Organization

This repository contains information, experiment setups, and some of the results presented in our NSDI'22 paper. 


## Build & Run

## Citing our paper
If you use Reframer, please cite our paper:

```bibtex
@inproceedings {OM,
title = {Packet Order Matters! Improving Application Performance by Deliberately Delaying Packets},
booktitle = {19th {USENIX} Symposium on Networked Systems Design and Implementation ({NSDI} 22)},
year = {2022},
address = {Renton, WA},
url = {https://www.usenix.org/conference/nsdi22/presentation/ghasemirahni},
publisher = {{USENIX} Association},
month = apr,
}
```

## Help
If you have any question regarding the code or the paper you can contact me (hamidgr [at] k t h [dot] s e).
