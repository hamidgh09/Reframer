# Reframer
Reframer is a [FastClick][Fastclick] based Network Function (NF) that leverages the idea of briefly buffering, delaying, and reordering the (possibly paced) incoming packets to increase spatial locality for network traffic. In a nutshell, Reframer consists of 3 components: *(i)* a **classifier** that arranges input packets to a flow table, *(ii)* a **scheduler** that flushes flows from the table after a given buffering time or upon achieving a given burst-size, and *(iii)* a **compressor** that coalesces packets to eliminate redundancy.

<p align="center">
<br>
<img src="ref-diagram.png" alt="Reframer working diagram" width="45%"/>
<br>
</p>

Reframer is developed on [FastClick][Fastclick], but it could be adapted to other packet processing frameworks!

For more information check out our [paper][om] at NSDI '22.

## Download

```
git clone --recursive https://github.com/hamidgh09/Reframer.git
```

## Repository Organization

This repository contains information, experiment setups, and some of the results presented in our NSDI'22 paper. More specifically:

- `experiments/motivation` contains [Fastclick][Fastclick] and [NPF][NPF] configuration files to run experiments that are disucssed in the section 2 of our paper.
- `experiments/Reframer` contains Fastclick and NPF configuration files for evaluating the impact of Reframer on a given trace file when packets path through a given chain of NFs. Read this file for more information about running experiments that are disucessed in the section 4 of our paper.
- `results/` contains all graphs that we have used in the paper along with [gnuplot][Gnuplot] configuration files that generate graphs from given `csv` files.

## Testbed

**NOTE: Before running the experiments, you need to prepare your testbed according to the following guidelines.**

All the experiments mainly require [Fastclick][Fastclick], [NPF][NPF], and Linux `perf` tool.
There is a simple bash script (setup_repo.sh) that could help you to clone/compile different repositories, but you should mainly rely on this README.md.

### Network Performance Framework (NPF) Tool
You can install [NPF][NPF] via the following command:

```bash
python3 -m pip install --user npf
```

**Do not forget to add `export PATH=$PATH:~/.local/bin` to `~/.bashrc` or `~/.zshrc`. Otherwise, you cannot run `npf-compare` and `npf-run` commands.** 

NPF will look for `cluster/` and `repo/` in your current working/testie directory. We have included the required `repo` for our experiments and a sample `cluster` template, available at `experiment/`. For more information about how to setup your cluster please check the [NPF guidelines][NPF-cluster].

NPF automatically clone and build FastClick for the experiments based on the testie/npf files.

### Data Plane Development Kit (DPDK)
We use DPDK to bypass kernel network stack in order to achieve line rate in our tests. To build DPDK, you can run the following commands:

```
git clone https://github.com/DPDK/dpdk.git
cd dpdk
git checkout v20.02
make install T=x86_64-native-linux-gcc
```
In case you want to use a newer (or different) version of DPDK, please check [DPDK documentation][dpdk-doc].

After building DPDK, you have to define `RTE_SDK` and `RTE_TARGET` by running the following commands:

```
export RTE_SDK=<your DPDK root directory>
export RTE_TARGET=x86_64-native-linux-gcc
```
Also, do not forget to setup hugepages. To do so, you can modify `GRUB_CMDLINE_LINUX` variable in `/etc/default/grub` file similar to the following configuration:

```
GRUB_CMDLINE_LINUX="isolcpus=0,1,2,3,4,5,6,7,8,9 iommu=pt intel_iommu=on default_hugepagesz=1G hugepagesz=1G hugepages=32 acpi=on selinux=0 audit=0 nosoftlockup processor.max_cstate=1 intel_idle.max_cstate=0 intel_pstate=on nopti nospec_store_bypass_disable nospectre_v2 nospectre_v1 nospec l1tf=off netcfg/do_not_use_netplan=true mitigations=off"
```
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



[FastClick]: https://github.com/tbarbette/fastclick
[NPF]: https://github.com/tbarbette/npf
[Gnuplot]: http://www.gnuplot.info/
[NPF-cluster]: https://github.com/tbarbette/npf/blob/master/cluster/README.md
[dpdk-doc]: https://doc.dpdk.org/guides/linux_gsg/index.html
[om]: https://www.usenix.org/conference/nsdi22/presentation/ghasemirahni
