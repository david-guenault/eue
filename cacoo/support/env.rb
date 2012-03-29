require 'rubygems'
begin require 'rspec/expectations'; rescue LoadError; require 'spec/expectations'; end
require 'date'
require 'watir-webdriver'
 
# Téléchargement des exemples sur github
 
# browser
Browser = Watir::Browser.new(:firefox)
browser = Browser
 
# global
Before do |scenario|
    @browser = browser
    @sc = scenario
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
 
# "after all"
at_exit do
    browser.close
end
