require 'spec_helper'

describe Key do
	it "should decrypt given Password type encrypted data using master key" do
		data = {
			  "keyID"=> "CB7D05596E224460A6AF6B4E079A3254",
			  "encrypted"=> "U2FsdGVkX1+rv05ymbg+U91chjF2wBnptmXGcG3Wl3LuBJTUOY/PCdBCcVotd+Q9F3OcdHiIErRgpjJQ9xSoD5kxTsBB13SiPJMeqMO4iHo=\u0000",
			  "typeName"=> "passwords.Password"
		}
	    master_key = "master key"
	    decrypted = '{"password": "secret password"}'
	    
	    encryption_key = mock("EncryptionKey")
	    encryption_key_item = mock("EncryptionKeyItem")
	    encryption_key.expects(:get).with(data['keyID']).returns(encryption_key_item)
	    encryption_key_item.expects(:decrypted_master_key).returns(master_key)
	    Decrypt.expects(:decrypt_ssl).with(master_key, data['encrypted']).returns(decrypted)

		key = Key.new data
		key.decrypt(encryption_key).password.should == "secret password"
	end

	it "should decrypt given WebForm type encrypted data using master key" do
		data = {
			  "keyID"=> "CB7D05596E224460A6AF6B4E079A3254",
			  "encrypted"=> "U2FsdGVkX18szXGGFR7FwBrP1w4cIk2XSlsjUlq74hAtOy7he9f/kOEpBkmCUtgu/CtkxqRF7pAfI6EDdwtH3iVj9vKHHjLyBDp5ZGlp8YiKbjXVZCzysqGryiqwx7whZBcn/Kso1vw/uWtF6YYxjnWhX8mVFC9S9BcXrJMBq8bGGMWdlmPFREJ998vhkLSE2/pIycocThDdR5wNLeQMemIarB8kRLICeoNwqUOlPpyIIa/soZqN1Nbn/aKWhBPkNgYV/x8+L4/R7blXzHINedeS1HuojFnBy7b3vRvYFM40jXTAMAsYyuRUKXolP+APTwXM29z/PzNbLXXzcojGuHcZbffdUovUZuT9cUBAB7Oefwmlq6jU07wj9KpywW/x3VWUYY7Q3aixsmmD3WDJz4pMcqSzF/rtcLBC6IqG9/s=\u0000",
			  "typeName"=> "webforms.WebForm"
		}
		master_key = "master key"
		decrypted = '{"notesPlain": "my-notes", 
					 "fields":   [{"name": "Username", "value": "my-username", "designation": "username"}, 
						 		  {"value": "my-password", "name": "Password", "designation": "password"}, 
						  	   	  {"value": "my-field-value", "name": "my-text-field-name", "type": "T"}]}'
	    
	    encryption_key = mock("EncryptionKey")
	    encryption_key_item = mock("EncryptionKeyItem")
	    encryption_key.expects(:get).with(data['keyID']).returns(encryption_key_item)
	    encryption_key_item.expects(:decrypted_master_key).returns(master_key)
	    Decrypt.expects(:decrypt_ssl).with(master_key, data['encrypted']).returns(decrypted)

		key = Key.new data
		key.decrypt(encryption_key).password.should == "my-password"		
	end
end