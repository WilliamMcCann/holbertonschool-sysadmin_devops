#shebang for bash
#!/bin/bash
	#make the variable FILE equal the function's argument
	FILE=$1
	# initialize variables to zero
	countHead=0;
	countGet=0;
	# while loop will read the file and output it to lines
	while read line
		do
			#if statement identifies only lines with HEAD
			if echo $line | grep -q "HEAD"
				then
				#variable increments to count the number
				#of HEAD occurences
				((countHead++))
			#elif statement identifies only lines with 
			elif echo $line | grep -q "GET"
				then
				#variable increments to count the number
				#of GET occurences
				((countGet++))
			fi
	#script complete
	done < $1
		# use variables to write the number of HEADs and GETs
		echo $countHead
		echo $countGet