#!/usr/bin/env bash

#
# !! Hey - this is beta software and should be used at your own risk!
#

##########################################################################
#  Ghostem - fast deletion of file contents while maintaining file's
#  name and location intact. 
##########################################################################
# Author: Carrie Ganote
# License: GPLv3
# February 2020

###
# Usage: source this file to place the ghostem function in your environment.
# The ghostem command will ask you for some filters to apply to find files
# in your *current directory*. The filters can be minimum file size and/or name.
# You can use wildards in your name entries, such as test*. You can add a letter
# to the end of a file size, like 1g to mean one gigabyte. 
# The program will ask you for a message to place in the file and will put some 
# other tidbits in there, like permissions and access times before the file was deleted.
# A message could be something like, "I didn't need these intermediate files" or,
# "Backed up already in the SDA under location /home/me/backups.tgz"
###

function ghostem {
    findparams=""
    read -ep $'Ghost files by (s)ize, by (n)ame, (b)oth, or (q)uit?\n ' howtoghost
    if [[ "$howtoghost" != "n" && "$howtoghost" != "b" && "$howtoghost" != "s" ]]; then
	echo "Quitting"
	return
    fi
    if [[ "$howtoghost" == "s" || "$howtoghost" == "b" ]]; then 
	read -ep $'Please enter the minimum file size to ghost in the current directory. Default in bytes; end number with k, m, and g for kilobyte, megabyte and gigabyte:\n ' getsize
	echo "getsize is $getsize"
	number=${getsize//[a-zA-Z]/}
	suffix=${getsize//[.0-9]/}
	echo "number is $number"
	echo "suffix is $suffix"
	if [[ "$suffix" == [kK] ]]; then
	    echo "Converting $number Kb to bytes"
	    bytesize=$(echo "$number * 1024" | bc -l )
	    bytesize=$(printf "%.0f" $bytesize)
	    echo "rounding: $bytesize"
	elif [[ "$suffix" == [mM] ]]; then
	    echo "Converting $number Mb to bytes"
	    bytesize=$(echo "$number * 1024 * 1024" | bc -l )
	    bytesize=$(printf "%.0f" $bytesize)
	elif [[ "$suffix" == [gG] ]]; then
	    echo "Converting $number Gb to bytes"
	    bytesize=$(echo "$number * 1024 * 1024 * 1024" | bc -l )
	    bytesize=$(printf "%.0f" $bytesize)
	elif [[ "$suffix" == "" ]]; then
	    echo "Using number as bytes"
	    bytesize=$number
	else
	    echo "What's going on with your input?"
	    return
	fi
	echo "finding files > $bytesize bytes"
	findparams="-size +${bytesize}c"
    fi	
    if [[ "$howtoghost" == "n" || "$howtoghost" == "b" ]]; then
	read -ep $'Enter in a search string for the file name:\n ' getname
	findparams="${findparams} -name '${getname}'" 
    fi
    echo "find command is: "
    findcommand="find * -maxdepth 0 -type f ${findparams}"
    echo "$findcommand"
    # https://askubuntu.com/questions/476523/build-command-by-concatenating-string-in-bash
    files=$(eval "$findcommand")
    if [[ $? != "0" ]]; then
	echo "Find failed; quitting."
	return
    elif [[ -z "$files" ]]; then
	echo "files: $files"
	echo "Find returned no results for your query; quitting."
	return
    fi

    echo "found files: "
    for file in $files; do
	ls -lah "$file"
    done
    lsresults=$(ls -lah)
    read -ep $'Whoa doggie, are you sure you want to wipe out these files? Type "yes" to consent.\n ' rawInput
    case $rawInput in
	yes)	
	    read -ep $'What message do you want put in these files?\n ' note
	    for file in $files; do
		exitcodes=0
		md5hash=$(md5sum $file)	    
		let "exitcodes+=$?"
		statit=$(stat --printf="%n\tperms: %A %U (%G)\tsize: %s bytes\naccess time:%.19x\nmod time: %.19y\nchanged time: %.19z\n" $file)
		let "exitcodes+=$?"
		filetype=$(file $file)
		let "exitcodes+=$?"
		datetime=$(date "+%m/%d/%Y %H:%M:%S")
		let "exitcodes+=$?"
		lines=$(wc -l $file)
		let "exitcodes+=$?"
		if [[ $exitcodes > 0 ]]; then
		    echo "Something went wrong; not destroying"
		    return
		fi
		echo "####################################################################" > $file
		echo "   You are looking at the ghost of the file $file " >> $file	    
		echo "####################################################################" >> $file
		echo "" >> $file
		echo "clg deleted this file on $datetime" >> $file
		echo "Notes: " >> $file
		echo "$note" >> $file
		echo "" >> $file
		echo "Here is the metadata assoc with this file before deletion. " >> $file
		echo "pwd: $PWD" >> $file
		echo "md5sum: $md5hash" >> $file
		echo "lines: $lines" >> $file
		echo "$statit" >> $file
		echo "$filetype" >> $file
		echo "The directory that contained this file was like this:" >> $file
		echo "$lsresults" >> $file	    
	    done
	    ;;
	*)
	    echo "Did not delete; getting outta here!"
	    return
	    ;;
    esac
}
