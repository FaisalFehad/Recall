require 'rubygems'
require 'dm-core'
require "dm-sqlite-adapter"
require 'dm-timestamps'
require 'data_mapper'


DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/recal.db")

class Note
  include DataMapper::Resource
  property :id, Serial
  property :content, Text, :required => true
  property :complete, Boolean, :required => true, :default => false
  property :created_at, DateTime
  property :updated_at, DateTime
end

DataMapper.finalize
DataMapper.auto_upgrade!
