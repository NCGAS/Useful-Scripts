# Useful-Scripts
Some useful scripts we use all the time for quick manipulation of files. Most of these scripts are written by us, but we do use others scripts as well, as mentioned below. 

## RunSeqLength
sequence length in a one line fasta file \
 `cat fasta.fa | ./RunSeqLength | less`
 
## fasta2oneline 
Convert a multifasta file to 2line fasta \
`file | fasta2oneline.ba > Singleline.file.fasta`

## addcolumns.py 
Add columns to a blast output \
 `addcolumns.py input_file blast_file output_file`

## subset_fasta.pl
This is code written by Author: John Nash so please do look at the code for the LICENSE information or below\

Function:  Takes a multiple fasta file and removes a set of sequences to makes a second fasta file.  Useful for pulling subsets of sequences from entire genomes. \
Author: John Nash \
Copyright (c) National Research Council of Canada, 2000-2003, all rights reserved. \
Licence: This script may be used freely as long as no fee is charged for use, and as long as the author/copyright attributions are not removed. 

Syntax: \
`subset_fasta -i list_file < fasta_file > subset_file`

For more options, run the command \
`subset_fasta -h`

## Check_fasta_format.py
Format a corrupt fasta file to the right fasta format using biopython. \
`Check_fasta_format.py -c CONTIGS -o OUTPUT`

## Extract Interested sequences only from a fasta file 
Extract all the sequences of interest from a fasta file using this script \
`Extract_Interested_Seq.py -in CONTIGS -i INDEX -o OUTPUT`

## fastq-splitter
This code is writted by Author: Kirill Kryukov, so please do look at the code for the LICENSE information. 
FASTQ Splitter  -  a script for partitioning a FASTQ file into n pieces

Syntax: \
`fastq-splitter.pl [options] <file>`

For more options, run the command \
`perl fastq-splitter.pl -h`

## Bashrc
This file can be used instead of or in addition to your .bashrc file found in your home directory. It includes aliases to common mispellings and fat-fingers on the command line, changes your prompt to always display the time and your current path, and gives you a function for wiping out swaths of files from the data capacitor quickly.

Right now it is set to work with Carbonate. If you want to try it out, you can source it like so: \
```bash
source bashrc
# or
. bashrc
```

If you like it you can save your old bashrc file like this: \
`cp ~/.bashrc ~/.bashrc_save` \
If that succeeded, do: \
`rm ~/.bashrc` 

Then copy this bashrc to ~/.bashrc. You can also add that source command into your own .bashrc file. Note the . in front!


## Contact us
Contact help@ncgas.org if you have any questions. 





