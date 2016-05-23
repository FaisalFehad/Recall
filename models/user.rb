class User
	include DataMapper::Resource
  
	property :id, Serial, :key => true
	property :email, String, :required => true, :format => :email_address, :unique => true, :length => 3..50
	property :password, BCryptHash
end
DataMapper.auto_upgrade!
