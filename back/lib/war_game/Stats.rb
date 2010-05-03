require "rexml/document"
include REXML

class Stats
	attr_accessor :hash
	
	#stats is url to xml
	def initialize(stats_xml)
		hash = Hash.new
		file = File.new(stats_xml)
		doc = Document.new file
		process_xml(doc)
	end
	
	#populates a hash of a hash for getting stats
	def process_xml(xml)
	
	#p doc
		# xml.each do |row|
			# row.attributes.each do |a|
				# p a
			# end
		# end
		
		
		
		
		# for each (var row:XML in xml.*)
		# {
			# var name:String;
			# for each(var a:XML in row.@*)
			# {
				# if (String(a.name()) == "name")
				# {
					# name = String(a.toXMLString());
					# hash[name] = new Object();
					# //trace(name);
				# }
				# else
				# {
					# hash[name][String(a.name())] = String(a.toXMLString());
					# //trace(String(a.name()) + " -> " + String(a.toXMLString()));
				# }
			# }
			
		# }
	end
end