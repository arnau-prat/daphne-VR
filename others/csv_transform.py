import random

in_filename = "EOSS_data.csv"
out_filename = "EOSS_data1.csv"
lines = [line.rstrip() for line in open(in_filename)]

f = open(out_filename, 'w')

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
    # Get science
    science = array[1]
    # Get cost
    cost = array[2]
    # Result
    result = architecture+':'+science+':'+cost+'\n'
    # Write to output file and get rid of some points

    if float(cost) > 8000:
        print "Nothing"
    elif float(cost) > 2000 and float(science) < 0.2:
        print "Bad"
	if random.uniform(0.0,1.0) < 0.05:
            f.write(result)
    else:
        print "Good"
        if random.uniform(0.0,1.0) < 0.1:
           f.write(result)
f.close()
