begin
  require 'trinidad'
rescue LoadError => e
  require('rubygems') && retry
  raise e
end

module Trinidad
  module Daemon

    def init
    end

    # checked from com.msp.jsvc.JRubyDaemon.init
    # as Trinidad::Daemon#setup? to check whether
    # daemon's init setup has been succesful ...
    def setup?
      true
    end

    # called from com.msp.jsvc.JRubyDaemon.start
    # as Trinidad::Daemon#start
    def start(args = ARGV)
      if Trinidad.const_defined?(:CLI)
        Trinidad::CLI.parse(args)
      else # backwards (< 1.5) compatibility :
        Trinidad::CommandLineParser.parse(args)
      end
      Trinidad.configuration.trap = false
      
      @server = Trinidad::Server.new
      @server.start
    end

    # called from com.msp.jsvc.JRubyDaemon.stop
    # as Trinidad::Daemon#stop
    def stop
      @server.stop
    end

    extend self
  end
end

Trinidad::Daemon.init
