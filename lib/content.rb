class Content
	attr_reader :items

	def initialize(data)
		@items = data.map {|item| ContentItem.new item}
	end

	def find(name)
		@items.select {|i| i.name == name}.first
	end
end

class ContentItem
	attr_reader :uuid, :name, :type, :url

	def initialize(item)
		@uuid, @type, @name, @url, @timestamp, @folder, @strength, @trashed = item
	end
end
