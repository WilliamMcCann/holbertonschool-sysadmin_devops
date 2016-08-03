#!/usr/bin/ruby

require 'rubygems'
require 'aws-sdk'
require 'yaml'
require 'optparse'

#config files links to config info in the YAML file
config = YAML.load_file('config.yaml')
access_key_id = config['access_key_id']
secret_access_key = config['secret_access_key']
key_pair = config['key_pair']
image_id = config['image_id']
instance_type = config['instance_type']
availabilityZone = config['availability-zone']
security_group_ids = config['security_group_ids']

#test printing
test_var = 'testing string 1'
puts test_var
puts 'testing string 2'
puts security_group_ids

#actual code
class EC2Instance
  def initialize instance_id
    @aws_i = AWS.ec2.instances[instance_id]
  end

  def start
    @aws_i.start
    sleep 3 until @aws_i.status == :running
    puts "Instance #{@aws_i.tags['Name']} is running"
  end

  def stop
    if @aws_i.status == :stopped
      puts "Instance #{@aws_i.tags['Name']} was already stopped"
      return
    else
      @aws_i.stop
      sleep 3 until @aws_i.status == :stopped
      puts "Instance #{@aws_i.tags['Name']} stopped"
    end
  end

  def status
    puts "Instance #{@aws_i.tags['Name']} is #{@aws_i.status}"
  end
end

#option parsing
Options = Struct.new(:name)

class Parser
  def self.parse(options)
    args = Options.new("world")

    opt_parser = OptionParser.new do |opts|
      opts.banner = "Usage: 0_manage_ec2_instances.rb [options]"

      opts.on("-a", "--action", "Action") do |n|
        args.action = a
      end

      opts.on("-i", "--server_id", "Server ID") do |n|
        args.action = i
      end

      opts.on("-v", "--verbose", "Verbose") do |n|
        args.action = v
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
















# options = {}
# OptionParser.new do |opts|
#   opts.banner = "Usage: 0_manage_ec2_instances.rb [options]"
#
#   opts.on('-i', '--instances INSTANCES_FILE', '=MANDATORY', 'File containing instances') { |v| options[:instances] = v }
#   opts.on('--start',  'Start the instances') { |v| options[:start] = v }
#   opts.on('--stop',   'Stop the instances') { |v| options[:stop]  = v }
#   opts.on('--status', 'Retrieve the status of the instances')  { |v| options[:status]  = v }
# end.parse!
