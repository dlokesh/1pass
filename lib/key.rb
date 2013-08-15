class Key
	attr_reader :key_id, :encrypted

	def types
		{"webforms.WebForm" => WebForm, 
		 "passwords.Password" => Password}
	end

	def initialize(hash_)
		@key_id, @encrypted, @type_name = hash_.values_at("keyID", "encrypted", "typeName")
	end

	def decrypt(encryption_key)
		decrypted_master_key = encryption_key.get(@key_id).decrypted_master_key
		return unless decrypted_master_key
		decrypted_content = JSON.parse Decrypt.decrypt_ssl(decrypted_master_key, @encrypted)
		types[@type_name].new decrypted_content
	end
end

class WebForm
	attr_reader :fields

	def initialize(hash_)
		@notes_plain, @fields = hash_.values_at("notesPlain", "fields")
	end

	def find(name)
		field = @fields.select {|f| f["name"] == name || f["designation"] == name}.first
		field["value"]
	end
end

class Password
	attr_reader :fields

	def find(name)
		@fields[name]
	end
	
	def initialize(hash_)
		@fields = hash_
	end
end