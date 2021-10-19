SHELL := /bin/bash

# NPF_CLUSTER?=dut=dut-100G,nic=0 reframer=reframer-100G,nic=0+1 client=client-100G,nic=0
NPF_CLUSTER?=dut=nslrack24,nic=0 reframer=nslrack10,nic=0+1 client=nslrack20,nic=0

OUTPUT_COLUMNS?=--output-columns x perc1 perc25 median perc75 perc99 --no-graph-time

FW_RULES?=$(CURDIR)/fw-rules

checkout_trace:
	mkdir -p trace
	mkdir -p results
	rm -rf trace/*
	rm -rf results/*
	i=1 ; while [[ $$i -le 25 ]] ; do \
	wget -P trace/ https://zenodo.org/record/5576176/files/synthetic-onedrive-sampled.dump-$$i ; \
	((i++)) ; \
	done

test_external:
	npf-compare \
	"local+chain,fw,nat,fc,router,reclass:Baseline" \
	"local+chain,fw,nat,fc,router,reclass,sf:Reframer-External" \
	--testie chain-pcap.testie \
	--cluster ${NPF_CLUSTER} \
	--tags promisc reframer dutmid \
	--config n_runs=1 \
	--variables trace=$(CURDIR)/trace/synthetic-onedrive-sampled.dump SFDELAY=64 rules=${FW_RULES}\
	--force-test --show-full --show-cmd \
	--graph-size 5 2.3 \
	--graph-filename $(CURDIR)/results/.pdf \
	--output ${OUTPUT_COLUMNS}

test_in_chain:
	npf-compare \
        "local+chain,fw,nat,fc,router,reclass:Baseline" \
        "local+chain,fw,nat,fc,router,reclass,sfmerge:Reframer-InChain" \
        --testie chain-pcap.testie \
        --cluster ${NPF_CLUSTER} \
        --tags promisc reframer dutmid \
        --config n_runs=1 \
        --variables trace=$(CURDIR)/trace/synthetic-onedrive-sampled.dump GEN_MULTI_TRACE=14 rules=${FW_RULES}\
        --force-test --show-full --show-cmd \
        --graph-size 5 2.3 \
        --graph-filename $(CURDIR)/results/.pdf \
        --output ${OUTPUT_COLUMNS}
