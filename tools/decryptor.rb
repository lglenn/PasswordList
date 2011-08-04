require 'openssl'
require 'base64'

filename = ARGV[0]
key = ARGV[1]
passphrase = ARGV[2]

private_key = OpenSSL::PKey::RSA.new(File.read(key),passphrase)

def decrypt(key,encrypted_string)
  key.private_decrypt(Base64.decode64(encrypted_string))
end

def dump(name,username,password)
  puts "#{name}\t#{username}\t#{password}"
end

def getline(file)
  line = file.gets
  if line
    line.chomp!
  end
  line
end

def getuser(file)
  ret = {}
  line = nil
  ret[:password] = ''
  until line =~ /^# User/
    line = getline(file)
    return if file.eof?
  end
  ret[:name] = getline(file)
  ret[:username] = getline(file)
  until line =~ /^$/
    line = getline(file)
    ret[:password] += line
  end
  return ret
end

file = File.open(filename)

until file.eof?
  user = getuser(file)
  if user
    dump(user[:name],user[:username],decrypt(private_key,user[:password]))
  end
end
