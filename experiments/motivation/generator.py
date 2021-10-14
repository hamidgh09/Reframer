import math
import random
import sys


ips = []


def generate_traces(client, limit, proto, plength, interleave, flows_per_client, pkt_per_flow, file_location, trace_loc, src_eth, dst_eth, dst_ip, trace_name=None):

    for c in range(client):
        done=False
        while not done:
            p1 = 10
            p2 = 0
            p1 = random.randrange(1, 255)
            p2 = random.randrange(1, 255)
            p3 = random.randrange(1, 255)
            p4 = random.randrange(1, 255)

            src = str(p1) +"."+ str(p2) +"."+ str(p3) +"."+ str(p4)
            if not ips.__contains__(src):
                done=True

        ips.append(src)

    if trace_name is None:
        trace_name = trace_loc + "/trace-" + proto + "-C" + str(client) + "-I" + str(interleave) + "-F" + str(flows_per_client) + ".pcap"
    file_name = "generator" + str(interleave) + ".click"
    file = open(file_location + file_name , "w+")
    file.write('td :: ToDump("' + trace_name + '");\n')
    file.write('rr :: RoundRobinMultiSched(N ' + str(interleave) + ') -> Unqueue -> td;\n')

    random.shuffle(ips)
    for c in range(client):
        file.write(
            "Fast" + proto + "Flows(RATE 0, LENGTH " + str(plength) + ", LIMIT "+ str(int(limit/client)) +", SRCETH "+ src_eth +", SRCIP " + ips[c] +
            ", DSTETH "+dst_eth+", DSTIP "+dst_ip+", FLOWS "+flows_per_client+", FLOWSIZE "+pkt_per_flow+", STOP true)"
            " -> NumberPacket(OFFSET 52) -> [" + str(c) + "]rr;\n"
        )

    file.close()
    print("trace configurations generated: " + file_location + file_name)
    return


def generate_rules(client, rules_file):

    print("generating rules...")
    additional = 10000 - client
    for c in range(additional):
        done=False
        while not done:
            p1 = random.randrange(1, 255)
            p2 = random.randrange(1, 255)
            p3 = random.randrange(1, 255)
            p4 = random.randrange(1, 255)

            src = str(p1) +"."+ str(p2) +"."+ str(p3) +"."+ str(p4)
            if not ips.__contains__(src):
                done=True

        ips.append(src)

    rules = ""
    for ip in ips:
        rules = rules + "allow src net " + ip + "/32 \n"

    rules = rules + "1 all"
    file = open(rules_file, "w+")
    file.write(rules)
    file.close()
    print("rules generated ... :)")


if __name__ == '__main__':

    # generate firewall rules file
    gen_rules = False

    # Firewall rules file
    rules_file = "/home/hamid/npf/npf/test"

    # number of clients
    client = 2048

    # total number of packets
    limit = 320000

    # protocol
    proto = "UDP"

    # I list
    interleave = 1

    flows_per_client = 1

    pkt_per_flow = 32

    plength = 64

    file_location = ""

    trace_loc = "/mnt/traces/synthetic"

    # network params
    src_eth = ""
    dst_eth = ""
    dst_ip = ""

    trace_name=None

    i=0
    while i < len(sys.argv):
        arg = sys.argv[i]
        if arg == "-interleave":
            interleave = int(sys.argv[i+1])
        if arg == "--print-rules":
            gen_rules=True
        if arg == "-clients":
            client = int(sys.argv[i+1])
        if arg == "-conf-loc":
            file_location = sys.argv[i+1]
        if arg == "-trace-loc":
            trace_loc = sys.argv[i+1]
        if arg == "-plength":
            plength = sys.argv[i+1]
        if arg == "-client-flows":
            flows_per_client = sys.argv[i+1]
        if arg == "-pkt-per-flow":
            pkt_per_flow = sys.argv[i+1]
        if arg == "-rules-file":
            rules_file = sys.argv[i+1]
        if arg == "-limit":
            limit = int(sys.argv[i+1])
        if arg == "-src-eth":
            src_eth = sys.argv[i+1]
        if arg == "-dst-eth":
            dst_eth = sys.argv[i+1]
        if arg == "-dst-ip":
            dst_ip = sys.argv[i+1]
        if arg == "-trace-name":
            trace_name = sys.argv[i+1]
        i=i+1

    print("files location is: " + file_location)
    print("number of clients is: " + str(client))
    print("packets length is: " + str(plength))
    print("rules file is: " + str(rules_file))

    generate_traces(client, limit, proto, plength, interleave, flows_per_client, pkt_per_flow, file_location, trace_loc, src_eth, dst_eth, dst_ip, trace_name)
    if gen_rules:
        generate_rules(client, rules_file)
