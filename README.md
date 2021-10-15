# Reframer
Reframer is a [FastClick][Fastclick] based Network Function (NF) that leverages the idea of briefly buffering, delaying, and reordering the (possibly paced) incoming packets to increase spatial locality for network traffic. In a nutshell, Reframer consists of 3 components: *(i)* a **classifier** that arranges input packets to a flow table, *(ii)* a **scheduler** that flushes flows from the table after a given buffering time or upon achieving a given burst-size, and *(iii)* a **compressor** that coalesces packets to eliminate redundancy.

<p align="center">
<br>
<img src="ref-diagram.png" alt="Reframer working diagram" width="45%"/>
<br>
</p>

Reframer is developed on [FastClick][Fastclick], but it could be adapted to other packet processing frameworks!

For more information check out our paper at NSDI '22.

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
