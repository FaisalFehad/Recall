# Required gems
require 'sinatra'
require 'rubygems'
require 'data_mapper'
require "bcrypt"

# Required models
require './models/note'
require './models/user'

# Enable login sessions
enable :sessions

# ** SHOW **
# Root to the index page
# Pull all notes from the DB into an instance varible to access from the index page in descends order.
get '/' do
  @notes = Note.all :order => :id.desc
  haml :index
end

# ** SAVE **
# Retrieves note contents from :contents on the index view and save them into the DB.
# Redirects back to the index page.
post '/' do
  n = Note.new
  n.content = params[:content]
  n.created_at = Time.now
  n.updated_at = Time.now
  n.save
    redirect '/'
end

# Regester view
get "/register" do
	haml :register
end

# assign email and password to varibles and then save them into the db and removes extra space, lowercase the email.
post "/register" do
	user_email = params[:email]
	user_pw = params[:password]
		u = User.new
		u.email = params[:email].downcase.chomp
		u.password = params[:password].chomp
		u.save
			"Thank you for registeration."
	end

# ** EDIT **
# Retrieves notes ID to edit the note
# Title varible is to display the note ID to the user to be able to edit/delete a specific note.
get '/:id' do
	@note = Note.get params[:id]
	@title = "Edit note ##{params[:id]}"
	haml :edit
end

# Edit
# Retrieves the saved note for the user to edit then save it with the same ID and new timestamp
put '/:id' do
	n = Note.get params[:id]
	n.content = params[:content]
	n.complete = params[:complete] ? 1 : 0
	n.updated_at = Time.now
	n.save
	redirect '/'
end

# ** DESTROY **
# Delete note by the ID
# Retrun the note ID to the view page to confirm the deletion of the right note.
get '/:id/delete' do
	@note = Note.get params[:id]
	@title = "Confirm deletion of note ##{params[:id]}"
	haml :delete
end

# Delte note by ID
delete '/:id' do
	n = Note.get params[:id]
	n.destroy
	redirect '/'
end

# Check the completion of note (still not working)
get '/:id/complete' do
	n = Note.get params[:id]
	n.complete = n.complete ? 0 : 1 # flip it
	n.updated_at = Time.now
	n.save
	redirect '/'
end

# To resturn the "Page not found" insted of the default Sinatra error page.
not_found do
  halt 404, "Page not found 404"
end
