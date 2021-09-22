#!/usr/bin/env python     

import argparse
import os
import sys

parser = argparse.ArgumentParser(prog=os.path.basename(sys.argv[0]), formatter_class=argparse.ArgumentDefaultsHelpFormatter, description=__doc__)

parser.add_argument('goldstandard', type=argparse.FileType('rt'), default=None, help="Gold-standard file")  
parser.add_argument('test', type=argparse.FileType('rt'), default=None, help="File to be compared with the gold-standard")  

args = parser.parse_args()

goldstandard=""
test=""

for i in args.goldstandard:
    goldstandard = goldstandard+i

for j in args.test:
    test = test+j

g = goldstandard.replace(" ","")
t = test.replace(" ","")

g_rep = g.replace("\n", "")
t_rep = t.replace("\n", "")

assert g_rep == t_rep

tp = 0
fp = 0
fn = 0

gc = 0
tc = 0
while gc < len(g) and tc < len(t):
    if g[gc] == "\n":
        if t[tc] == "\n":
            tp += 1
            gc += 1
            tc += 1
        else:
            fn += 1
            gc += 1
    elif t[tc] == "\n":
        fp += 1
        tc += 1
    else:
        gc += 1
        tc += 1

precision = float(tp)/float(tp+fp)
recall = float(tp)/float(tp+fn)
F_measure = (2*precision*recall)/(precision+recall)

print("True positives: {}".format(tp))
print("False positives: {}".format(fp))
print("False negatives: {}".format(fn))
print("Precision: {}".format(precision))
print("Recall: {}".format(recall))
print("F-measure: {}".format(F_measure))