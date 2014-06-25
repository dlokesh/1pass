require 'json'
require 'encryption_key'
require 'key'
require 'content'

class Keychain
	attr_reader :encryption_key, :content

	def initialize(path)
		@path = path
		load_encryption_keys
		load_contents
	end

	def unlock(password)
		@unlocked = @encryption_key.unlock(password)
	end

	def get(name)
		item = @content.find(name)
		return unless item
		key = Key.new load_file(item.uuid + ".1password")
		key.decrypt(@encryption_key)
	end

	def get_all(re)
		items = @content.find_all_regex(re)
		decrypted_items = []
		items.each do |item|
			decrypted_items << get(item.name)
		end
		return decrypted_items
        end

	private
	def load_encryption_keys
		@encryption_key = EncryptionKey.new load_file("encryptionKeys.js")
	end

	def load_contents
		@content = Content.new load_file("contents.js")
	end

	def load_file(file_name)
		file = File.join(@path, "data", "default", file_name)
		JSON.parse(IO.read(file))
	end	
end
