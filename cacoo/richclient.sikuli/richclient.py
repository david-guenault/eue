from SimpleXMLRPCServer import SimpleXMLRPCServer as Server
import inspect
import sys
# server class
class SikuliServer(Server):
    # server loop   
    def serve_forever(self):
        self.quit = 0
        while not self.quit:
            self.handle_request()
 
def dump_error():
    print inspect.stack()
    print sys.exc_info()[0]
    print sys.exc_info()[1]
    print sys.exc_info()[2]
 
# scenario steps
def step_skeleton():
    try:
        result = wait("lnspecteurET.png",20)
        return 0
    except:
        #dump_error()        
        return 2
 
# exit function
def ext():
    srv.quit = True
    return 0
 
# launch server
try:
    srv = SikuliServer(("127.0.0.1", 1337))
    srv.register_function(step_skeleton)
    srv.register_function(ext,"quit")    
    srv.serve_forever()
except:
    dump_error()
    sys.exit(1)