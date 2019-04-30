#!/usr/bin/env python
# This code is a biopython code that extracts the fasta sequences from a list of interested seqIDs. 
# Written from https://www.biostars.org/p/1709/, modified by Bhavya on Oct 31st.
# Contact bhnala@iu.edu 
# Use python ExtractSeq -in <fasta.file> -i <list of interested seqIDs> -o <output file> 
#

import argparse
import sys
from Bio import SeqIO
from Bio.SeqUtils import GC

def ExtractSeq(fastaIn,Indexlist,fastaOut):
    	fasta_file =open(fastaIn) #input fasta file 	
	wanted_file=open(Indexlist) #input a list interested sequeences
    	result_file=open(fastaOut,"w") #output fasta file

	wanted = set()
	with wanted_file as f:
    		for line in f:
        		line = line.strip()
        		if line != "":
            			wanted.add(line)
				#print line

	fasta_sequences = SeqIO.parse(fasta_file,'fasta')
	with result_file as f:
    		for seq in fasta_sequences:
			#print seq.id
        		if seq.id in wanted:
            			SeqIO.write([seq], f, "fasta")



parser = argparse.ArgumentParser()

parser.add_argument('-in', action='store', dest='contigs',
                    help='fasta files')
parser.add_argument('-i', action='store', dest='index',
                    help='list of interested sequences')
parser.add_argument('-o', action='store', dest='output',
                    help='Output fasta file')

results = parser.parse_args()
print 'Contigs File     =', results.contigs
print 'Index list       =', results.index
print 'Output stored in       =', results.output

ExtractSeq(results.contigs, results.index, results.output)
