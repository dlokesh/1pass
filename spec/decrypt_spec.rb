require 'spec_helper'
require 'base64'

describe Decrypt do
	it "should decode and split salt" do
		encoded = Base64.encode64("Salted__ABCDEFGH12345678")
		decoded = Decrypt.base64_decode(encoded)
		decoded[:salt].should == "ABCDEFGH"
        decoded[:data].should == "12345678"
	end
end

