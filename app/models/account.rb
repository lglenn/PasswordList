require 'cryptpass.rb'
include CryptPass

class Account < ActiveRecord::Base
  validates_uniqueness_of :name
  validates_uniqueness_of :username
  validates_presence_of :name
  validates_presence_of :username
  validates_presence_of :password

  before_save do
    self.password = cryptpass(Rails.application.config.public_key,self.password)
  end

end
