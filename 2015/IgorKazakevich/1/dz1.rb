stick = []

stick[0] = %Q(
					  ***
					  * *
				  	  * *
				  	  * *
				  	  * *
				  	  * *
				  	  * *
				  	  * *
				  	  * *
				  	  * *
				  	  * *
				  	  ***
)

stick[1] = %Q(

							
					             * *
					          * *  
					      * *	
  		 		  	  * *
				      * *
	  		          * *
			      * *
)
stick[2] = %Q(


							
		           		 	         * *
	 				          * *
	 			          * *
	 	                   * *
	 	            * *  
)

stick[3] = %Q(



			
		 	    *  *  *  *  *  *  *  *  *  *  *  *
		 	    *  *  *  *  *  *  *  *  *  *  *  *
)

stick[4] = %Q(




			    * *
				   * *
					  * *
						  * *   
							 * *	

)

stick[4] = %Q(


			      * *
				  * *
				      * *
					  * *
					      * *
						  * *
						     * *
)

loop do
stick.each do |step|
puts step
sleep 0.5
system "clear"
end
end

