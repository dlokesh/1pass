require "1pass/version"
require "keychain"

class AgileKeychainException < Exception ; end

class AgileKeychain
	INVALID_PASSWORD = "Invalid Password. Maybe you should try asking a human?"
	INVALID_KEY = "Invalid key. Keys are case-sensitive."

	def initialize(path=nil, master_password=nil)
		@unlocked = false
		path = path || "#{ENV["HOME"]}/Library/Application Support/1Password/1Password.agilekeychain"
		@keychain = Keychain.new(path)
		unlock(master_password) if master_password
	end

	def list
		@keychain.content.items.map {|i| puts i.name}
	end

	def load(master_password, key_name, field_name=nil)
		# this is for api compatability
		# if already unlocked, will be a noop. if not, we need to unlock it here!
		unlock(master_password)

		key = @keychain.get(key_name)
		raise AgileKeychainException, INVALID_KEY unless key
		puts field_name ? key.find(field_name) : key.fields
	end

	def load_all_regex(re)
		raise AgileKeychainException, "unlock me first" if not @unlocked
		return key.find_all(re)
        end

	private
	def unlock(master_password)
		return true if @unlocked
		return false if !master_password
		raise AgileKeychainException, INVALID_PASSWORD unless @keychain.unlock(master_password)
		@unlocked = true
		return true
	end
end
