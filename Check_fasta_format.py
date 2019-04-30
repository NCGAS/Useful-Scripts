import argparse

import sys
from Bio import SeqIO
from Bio.SeqUtils import GC
def CheckFasta(FileIn,FileOut):
    fin =open(FileIn)
    fout=open(FileOut,"w")
    Records=[]
    for record in SeqIO.parse(fin,'fasta'):
        Records.append(record)

    for sequence in Records:
	SeqIO.write(sequence, fout,"fasta")

parser = argparse.ArgumentParser()

parser.add_argument('-c', action='store', dest='contigs',
                    help='Contigs fasta file')

parser.add_argument('-o', action='store', dest='output',
                    help='Output text file')

results = parser.parse_args()
CheckFasta(results.contigs, results.output)
