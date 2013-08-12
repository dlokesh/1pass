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
		decrypted_content = JSON.parse Decrypt.decrypt_ssl(decrypted_master_key, @encrypted)
		types[@type_name].new decrypted_content
	end
end

class WebForm
	attr_reader :password

	def initialize(hash_)
		@notes_plain, fields_hash = hash_.values_at("notesPlain", "fields")
		@fields = fields_hash.map {|f| Field.new f}
		@password = find("password").value
	end

	def find(name)
		@fields.select {|f| f.name == name || f.designation == name}.first
	end

	class Field
		attr_reader :name, :value, :designation
		def initialize(hash_)
			@name, @value, @designation = hash_.values_at("name", "value", "designation")
		end
	end
end

class Password
	attr_reader :password
	
	def initialize(hash_)
		@password = hash_["password"]
	end
end