require 'rubygems'
begin require 'rspec/expectations'; rescue LoadError; require 'spec/expectations'; end
require 'date'
require 'watir-webdriver'
require "xmlrpc/client"
require "inifile"
require "socket"

# base path
base_path = File.expand_path(File.dirname(__FILE__)+"/../")

# load parameters from ini file
params = IniFile.new(base_path+"/parameters.ini", :parameter => '=')

# browser
Browser = Watir::Browser.new(:firefox)
browser = Browser

# Sikuli XMLRPC server instance
SikuliCmd = [ 
	#"LC_NUMERIC=C ", 
	params['sikuli']['java'].to_s, 
	" -Dsikuli.console=true -Dsikuli.debug=0 -Xms64M -Xmx512M -Dfile.encoding=UTF-8 -jar ",
	params['sikuli']['path'].to_s,
	"/sikuli-ide.jar -s -r ",
	base_path,
	"/",
	params['sikuli']['project'],
	" > /dev/null 2>&1"
].join
@sikulipid = fork do
	# fork and exec sikuli process
	exec SikuliCmd
end
Process.detach(@sikulipid)
sleep 5

# Sikuli XMLRPC client
xmlrpc_host = params['sikuli']['xmlrpcHost']
xmlrpc_port = params['sikuli']['xmlrpcPort']
xmlrpc_client = XMLRPC::Client.new(host = xmlrpc_host, path = "/", port = xmlrpc_port)

# global
Before do |scenario|
    @browser = browser
    @Xmlrpc_client = xmlrpc_client
    @sc = scenario
end

at_exit do
    browser.close
    Process.kill('KILL',@sikulipid)
end
 
# performance data for cucumber-nagios
After do
    if MEASURE["time"] > -1
        MEASURES.push({@sc.name.gsub("'","") => MEASURE["time"]})
    end
    MEASURE["start"] = 0
    MEASURE["end"] = 0
    MEASURE["time"] = -1   
end
 
MEASURES = []
 
MEASURE = {
    "start" => 0,
    "end" => 0,
    "time" => -1
}
 
def startmeasure()
    MEASURE["start"]=Time.now
end
 
def endmeasure()
    MEASURE["end"]=Time.now
    MEASURE["time"]=(MEASURE["end"] - MEASURE["start"]).to_f
end
 
