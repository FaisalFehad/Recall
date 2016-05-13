require 'sinatra'
require 'rubygems'


set :bind, '0.0.0.0'

  get '/' do
    "Heeeeeeeelol!"
    haml :index
  end

  get '/form' do
    haml :form
  end
