require "1pass/version"
require "keychain"

class AgileKeychain
	INVALID_PASSWORD = "Maybe you should try asking a human?"
	INVALID_KEY = "Invalid key. Keys are case-sensitive."

	def initialize(path=nil)
		path = path || "#{ENV["HOME"]}/Library/Application Support/1Password/1Password.agilekeychain"
		@keychain = Keychain.new(path)
	end

	def list
		@keychain.content.items.map { |i| { name: i.name, url: i.url } }
	end

	def load(master_password, key_name, field_name=nil)
		inform_and_exit(INVALID_PASSWORD) unless @keychain.unlock(master_password)
		key = @keychain.get(key_name)
		inform_and_exit(INVALID_KEY) unless key
		puts field_name ? key.find(field_name) : key.fields
	end

	private

	def inform_and_exit(message)
		puts message
		exit 1
	end
end
