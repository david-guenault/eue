from SimpleXMLRPCServer import SimpleXMLRPCServer as Server
import inspect
import os
import sys
import ConfigParser

# base path
base_path = os.path.realpath(os.path.dirname(sys.argv[0])+"/../")

# read config
config = ConfigParser.RawConfigParser()
config.read(base_path+"/parameters.ini")
host = config.get("sikuli","host")
port = config.getint("sikuli","port")
timeout = config.getint("sikuli","timeout") 

# server class
class SikuliServer(Server):
    # server loop   
    def serve_forever(self):
        self.quit = 0
        while not self.quit:
            self.handle_request()
        print "request to exit" 
        sys.exit(0)
 
def dump_error():
    print inspect.stack()
    print sys.exc_info()[0]
    print sys.exc_info()[1]
    print sys.exc_info()[2]
 
# scenario steps
def step_skeleton():
    try:
        result = wait("lnspecteurET.png",timeout)
        return 0
    except:
        #dump_error()        
        return 2

def check_inspecteur():
    print "check_inspecteur" 
    try:
        wait("ElnspecteurT.png",timeout)
        waitVanish("chargement_en_cours.png",timeout)
        return 0
    except:
        #dump_error()        
        return 2

def close_schema():
    print "close_schema"     
    try:
        click("Enregisireme.png")
        wait("1333281993500.png",timeout)
        click(Pattern("1333281993500.png").targetOffset(33,7))
        wait("HLESmmgLschm.png",timeout)
        click(Pattern("weaww2mugEnr.png").targetOffset(180,0))
        return 0
    except:
        #dump_error()        
        return 2

def check_schema_closed():
    print "check_schema_closed"     
    try:
        waitVanish("sagIIIEIIIA1.png",timeout)
        return 0
    except:
        #dump_error()        
        return 2

def validate_empty_trash():
    print "validate_empty_trash"
    try:
        wait("1333281566104.png",timeout)
        click("1333281566104.png")
        return 0
    except:
        #dump_error()        
        return 2

# exit function
def ext():
    print "exit"
    srv.quit = True
    return 0
 
# launch server
try:
    srv = SikuliServer((host, port))
    srv.register_function(step_skeleton)
    srv.register_function(check_inspecteur)
    srv.register_function(close_schema)
    srv.register_function(check_schema_closed) 
    srv.register_function(validate_empty_trash)
    srv.register_function(ext,"quit")    
    srv.serve_forever()
except:
    dump_error()
    sys.exit(1)
sys.exit(0)