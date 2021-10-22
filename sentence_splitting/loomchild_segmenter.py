import sys
import os
import argparse


from loomchild.segmenter import LoomchildSegmenter

parser = argparse.ArgumentParser(prog=os.path.basename(sys.argv[0]), formatter_class=argparse.ArgumentDefaultsHelpFormatter, description=__doc__)

parser.add_argument('langcode', type=str, help="Language code")
parser.add_argument('inputfile', type=str, help="Input file")
parser.add_argument('outputfile', type=str, help="Output file")

args = parser.parse_args()

input_f = open(args.inputfile, "r")
output_f = open(args.outputfile, "w")

segmenter = LoomchildSegmenter(args.langcode)


for i in input_f:
    sents = segmenter.get_segmentation(i)
    for s in sents:
        output_f.write(s+"\n")

        
        
