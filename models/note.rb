DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/recall.db")

class Note
	include DataMapper::Resource

	property :id, Serial, :key => true
	property :content, Text, :required => true, :length => 2..90
	property :complete, Boolean, :required => true, :default => 0
	property :created_at, DateTime
	property :updated_at, DateTime
end

# Updates the database
DataMapper.finalize
DataMapper.auto_upgrade!
