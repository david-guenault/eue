require 'rubygems'
begin require 'rspec/expectations'; rescue LoadError; require 'spec/expectations'; end
require 'date'
require 'watir-webdriver'
require 'support/sikuli'

# base path
base_path = File.expand_path(File.dirname(__FILE__)+"/../")

# load params from ini file
params = IniFile.new(base_path+"/parameters.ini", :parameter => '=')

# browser
Browser = Watir::Browser.new(:firefox)
browser = Browser

# Sikuli XMLRPC server and client instance
sk = Sikuli.new(params['sikuli']['java'],params['sikuli']['path'],base_path,params['sikuli']['project'],params['sikuli']['host'],params['sikuli']['port'])
sk.start_server
sk.start_client

# global
Before do |scenario|
    @browser = browser
    @sc = scenario
    @sikuli = sk
end

at_exit do
    browser.close
    sk.stop_server
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
 
