#!/bin/bash
case
if


simple if: validate the condition if it is true it will execute given command
========
syntax:
if [ expression ]
then
  commands
fi




if else:  validate the condition if it is true it will execute given command,if false it will execute command
=======

syntax:

if [ expression ]
then
  commands
else 
  commands
fi

else if: validate multiple conditions and executes commands
========
if [ expression1 ]
then
  command1
elif [ expression2 ]
then
  command2
elif [ expression3 ]
then
  command3
else
  command4
fi

expressions
=============
catageorised into 3

string:
======
operators: =,==,!=,-z

example
--------
[ "abc" == "ABC" ]
[ "abc" != "ABC" ]
[ -z "$USER" ] : to check variable is having value or not,if its 0 it true,if non zero its false

#!/bin/bash

#string comparision
read -p "Enter username: " username

if [ "$username" == "root" ]; then
  echo "Hey, User $username is admin user"
else
  echo "Hey, User $username is normal user"
fi



number:
========
operators: -eq,-ne,-gt,-ge,-lt,-le

example:
========
[ 1 -eq 2 ]
[ 2 -ne 3 ]
[ 2 -gt 3 ]
[ 2 -ge 3 ]
[ 2 -lt 3 ]
[ 2 -le 3 ]


file:
=====
[ -f file ]
[ ! -f file ]

#!/bin/bash

#file check
read -p "Enter filename: " filename
if [ -f "$filename" ]; then
  echo "Hey, File $filename exist"
else
  echo "Hey, File $filename not exist"
fi

#Notes: always user quotes for expressions to avoid errors.



