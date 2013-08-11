require 'spec_helper'

describe Content do
	it "should initialize content items" do
		data = ["0FAE93A1943E4437AD662A81976811DB"],
	  		   ["1EEE501364B843F3B6518597A7999D12",]
	  	content = Content.new data
	  	content.items.size.should == 2
	end
end

describe ContentItem do
	it "should initialize content item values" do
		item =	[
				    "1EEE501364B843F3B6518597A7999D12",
				    "wallet.computer.License",
				    "my-software",
				    "",
				    1347253363,
				    "",
				    0,
				    "N"
	  			]
	  	content_item = ContentItem.new item
	  	content_item.uuid.should == "1EEE501364B843F3B6518597A7999D12"
	  	content_item.name.should == "my-software"
	end
end