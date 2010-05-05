require "rexml/document"
include REXML

class Stats
	attr_accessor :hash
	
	#stats is url to xml
	def initialize(stats_xml)
		@hash = Hash.new
		file = File.new(stats_xml)
		doc = Document.new file
		process_xml(doc)
	end
	
	#populates a hash of a hash for getting stats
	def process_xml(xml)
		xml.elements.each("*/*") do |e|
			name = ""
			e.attributes.each do |a|
				if a[0] == "name"
					name = a[1]
					@hash[name] = Hash.new
				else
					@hash[name][a[0]] = a[1]
				end
			end
		end
	end
end