#!/bin/bash

message=$1
gender=$2
address=$3

name=$(echo $message | awk '{print $1}')

case $gender in
   f)
   say -v Moira $message -o $name.m4a | scp -q $name.m4a admin@158.69.80.171:/var/www/html
   ;;
   m)
   say -v Albert $message -o $name.m4a | scp -q $name.m4a admin@158.69.80.171:/var/www/html
   ;;
   x)
   say  -v Cellos -o $message -o $name.m4a | scp -q $name.m4a admin@158.69.80.171:/var/www/html
   ;;
   *)
   echo "Wrong letter! Please select f, m, or x."
esac

echo $name.m4a
echo "Listen to the message on http://$address/$name.m4a." 