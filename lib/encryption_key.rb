require 'decrypt'

class EncryptionKey
	attr_reader :decrypted_master_key

	def initialize(hash_)
		@data, @validation, @iterations = hash_.values_at("data", "validation", "iterations")
	end

	def unlock(password)
		@decrypted_master_key = Decrypt.decrypt_pbkdf2(password, @data, @iterations)
		validation_key = Decrypt.decrypt_ssl(@decrypted_master_key, @validation)
		@decrypted_master_key == validation_key
	end
end