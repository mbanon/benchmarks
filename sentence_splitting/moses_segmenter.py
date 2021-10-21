import sys
import os
import argparse

from sentence_splitter import SentenceSplitter, split_text_into_sentences


parser = argparse.ArgumentParser(prog=os.path.basename(sys.argv[0]), formatter_class=argparse.ArgumentDefaultsHelpFormatter, description=__doc__)

parser.add_argument('langcode', type=str, help="Language code")
parser.add_argument('inputfile', type=str, help="Input file")
parser.add_argument('outputfile', type=str, help="Output file")

args = parser.parse_args()




#inputfile = open("pipeline_evaluation_data/sentence_splitting/UD_"+args.lang+".dataset")
#outputfile = open("nltk."+ args.langcode, "w")
input_f = open(args.inputfile, "r")
output_f = open(args.outputfile, "w")

try:
    splitter = SentenceSplitter(language=args.langcode)
except:
    splitter = SentenceSplitter(language="en")


for i in input_f:
    sents = splitter.split(text=i)
    for s in sents:
        output_f.write(s+"\n")