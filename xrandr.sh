#!/bin/bash

# Copyright © 2021 Chirag Bhatia
# Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated 
# documentation files (the “Software”), to deal in the Software without restriction, including without 
# limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of 
# the Software, and to permit persons to whom the Software is furnished to do so, subject to the following 
# conditions: The above copyright notice and this permission notice shall be included in all copies or
# substantial portions of the Software. THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS 
# OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE 
# AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR 
# OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION 
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

#If no argument is specified, ask for it and exit
if [[ -z "$@" ]];
then
    echo "An argument is needed to run this script";
    exit
else
    arg="$@"
    #Basic check to make sure argument number is valid. If not, display error and exit
    if [[ $(($(echo $arg | grep -o "\s" | wc --chars) / 2 )) -ne 2 ]];
    then
        echo "Invalid Parameters. You need to specify parameters in the format \"width height refreshRate\""
        echo "For example setResolution \"1920 1080 60\""
        exit
    fi
    
    #Save stuff in variables and then use xrandr with those variables
    modename=$(echo $arg | sed 's/\s/_/g')
    display=$(xrandr | grep -Po '.+(?=\sconnected)')
    if [[ "$(xrandr|grep $modename)" = "" ]];
    then
        xrandr --newmode $modename $(gtf $(echo $arg) | grep -oP '(?<="\s\s).+') &&
        xrandr --addmode $display $modename     
    fi
    xrandr --output $display --mode $modename

    #If no error occurred, display success message
    if [[ $? -eq 0 ]];
    then
        echo "Display changed successfully to $arg"
    fi
fi
