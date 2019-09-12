    	    	 
   (define hypot  X
   	Y -> (sqrt  (+
   		           (* X X)
   		           (* Y Y))
   	)
)
   

(define
      all?
	F Xs
  ->
	(fold-left (/. X
 	           B
		   	      (and B (F X)))
	  	  true    Xs))
	
 