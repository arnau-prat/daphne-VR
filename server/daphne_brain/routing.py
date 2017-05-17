from channels.routing import route
import visual_API.consumers as visual
import audio_API.consumers as audio

channel_routing = [
    route('websocket.receive', visual.ws_message, path=r"/websocket/visual"),
    route('websocket.connect', visual.ws_connect, path=r"/websocket/visual"),
    route('websocket.disconnect', visual.ws_disconnect, path=r"/websocket/visual"),

    route('websocket.receive', audio.ws_message, path=r"/websocket/audio"),
    route('websocket.connect', audio.ws_connect, path=r"/websocket/audio"),
    route('websocket.disconnect', audio.ws_disconnect, path=r"/websocket/audio"),
]
