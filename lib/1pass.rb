require "1pass/version"
require "keychain"

class AgileKeychain
	def initialize(path=nil)
		path = path || "#{ENV["HOME"]}/Library/Application Support/1Password/1Password.agilekeychain"
		@keychain = Keychain.new(path)
	end

	def list
		@keychain.content.items.map {|i| puts i.name}
	end

	def load(master_password, key_name, field_name=nil) 
  		@keychain.unlock(master_password)
  		key = @keychain.get(key_name)
  		return unless key
  		puts field_name ? key.find(field_name) : key.fields
	end
end
