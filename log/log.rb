#!/usr/bin/env ruby
# ログ

require 'logger'
logger = Logger.new('./../log/logfile.log')
logger.level = Logger::WARN
logger.debug("Created logger")
logger.info("Program started")
logger.warn("Nothing to do!")

begin
  File.foreach(path) do |line|
    unless line =~ /^(\w+) = (.*)$/
      logger.error("Line in wrong format: #{line.chomp}")
    end
  end
rescue => err
  logger.fatal("Caught exception; exiting")
  logger.fatal(err)
end
