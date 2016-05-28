DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/recall.db")

class User
	include DataMapper::Resource

	property :id, Serial, :key => true
	property :email, String, :required => true, :format => :email_address, :unique => true, :length => 3..50
	property :password, BCryptHash

	def authenticate(attempted_password)
    if self.password == attempted_password
      true
    else
      false
    end
  end
end

# Tell DataMapper the models are done being defined and update the database.
DataMapper.finalize
DataMapper.auto_upgrade!

# create a testing account on the DB
if User.count == 0
  @user = User.create(email: "admin@me.com")
  @user.password = "admin"
  @user.save
end
