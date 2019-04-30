#!/N/soft/rhel7/python/2.7.13a/bin/python
import sys

#######
# Written Dec 2017 by Sheri Sanders
# Syntax: addcolumns.py input_file blast_file output_file
#    input_file is in form: name\tlength (see RunSeqLength for generating this file)
#    blast_file is blast output generated with input_file
#    output_file is whatever you'd like to store it as
#######

#addcolumns.py input blast output
input = sys.argv[1]
blast = sys.argv[2]
output = sys.argv[3]

#define library to hold name:length
length_hash={}  

#open first file
input_file = open(input, "r")

#read in library name:length
for entry in input_file:
    line = entry.split()
    length_hash[line[0]]=int(line[1])

#close file
input_file.close()

#open second file (blast)
out_file = open(output, "w")
blast_file = open(blast, "r")

#read in line
for entry in blast_file:
    line = entry.split()
    length = length_hash[line[1]]
    percent = '{0:.2f}'.format((float(line[3])/float(length))*100.00)

#output file
    out_file.write("\t".join(line))
    out_file.write("\t" + str(length) + "\t" + str(percent) + "\n")

#close files
blast_file.close()
out_file.close()
