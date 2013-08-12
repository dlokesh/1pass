require 'spec_helper'

describe Keychain do
	before(:each) do
		@test_path = File.join(Dir.pwd, "spec", "data", "1Password.agilekeychain")
	end

	it "should load encryption keys and contents" do
		keychain = Keychain.new (@test_path)
		keychain.encryption_key.items.size.should == 2
		keychain.content.items.size.should == 2
	end

	it "should unlock for correct password" do
		keychain = Keychain.new (@test_path)
		keychain.unlock("master-password").should be_true
	end	

	it "should not unlock for incorrect password" do
		keychain = Keychain.new (@test_path)
		keychain.unlock("incorrect-password").should be_false
	end		

	it "should get encrypted contents for given key name" do
		keychain = Keychain.new (@test_path)
		keychain.unlock("master-password").should be_true
		keychain.get("my-login").password.should == "my-password"
	end

end