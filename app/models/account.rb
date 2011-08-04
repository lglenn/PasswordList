class Account < ActiveRecord::Base
  validates_uniqueness_of :name
  validates_uniqueness_of :username
  validates_presence_of :name
  validates_presence_of :username
  validates_presence_of :password
end
