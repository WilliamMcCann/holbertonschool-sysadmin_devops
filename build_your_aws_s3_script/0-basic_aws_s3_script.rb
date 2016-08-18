#!/usr/bin/ruby

require 'rubygems'
require 'aws-sdk'
require 'yaml'
require 'optparse'

#config files links to config info in the YAML file
config = YAML.load_file('config.yaml')
access_key_id = config['access_key_id']
secret_access_key = config['secret_access_key']
region = config['region']

#test printing
test_var = 'testing string 1'
puts test_var
puts 'testing string 2'
puts region

#creates bucket
#s3 = Aws::S3::Client.new(region: region, access_key_id: access_key_id, secret_access_key: secret_access_key)
#s3.create_bucket(bucket: 'williammccanntestbucket')



# #option parsing
# options = {}
#
# optparse = OptionParser.new do|opts|
#   opts.banner = "Usage: 0-basic_aws_s3_script.rb [options]"
#
#   options[:verbose] = false
#   opts.on( '-v', '--verbose', 'Run verbosely' ) do
#     options[:verbose] = true
#   end
#
#   options[:bucketname] = false
#   opts.on( "-b", "--bucketname=BUCKET_NAME", "Name of the bucket to perform the action on" ) do
#     options[:bucketname] = true
#   end
#
#   options[:filepath] = false
#   opts.on( "-f", "--filepath=FILE_PATH", "Path to the file to upload" ) do
#     options[:filepath] = true
#   end
#
#   #need to figure out how to implement multiple parameters here
#   options[:action] = nil
#   opts.on( "-a", "--action=ACTION", "Select action to perform [list, upload, delete, download]" ) do|file|
#     options[:action] = file
#   end
#
#   opts.on("-h", "--help", "Show this message") do
#     puts opts
#     exit
#   end
# end
#
# optparse.parse!


Options = Struct.new(:name)

class Parser
  def self.parse(options)
    args = Options.new("world")

    opt_parser = OptionParser.new do |opts|
      opts.banner = "Usage: 0-basic_aws_s3_script.rb [options]"

      opts.on("-v", "--verbose", "Run verbosely") do |n|
        args.action = v
      end

      opts.on("-b", "--bucketname=BUCKET_NAME", "Name of the bucket to perform the action on") do |n|
        args.action = b
      end

      opts.on("-f", "--filepath=FILE_PATH", "Path to the file to upload") do |n|
        args.action = f
      end

      opts.on("-a", "--action=ACTION", "Select action to perform [list, upload, delete, download]") do |n|
        args.action = a
      end

      opts.on("-h", "--help", "Show this message") do
        puts opts
        exit
      end
    end

    opt_parser.parse!(options)
    return args
  end
end
options = Parser.parse %w[--help]
