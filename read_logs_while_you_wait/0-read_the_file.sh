#shebang for bash
#!/bin/bash
#make the variable FILE equal the function's argument
FILE=$1
# read $FILE using the file descriptors
exec 3<&0
exec 0<$FILE
while read line
do
	# use $line variable to write the line
	echo $line
#script complete
done
exec 0<&3
