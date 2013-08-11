require 'decrypt'

class EncryptionKey	
	attr_reader :encryption_keys

	def initialize(data)
		@encryption_keys = data['list'].map {|k| EncryptionKeyItem.new k}
	end

	def unlock(password)
		@encryption_keys.collect {|ek| ek.unlock password}.all?
	end

	def decrypt(key)
		encryption_key = @encryption_keys.select {|ek| ek.identifier == key.keyID}.first
		encryption_key.decrypt(key.encrypted)
	end
end

class EncryptionKeyItem
	attr_reader :identifier, :decrypted_master_key

	def initialize(hash_)
		@identifier, @data, @validation, @iterations = hash_.values_at("identifier", "data", "validation", "iterations")
	end

	def unlock(password)
		@decrypted_master_key = Decrypt.decrypt_pbkdf2(password, @data, @iterations)
		validation_key = Decrypt.decrypt_ssl(@decrypted_master_key, @validation)
		@decrypted_master_key == validation_key
	end	

	def decrypt(encrypted)
		Decrypt.decrypt_ssl(@decrypted_master_key, encrypted)
	end
end

class Key
	attr_reader :keyID, :encrypted

	def initialize(hash_)
		@keyID, @encrypted = hash_.values_at("keyID", "encrypted")
	end
end