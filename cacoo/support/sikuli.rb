require 'rubygems'
require "xmlrpc/client"
require "inifile"

class Sikuli
	
	attr_accessor :cmd, :pid, :host, :port, :client
	
	def initialize(java,sikuli_path,project_path,project_name,host,port)
		@cmd = [ 
			java, 
			" -Dsikuli.console=true -Dsikuli.debug=0 -Xms64M -Xmx512M -Dfile.encoding=UTF-8 -jar ",
			sikuli_path,
			"/sikuli-ide.jar -s -r ",
			project_path,
			"/",
			project_name,
			" >> /tmp/sikuli.log 2>&1"
		].join
		
		@host = host
		@port = port
		
	end
	
	def start_server()
		@pid = fork do
			exec @cmd
		end
		Process.detach(@pid)
	end

	def stop_server()
		@client.call("quit")
	end
	
	def start_client()
		@client = XMLRPC::Client.new(host = @host, path = "/", port = @port)
	end
	
	def call(method)
		return @client.call(method)
	end
	
end
