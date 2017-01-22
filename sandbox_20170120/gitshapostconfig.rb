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

		@local_base = ''
		@checked_website = ''
		@utility_location = ''
		@utility_get = ''
		@utility_page = ''

		@comment_symbol = '#'
	end
	def isInstanceVariable(someVar)
		theIV = instance_variables	
		theIVs = [];
		# It seems instance_variables returns an array of symbols.  These
		# need to be converted to strings as follows.
		theIV.each_index {|x| theIVs[x] = theIV[x].to_s}


		#### puts "First element of theIV: SSS#{theIV[0]}EEE"
		#### puts "Second element of theIV: SSS#{theIV[1]}EEE"


		#### if someVar == theIV[0].to_s
		####	puts "someVar is equal to theIV0 to_s"
		#### else
		####	puts "someVar is not equal to theIV0 to_s"
		#### end
		#### theI = theIVs.find_index("@name_of_object".to_s)
		theI = theIVs.find_index(someVar)
		#### puts "theI=#{theI}"
		#### puts "someVar=#{someVar}"
		if theI != nil
			puts "... found #{someVar}"
			return true
		else
			puts "... did not find #{someVar}"
			return false
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
				insVar = isInstanceVariable("@"+config_name)
				if (insVar)
					puts "#{config_name} is represented by an instance variable"
				else
					puts "#{config_name} is not represented by an instance variable"
				end
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
	
