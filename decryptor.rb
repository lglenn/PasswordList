require 'openssl'
require 'base64'
require 'sqlite3'

dbfile = ARGV[0]
key = ARGV[1]
passphrase = ARGV[2]

db = SQLite3::Database.new dbfile

private_key = OpenSSL::PKey::RSA.new(File.read(key),passphrase)

def decrypt(key,encrypted_string)
  key.private_decrypt(Base64.decode64(encrypted_string))
end

rows = db.execute "select * from accounts" do |row|
  name = row[1]
  username = row[2]
  pass = decrypt(private_key,row[3])
  puts "Name: #{name} Username: #{username} Pass: #{pass}"
end


