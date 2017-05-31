import re
import json
import websocket

in_filename = "data2.csv"
out_filename = "critic.csv"
lines = [line.rstrip() for line in open(in_filename)]

f = open(out_filename, 'w')

address = "wss://www.selva-research.com/websocket/visual"
ws = websocket.create_connection(address)

for line in lines:
    array = line.split(":")
    #Get architecture
    architecture = array[0]
    # Send request criticize
    msg = {"event":"criticize","architecture":json.loads(architecture)};
    ws.send(json.dumps(msg))
    # Receive response
    result = json.loads( ws.recv())
    # Get data
    data = result["data"]
    # Compute critic performance
    nrules = 0
    ninstr = 0.0
    smiss = 0.0
    for d in data:
        if d[0] == "rules":
            nrules += 1
        if d[0] == "database1":
            results = re.findall(': ([\d.]+) matches', d[1])
            ninstr += float(results[0]) # Divide number of instruments
        if d[0] == "database2":
            results = re.findall('score: ([\d.]+)', d[1])
            smiss += float(results[0]) # Divide number of missions
    arch = json.loads(architecture)
    instr = 0
    miss = 0
    for o in range(len(arch)):
        instr += len(arch[o])
        if arch[o] != "":
            miss += 1
    # Normalize results
    ninstr = ninstr/instr
    smiss = smiss/miss
    # Result
    result = array[0]+':'+array[1]+':'+array[2]+':'+str(nrules)+':'+str(ninstr)+':'+str(smiss)+'\n'
    print result
    # Write to output file
    f.write(result)
f.close()
