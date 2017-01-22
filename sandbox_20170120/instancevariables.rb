#!/usr/bin/env ruby
#

class Gitshapostconfig
	attr_accessor :name_of_object
	# This subarea is where config values are stored.
	attr_accessor :local_base
	attr_accessor :checked_website
	attr_accessor :utility_location
	attr_accessor :utility_get
	attr_accessor :utility_page

	attr_accessor :comment_symbol
	def initialize(name_of_object)
		@name_of_object = name_of_object
		@comment_symbol = '#'
		@local_base = ''
	end
	def isInstanceVariable(someVar)
		theIV = instance_variables	
		puts "First element of theIV: SSS#{theIV[0]}EEE"
		puts "Second element of theIV: SSS#{theIV[1]}EEE"
		puts "someVar BYTE"
		someVar.each_byte {|c| print c, ' ' }
		puts "theIV0 BYTE"
		theIV[0].to_s.each_byte {|c| print c, ' ' }

		if someVar == "@name_of_object"
			puts "someVar is equal to at name_of_object"
		else
			puts "someVar is not equal to at name_of_object"
		end

		if someVar == theIV[0]
			puts "someVar is equal to theIV0"
		else
			puts "someVar is not equal to theIV0"
		end

		if someVar == theIV[0].to_s
			puts "someVar is equal to theIV0 to_s"
		else
			puts "someVar is not equal to theIV0 to_s"
		end
		# theI = theIV.find_index(someVar)
		theI = theIV.find_index("@name_of_object".to_str())
		puts "theI=#{theI}"
		puts "someVar=#{someVar}"
		if theI != nil
			puts "... found #{someVar}"
		else
			puts "... did not find #{someVar}"
		end
	end
	def read(src_file)
		File.open(src_file) do |file|
			file.each do |line|
				line.chomp
				if line.length < 1
					# empty line. Try reading the next one
					next
				end
				if line.chr == @comment_symbol
					puts "COMMENT DETECTED"
					next
				end
				puts line
				if line.count('=') < 1
					puts "Non config line detected-next"
					next
				end
				config_parts = ['','']
				config_parts = line.split("=")
				config_name = config_parts[0]
				config_value = config_parts[1]
				puts "... config_name=#{config_name}"
				puts "... config_value=#{config_value}"
			end
		end
	end
end

if __FILE__ == $0
	gc = Gitshapostconfig.new("name:gitshapostconfig.rb")
	gc.read("./samplefile01.txt")
	puts "The name of the object is:", gc.name_of_object
	gc.isInstanceVariable("@name_of_object")
end
	
