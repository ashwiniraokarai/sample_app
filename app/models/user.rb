class User < ApplicationRecord
  #callback to supplement email uniqueness validation (see db migration where index was added)
  #also you don't need self here - you could just do email.downcase!
  before_save { self.email.downcase! }
  #validations
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
            format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i },
            uniqueness: true
            #This is not sufficient on its own. To cover race conditions, uniqueness was enforced at DB level also (along with an index)
  
  #has_secured_password method comes shipped with bcrypt gem (needs gem to be added)
  #Needs a xxx_digest column introduced (XXX is the desired attribute name for password) in the users table
  #Automatically adds virtual attributes XXX and XXX_confirmation to the model
  #e.g.for a db column name chosen as passowrd_digest, the two virtual attributes determined would be:
  #password and password_confirmation so you can do @user.password and @user.password_confirmation
  #You can also do @user.authenticate("<password>") to check if the password provided matches the value in original password_digest
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }
end
