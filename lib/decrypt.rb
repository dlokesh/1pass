require 'openssl'

class Decrypt
	def self.base64_decode(base64_encoded_string)
		decoded_data = base64_encoded_string.unpack('m')[0]
		salt = decoded_data[8..15]
		data = decoded_data[16..decoded_data.length-1]
		{salt: salt, data: data}
	end

	def self.aes_decrypt(data, key, iv)
		decipher = OpenSSL::Cipher::AES.new(128, :CBC)
		decipher.decrypt
		decipher.key = key
		decipher.iv = iv
		decipher.padding = 0
		plain = decipher.update(data)
		plain << decipher.final
	end	

	def self.derive_pbkdf2(password, salt, iterations)
		key_and_iv = OpenSSL::PKCS5.pbkdf2_hmac_sha1(password, salt, iterations, 32)
		{key: key_and_iv[0,16], iv: key_and_iv[16..-1]}
	end

	def self.derive_openssl(key, content_salt)
		key = key[0,1024]
		key_and_iv = ""
		prev = ""

		while key_and_iv.length < 32 do
		    prev = Digest::MD5.digest(prev + key + content_salt)
		    key_and_iv << prev
		end

		{key: key_and_iv[0,16], iv: key_and_iv[16..-1]}
	end

	def self.decrypt_pbkdf2(master_password, data, iterations)
		encrypted = base64_decode(data)
		key_and_iv = derive_pbkdf2(master_password, encrypted[:salt], iterations)
		aes_decrypt(encrypted[:data], key_and_iv[:key], key_and_iv[:iv])
	end

	def self.decrypt_ssl(master_key, validation)
		encrypted = base64_decode(validation)
		key_and_iv = derive_openssl(master_key, encrypted[:salt])
		aes_decrypt(encrypted[:data], key_and_iv[:key], key_and_iv[:iv])
	end	
end