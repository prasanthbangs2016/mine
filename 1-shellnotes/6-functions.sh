functions
==========
if u assign a name to set of commands then that is a functions
functions are used for reusability(dry)
functions are also used to group the commands logically.

how to declare a functions..?
===============================
SAMPLE() {
    echo welcome to sample functions
}

how do u access a function...?
=================================
simple with function name

SAMPLE

variables with functions
========================
if we declare a variable in the main program then you can access them in function and vice-versa

variables of the main program can be overwritten by function and vice-versa

special variables which access the arguments from cli cannot be accessed by the function.because
functions will have their own arguments.

if we declare a variable in the main program then you can access them in function and vice-versa
================================================================================================
SAMPLE() {
    echo welcome to sample functions
    echo $a
    b=20
}
a=19
SAMPLE
echo value of b=$b

variables of the main program can be overwritten by function and vice-versa
===========================================================================
#readwrite variable property works here

special variables which access the arguments from cli cannot be accessed by the function.because
functions will have their own arguments.
===============================================================================================
SAMPLE() {
    echo first argumen = $1
}
SAMPLE xyz

sh function.sh abc
o/p:first argumen = xyz

or

SAMPLE() {
    echo first argumen = $1
}
SAMPLE $1
sh function.sh 123
o/p:first argumen = 123

exit(return) status function
==============================
in times we need to come out of function to the main program,but we cannot use exit command
because exit will completely exit the script.

return command will be used to come out of function.

function is also a type of command which necessarily needed the exit status.
so return command is capable of returning status like exit command and number range from 0-255.

SAMPLE() {
    echo first argument = $1
    return 1
    echo prashanth
}

SAMPLE 
sh function.sh 123

o/p: echo first argument = 123


