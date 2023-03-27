import sys
import random
from random import randint
from optparse import OptionParser, OptionGroup

#Author: Martin Kapun 

#########################################################   HELP   #########################################################################
usage="python %prog --sync input.sync --target-cov 40 --min-cov 10 > output.sync  "
parser = OptionParser(usage=usage)
group=OptionGroup(parser,
"""
H E L P:
____________
This script converts resamples the allele counts in a sync file (--input) to a target coverage (--target-cov) if the counts are above a minimum-coverage threshold (--min-cov).
Note, sites with less coverage than the target will be sampled with replacement, whereas sites with larger coverage will be sampled with replacement.
The X chromsome will be sampled by half since this script is intended for Pools based on males only
""") 
#########################################################   CODE   #########################################################################

parser.add_option("--sync", dest="input", help="A sync file")
#parser.add_option("--target-cov", dest="C", help="The target coverage")
#parser.add_option("--min-cov", dest="M", help="The minimum coverage threshold")

parser.add_option_group(group)
(options, args) = parser.parse_args()

def nuc(z):
    '''convert the sync formated data z to a string of all nucleotides and subsample If the coverage is above a max-coverage threshold'''
    al=["A","T","C","G"]
    nu=""
    cov=z.split(":")[:4]
    for i in range(4):
        if cov[i] != ".":
            nu+=al[i]*int(cov[i])
            #print(len(nu))
        else:
            nu=nu
    return nu

def count2sync(x):
    ''' convert counts to sync '''
    counts=[]
    for y in ["A","T","C","G","N","D"]:
        counts.append(x.count(y))
    return ":".join(map(str,counts))

#C=int(options.C)
#M=int(options.M)
data=open(options.input,"r")
#MX=M/2
#CX=C/2


#allsamples=[0 for i in range(0,xl)]

b=737
allsamples=[0 for i in range(0,b)]

for l in data:
    a=l.rstrip().split()
    if len(a)<2:
        continue
    
    #if a[0]=="X":
    #    mc=MX
    #    cov=CX
    #else:
    #    mc=M
    #    cov=C
        
    pops=a[3:]
    popl=[]
    for index, x in enumerate(pops):
        pop=len(nuc(x)) ##alteration made with len()
        popl.append(pop) ##added
    samplesum=[]    
    for i in range(0,(len(a[3:]))):
        samplesum.append(popl[i])
        allsamples[i] = allsamples[i] + samplesum[i]   
    #print(samplesum)
for i in range(0,737):
    allsamples[i] = round(int(allsamples[i])/b , 4)
print(','.join(map(str,allsamples)))
    

