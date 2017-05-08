#!/usr/bin/env python

from tornado.options import options, define, parse_command_line
import tornado.httpserver
import tornado.ioloop
import tornado.web
import tornado.wsgi
import tornado.websocket
import json
import time

from  VASSAR.java.bin import VASSAR

define('port', type=int, default=8888)

vassar = VASSAR.VASSAR()

def websocket_manager():
    print "Websocket Manager initialized correctly\n"

    tornado_app = tornado.web.Application([
        ('/websocket', webSocket)
    ])

    server = tornado.httpserver.HTTPServer(tornado_app)
    server.listen(options.port)
    tornado.ioloop.IOLoop.instance().start()

class webSocket(tornado.websocket.WebSocketHandler):

    clients = []
    webpage = False

    def check_origin(self, origin):
        return True

    def open(self):
        print "WebSocket opened"
        webSocket.clients.append(self)

    def on_message(self, message):
        print "msg recevied", message
	msg = json.loads(message)
        if msg["event"] == "register":
            print "Event register"
            self.webpage = True
            filename = "EOSS_data.csv"
            lines = [line.rstrip() for line in open(filename)]
            for line in lines:
	        print "Init Point"
                array = line.split(":")
                science = str(array[1])
                cost = str(array[2])
                architecture = str(array[0])
                msg = json.loads('{"type":"init","science":'+
                    science+',"cost":'+cost+',"architecture":'+architecture+'}')
                self.write_message(msg)
            #Send response
            msg = {}
            msg["type"] = "done"
            self.write_message(msg)
        elif msg["event"] == "evaluate":
            print "Event evaluate"
            # Get architecture
            architecture = msg["architecture"]
            # Evaluate architecture
            result = vassar.evaluateArch(architecture)
            # Send response
            msg = {}
            msg["science"] = result[0]
            msg["cost"] = result[1]
            self.write_message(msg)
        elif msg["event"] == "criticize":
            print "Event criticize"
            # Request architectures from VRs
            msg = {}
            msg["type"] = "requestCriticize"
            for c in webSocket.clients:
                if c.webpage == True:
                    print "Write requestCriticize"
                    c.write_message(msg)
        elif msg["event"] == "responseCriticize":
            print "Event responseCriticize"
            # Get architecture
            architecture = msg["architecture"]
            # Criticize architecture
            result = vassar.criticizeArch(architecture)
            # Send response
            print result
            msg = {}
            msg["type"] = "criticize"
            msg["data"] = result
            self.write_message(msg)

    def on_close(self):
        print "WebSocket closed"
        webSocket.clients.remove(self)

def main():

    websocket_manager()

    #tornado_app = tornado.web.Application([
    #    ('/websocket', webSocket)
    #])

    #server = tornado.httpserver.HTTPServer(tornado_app)
    #server.listen(options.port)
    #tornado.ioloop.IOLoop.instance().start()

if __name__ == '__main__':
  main()
