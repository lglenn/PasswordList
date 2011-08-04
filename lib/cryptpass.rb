require 'openssl'
require 'base64'

module CryptPass

  def cryptpass(key,pass)
    public_key = OpenSSL::PKey::RSA.new(File.read(key))
    Base64.encode64(public_key.public_encrypt(pass))
  end

end
