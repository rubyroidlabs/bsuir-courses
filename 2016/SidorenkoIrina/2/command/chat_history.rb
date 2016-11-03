require 'date'
require "fileutils"

class ChatHistory
      attr_reader :owner_id
      def initialize(owner_id, command)
	  @owner_id = owner_id
  	  @command = command
 	  @@path = "users/#{@owner_id}"
 	  @@path_to_file = "users/#{@owner_id}/#{@command}.txt"
      end

      def exist_directory
  	  if File.directory?(@@path)
	     return true
	  else
             return false
	  end
      end

      def exist_file
	  if File.exists?(@@path_to_file)
	     return true
	  else
	     return false
	  end
      end

      def create_directory
	  if(!exist_directory)  
	      Dir.chdir("users") 
	      Dir.mkdir("#{@owner_id}")
	  end
      end

      def delete_directory
	  if(exist_directory) 
	     dir = Dir.new(@@path)
	     dir.entries.each do |e|
	         next if e =~ /^\./
		 file = File.join(dir.path, e)
	         File.delete(file) if File.file?(file)
	     end
          end
      end

      def save_to_file(val, value)
	  if(exist_directory) 
              if (exist_file && (@command == "subject" || @command == "submit"))
		  option = "a"
	      else 
		  option = "w"
	      end
	      File.open(@@path_to_file, option) do |f|
		  f.puts "#{val},#{value}" 
	      end			
	   end
       end

       def read_from_file
	   if (exist_directory && exist_file) 
		info_fields = File.readlines(@@path_to_file) 
		info_fields.map! {|i| i.chomp}
		return info_fields.map! {|i| i.split(",")}	
	   end
	        return false
       end
end
