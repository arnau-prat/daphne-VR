import json
from channels import Group
from channels.sessions import channel_session
from VASSAR import VASSAR
from CRITIC import CRITIC

# Instanciate VASSAR class
vassar = VASSAR.VASSAR()
# Instanciate CRITIC class
critic = CRITIC.CRITIC()
# Load EOSS_data file
lines = [line.rstrip() for line in open("EOSS_data.csv")]

k = -1

def generateID():
    global k
    k = k + 1
    return str(k)

@channel_session
def ws_message(message):
    msg = json.loads(message.content["text"])

    if msg["event"] == "register":
        print "Event register"
        message.reply_channel.send({"text": json.dumps({
            "type": "register", "id": message.channel_session["id"]})})

    elif msg["event"] == "initPoint":
        print "Event initPoint"
        i = msg["index"] + 1
        if i < len(lines):
            array = lines[i].split(":")
            message.reply_channel.send({"text": json.dumps({
                "type":"initPoint","index":i,
                "science":array[1],"cost":array[2],
                "architecture":json.loads(array[0])})})
        else:
            message.reply_channel.send({"text":json.dumps({
                "type": "initDone"})})

    elif msg["event"] == "evaluate":
        print "Event evaluate"
        # Get architecture
        architecture = msg["architecture"]
        # Evaluate architecture
        result = vassar.evaluateArch(architecture)
        # Send response
        print result
        message.reply_channel.send({"text": json.dumps({
            "type": "evaluate",
            "science": result[0], "cost": result[1]})})

    elif msg["event"] == "criticize":
        print "Event criticize"
        # Get architecture
        architecture = msg["architecture"]
        # Criticize architecture (based on rules)
        result1 = vassar.criticizeArch(architecture)
        # Criticize architecture (based on database)
        result2 = critic.criticizeArch(architecture)
        # Send response
        result = result1+result2
        print result
        message.reply_channel.send({"text": json.dumps({
            "type": "criticize", "data": result})})

    elif msg["event"] == "experiment":
        print "Event experiment"
        # Write experiment data
        filename = str("../../critic_experiment/res/%s.txt" % msg["id"])
        with open(filename, 'a+') as file:
            file.write(msg["data"])

    else:
        print msg

@channel_session
def ws_connect(message):
    # Accept connection
    message.reply_channel.send({"accept": True})
    # Assign unique session ID
    message.channel_session["id"] = generateID()
    # Add them to the right group
    Group("visual-{}".format( \
        message.channel_session["id"])).add(message.reply_channel)

@channel_session
def ws_disconnect(message):
    # Remove from the group on clean disconnect
    Group("visual-{}".format( \
        message.channel_session["id"])).discard(message.reply_channel)
