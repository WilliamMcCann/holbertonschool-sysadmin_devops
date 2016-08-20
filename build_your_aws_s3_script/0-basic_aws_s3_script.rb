#!/usr/bin/ruby
# encoding: utf-8

require 'rubygems'
require 'aws-sdk'
require 'yaml'
require 'optparse'

#config files links to config info in the YAML file
config = YAML.load_file('config.yaml')
access_key_id = config['access_key_id']
secret_access_key = config['secret_access_key']
region = config['region']

# create AWS Client
# s3_client = Aws::S3::Client.new(
#                             region: region,
#                             access_key_id: access_key_id,
#                             secret_access_key: secret_access_key
#                          )

#create AWS Resource
s3_resource = Aws::S3::Resource.new(
                            region: region,
                            access_key_id: access_key_id,
                            secret_access_key: secret_access_key
                          )

# #test printing
# test_var = 'testing string 1'
# puts test_var
# puts 'testing string 2'
# puts region

#creates bucket
#s3 = Aws::S3::Client.new(region: region, access_key_id: access_key_id, secret_access_key: secret_access_key)
#s3.create_bucket(bucket: 'williammccanntestbucket')

#option parsing
options = {}

OptionParser.new do |opts|
  opts.banner = "Usage: 0-basic_aws_s3_script.rb [options]"

  opts.separator ""
  opts.separator "Specific options:"

  opts.on( '-v', '--verbose', 'Run verbosely' ) do |v|
    options[:verbose] = v
  end

  opts.on( "-bBUCKET NAME", "--bucketname=BUCKET NAME", "Name of the bucket to perform the action on" ) do |v|
    options[:bucketname] = v
  end

  opts.on( "-fFILE_PATH", "--filepath=FILE_PATH", "Path to the file to upload" ) do |v|
    options[:filepath] = v
  end

  opts.on('-a', '--action [ACTION]', [:list, :upload, :delete, :download],
          'Select action to perform [list, upload, delete, download]') do |v|
          if not v then
                  puts "Error: Action not valid"
          else
                  options[:action] = v
          end
  end

  opts.on("-h", "--help", "Show this message") do
    puts opts
    exit
  end
end.parse!(ARGV)

#test printing
# p options
# p ARGV


bucket = s3_resource.bucket(options[:bucketname])
# p bucket
# # http://docs.aws.amazon.com/sdkforruby/api/Aws/S3/Client.html#list_objects_v2-instance_method
if options[:action] == :upload
  bucket.put_object({
    body: File.read(options[:filepath]),
    key: options[:filepath].split(File::SEPARATOR)[-1]
    })


  elsif options[:action] == :list
    bucket = s3_resource.bucket(options[:bucketname])
    # p bucket
    bucket.objects.each do |obj|
       puts "#{obj.key}=>#{obj.etag}"
    end

  elsif options[:action] == :delete
    bucket = s3_resource.bucket(options[:bucketname])
    bucket.delete_objects({
      delete: {
        objects: [
          {
            key: options[:filepath].split(File::SEPARATOR)[-1],
          },
        ],
      },
  })

  elsif options[:action] == :download
    obj = s3_resource.bucket(options[:bucketname]).object(options[:filepath].split(File::SEPARATOR)[-1])
    obj.get(response_target: options[:filepath].split(File::SEPARATOR)[-1])
  else
    AWS_parser.parse %w[--print_opts]
end
