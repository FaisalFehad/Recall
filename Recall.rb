require 'sinatra'
require 'rubygems'
require 'data_mapper'


set :bind, '0.0.0.0'

#DB Schema
DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/recall.db")

class Note
	include DataMapper::Resource
	property :id, Serial
	property :content, Text, :required => true
	property :complete, Boolean, :required => true, :default => 0
	property :created_at, DateTime
	property :updated_at, DateTime
end
DataMapper.auto_upgrade!


  get '/' do
    @notes = Note.all :order => :id.desc
    @title = "All Notes"
    haml :index
  end

  get '/form' do
    haml :form
  end

  not_found do
   halt 404, "Page not found"
  end
