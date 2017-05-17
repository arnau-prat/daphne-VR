import json
from channels import Group
from channels.auth import channel_session_user, channel_session_user_from_http

def ws_message(message):
    text = message.content["text"]
    msg = json.loads(text)

    if msg["event"] == "evaluate":
        print "Event evaluate"
        # Relay message to the visual interface
        Group("visual").send({"text":json.dumps({
            "type": "requestEvaluate"})})

    elif msg["event"] == "criticize":
        print "Event criticize"
        # Relay message to the visual interface
        Group("visual").send({"text":json.dumps({
            "type": "requestCriticize"})})

    elif msg["event"] == "other":
        print "Event other"

def ws_connect(message):
    # Accept the connection request
    message.reply_channel.send({"accept": True})
    # Add to the group
    Group("audio").add(message.reply_channel)

def ws_disconnect(message):
    # Remove from the group on clean disconnect
    Group("audio").discard(message.reply_channel)
