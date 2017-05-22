import websocket
import json

in_filename = "data.csv"
out_filename = "data1.csv"
lines = [line.rstrip() for line in open(in_filename)]

f = open(out_filename, 'w')

address = "ws://52.14.7.76/websocket/visual"
ws = websocket.create_connection(address)

instruments = ['A','B','C','D','E','F','G','H','I','J','K','L']

lines = lines

for line in lines:
    array = line.split(",")
    #Get architecture
    architecture = '["'
    for j in range(0,5):
        for i in range(0, 12):
            if array[0][i+j*12] == '1':
                architecture += instruments[i]
        if j < 4:
            architecture += '","'
    architecture += '"]'
    # Send request evaluate
    msg = {"event":"evaluate","architecture":json.loads(architecture)};
    ws.send(json.dumps(msg))
    # Receive response
    result = json.loads( ws.recv())
    # Get science
    science = str(result["science"])
    # Get cost
    cost = str(result["cost"])
    # Result
    result = architecture+':'+science+':'+cost+'\n'
    print result
    # Write to output file
    f.write(result)
f.close()
