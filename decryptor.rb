require 'openssl'
require 'base64'

file = ARGV[0]
key = ARGV[1]
passphrase = ARGV[2]

private_key = OpenSSL::PKey::RSA.new(File.read(key),passphrase)

def decrypt(key,encrypted_string)
  key.private_decrypt(Base64.decode64(encrypted_string))
end

def dump(name,username,password)
  puts "#{name}\t#{username}\t#{password}"
end

username = name = nil
password = ''

File.open(file).each do |line|
  if line =~ /^# User/
    if username != nil
      dump name, username, decrypt(private_key,password)
      name = nil
      username = nil
      password = ''
    end
  elsif line =~ /^$/
    # nada
  elsif name == nil
    name = line.chomp()
  elsif !username
    username = line.chomp()
  else
    password += line
  end
end

dump name, username, decrypt(private_key,password)
