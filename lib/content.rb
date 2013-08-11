class Content
	attr_reader :items

	def initialize(data)
		@items = data.map {|item| ContentItem.new item}
	end
end

class ContentItem
	attr_reader :uuid, :name

	def initialize(item)
		@uuid, @type, @name, @url, @timestamp, @folder, @strength, @trashed = item
	end
end