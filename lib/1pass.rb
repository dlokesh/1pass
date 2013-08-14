require "1pass/version"
require "keychain"

class AgileKeychain
	def initialize(path=nil)
		@path = path || "~/Library/Application Support/1Password/1Password.agilekeychain"
	end

	def list

	end

	def load(master_password, name)
  		keychain = Keychain.new(@path)
  		keychain.unlock(master_password)
  		puts keychain.get(name).password
	end
end
