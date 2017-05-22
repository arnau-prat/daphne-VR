#!/usr/bin/python

import time
import websocket

def main():
    address = "ws://52.14.7.76/websocket/audio"
    ws = websocket.create_connection(address)
    msg = '{"event":"criticize"}'
    print 'Sending message: '+msg
    ws.send(msg)
    ws.close()

if __name__ == "__main__":
    main()


