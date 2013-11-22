 #PROCESSING
 require 'RMagick'
 include Magick
 
 module Images
   def self.processing(image, options, time)
     image = ImageList.new(image)
     text = Draw.new
     text.pointsize = 16
     x_pozition, y_pozition = self.get_pozition_for_text(options.margin,options.offset,image)
     
     text.annotate(image,0,0, x_pozition, y_pozition, options.sign){
       self.fill = 'gray'
      }
     text.annotate(image,0,0, x_pozition+1, y_pozition+1, options.sign){
       self.fill = 'white'
      }
      text.annotate(image,0,0, x_pozition-1, y_pozition+-1, options.sign){
       self.fill = 'black'
      }
     image.write(options.directory + "/#{time}/" + (/\/\w+.jpg/.match(image.filename ).to_s))
   end
   def self.get_pozition_for_text(margin, offsets, source)
     x_resolution = source.columns
     y_resolution = source.rows
     case (margin)
       when :upper_left
         x_offset = offsets[0].to_i
         y_offset = offsets[1].to_i
       when :upper_right
         x_offset = x_resolution - offsets[0].to_i
         y_offset = offsets[1].to_i
       when :lower_left
         x_offset = offsets[0].to_i
         y_offset = y_resolution - offsets[1].to_i
       when :lower_right
         x_offset = x_resolution - offsets[0].to_i
         y_offset = y_resolution - offsets[1].to_i
     end
     [x_offset, y_offset]
   end
 end
 