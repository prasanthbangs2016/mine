single quote: doesnt consider any character as a special character.

a=10
echo $a

echo *
o/p: it will display other things

echo '$a'
echo '*'
o/p: it will display *


echo -e 'Hello\nWorld'

double quotes:
very few characters like $ will be considered as special and remaining of them are normal characters.
Double quotes are good practice to have

0-9,a-z,A-z,_  --- normal characters and rest all are special characters

echo "$a"
echo "*"

echo -e "Hello\nWorld"

echo -e "Hello\nWorld\n'ppk'"
o/p:
====
Hello
World
'ppk'


Redirectors:
--------------
> output     file
< input      file

ex: output
===
ls >/tmp/out

ex: input
==========
mysql <db.sql


STDOUT(>):
-------
instead of displaying the output to the screen,if we want to store the output to a file then we use this 
redirector.

STDOUT are 2 types

only output
============
ls -ld /boot /boot1
it will generate both output and error

ls -ld /boot /boot1 >/tmp/out
this output will have only output result,will not have error info in file.

ls -ld /boot /boot1 1>/tmp/out
this output will have only output result,will not have error info in file.



only error
============
ls -ld /boot /boot1 2>/tmp/out
this file will have only error output in file.

STDIN(<):
------
instead of taking the input from keyboard if we want to send through a file then we use this redirector.

STDOUT and STDERR(&>)
======================
ls -ld /boot /boot1 &>/tmp/out

output:
========
ls: cannot access '/boot1': No such file or directory
drwxr-xr-x 4 root root 4096 Aug 12 14:33 /boot


#appending
ls -ld /boot /boot1 &>>/tmp/out

null: when future reference is not needed we use this.
=====
ls -ld /boot /boot1 &>/dev/null

exit status: to determine previously executed command success or fail
===========

range from 0-255
0-universal success
1-255 is not successful/partial successful

ex:
ls -ld /boot /boot1 &>/dev/null

echo $?

#!/bin/bash
echo Hello
exit
echo bye

#echo bye wont get executed as we have exit keyword before to it

#!/bin/bash
echo Hello
exit 1
echo bye

#echo bye wont get executed as we have exit 1 keyword before to it,number is our choice











