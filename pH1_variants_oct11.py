# -*- coding: utf-8 -*-
"""
Created on Tue Oct 11 14:53:05 2016

@author: ambati
"""
#dependencies - Biopython (from terminal type "PIP install biopython" without colons
#For a protein fasta file to create a 16aa overlap with 4 aa shift - 16mer epitope
from Bio import SeqIO
with open("output.txt", "w") as f: ##intialize a text file to be populate from for loop
	for record in SeqIO.parse("example.fasta", "fasta"): ##path to your fasta file which you want to parse
		for i in range(0, len(record.seq), 4): ##change this to get your desired amino acid scan 4 for 4aa overlap, 5 for 5 aa overlap
			if len(record.seq[i:i+16]) >= 16: #change this to change the length of the epitope
				if "X" not in record.seq[i:i+16]: #dont consider non-amino acid characters
					print  (record.seq[i:i+16] + " " + "%i_mer" % len(record.seq[:i+16]) + ";" + record.id) #disable this if you dont want to print output on the screen
					f.write (str(record.seq[i:i+16] + ";" + "%i_mer" % len(record.seq[:i+16])) + ";" + record.id +"\n")

		

