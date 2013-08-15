require 'decrypt'

class EncryptionKey	
	attr_reader :items

	def initialize(data)
		@items = data['list'].map {|k| EncryptionKeyItem.new k}
	end

	def unlock(password)
		@items.collect {|ek| ek.unlock password}.all?
	end

	def get(identifier)
		@items.select {|ek| ek.identifier == identifier}.first
	end
end

class EncryptionKeyItem
	attr_reader :identifier, :decrypted_master_key

	def initialize(hash_)
		@identifier, @data, @validation, @iterations = hash_.values_at("identifier", "data", "validation", "iterations")
	end

	def unlock(password)
		@decrypted_master_key = Decrypt.decrypt_pbkdf2(password, @data, @iterations)
		return false unless @decrypted_master_key
		validation_key = Decrypt.decrypt_ssl(@decrypted_master_key, @validation)
		@decrypted_master_key == validation_key
	end	
end