SHELL := /bin/bash

# NPF_CLUSTER?=dut=dut-100G,nic=0 reframer=reframer-100G,nic=0+1 client=client-100G,nic=0
NPF_CLUSTER?=dut=nslrack24,nic=0 reframer=nslrack10,nic=0+1 client=nslrack20,nic=0

checkout_trace:
	mkdir -p trace
	rm -rf trace/*
	i=1 ; while [[ $$i -le 25 ]] ; do \
	wget -P trace/ https://zenodo.org/record/5576176/files/synthetic-onedrive-sampled.dump-$$i ; \
	((i++)) ; \
	done

test_external:
	npf-compare "local+chain,fw,nat,fc,router,reclass:Baseline" "local+chain,fw,nat,fc,router,reclass,sf:Reframer" --testie chain-pcap.testie --cluster ${NPF_CLUSTER} --tags promisc reframer dutmid --config n_runs=1 --variables trace=$(CURDIR)/trace/bin-final.dump GEN_MULTI_TRACE=15 --force-test --show-full --show-cmd
