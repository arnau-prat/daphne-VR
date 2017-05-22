import json
import time
from channels import Group
from channels.auth import channel_session_user, channel_session_user_from_http
from VASSAR import VASSAR
from CRITIC import CRITIC

# Instanciate VASSAR class
vassar = VASSAR.VASSAR()
# Instanciate CRITIC class
critic = CRITIC.CRITIC()
# Load EOSS_data file
lines = [line.rstrip() for line in open("EOSS_data.csv")]

def ws_message(message):
    text = message.content["text"]
    msg = json.loads(text)

    if msg["event"] == "register":
        print "Event register"
        message.reply_channel.send({"text": json.dumps({
            "type": "register"})})

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
        # Criticize architecture (based on database
        result2 = critic.criticizeArch(architecture)
        # Send response
        result = result1+result2
        print result
        message.reply_channel.send({"text": json.dumps({
            "type": "criticize", "data": result})})

    else:
        print msg

def ws_connect(message):
    # Accept the connection request
    message.reply_channel.send({"accept": True})
    # Add to the group
    Group("visual").add(message.reply_channel)

def ws_disconnect(message):
    # Remove from the group on clean disconnect
    Group("visual").discard(message.reply_channel)
