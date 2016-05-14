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

post '/' do
  n = Note.new
  n.content = params[:content]
  n.created_at = Time.now
  n.updated_at = Time.now
  n.save
    redirect '/'
end

get '/:id' do
  @note = Note.get params[:id]
  @title = "Edit note ##{params:[:id]}"
  erb :edit
end

put '/:id' do
  n = Note.get params[:id]
  n.content = params[:content]
  n.complete = params[:complete] ? 1 : 0
  n.updated_at = Time.now
  n.save
  redirect '/'
end

get '/:id/delete' do
  @note = Note.get params[:id]
  @title = "Confirm deletion of note ##{params[:id]}"
  erb :delete
end

delete '/:id' do
  n = Note.get params[:id]
  n.destroy
  redirect '/'
end

delete '/:id' do
  n = Note.get params[:id]
  n.destroy
  redirect '/'
end

not_found do
  halt 404, "Page not found"
end
