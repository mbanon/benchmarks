import nltk

import argparse
import os
import sys

from nltk.tokenize import sent_tokenize

try:
    nltk.data.find('tokenizers/punkt')
except:
    nltk.download('punkt', quiet=True)

parser = argparse.ArgumentParser(prog=os.path.basename(sys.argv[0]), formatter_class=argparse.ArgumentDefaultsHelpFormatter, description=__doc__)

parser.add_argument('lang',  type=str, help="Language")  
parser.add_argument('inputfile', type=str, help="Input file")
parser.add_argument('outputfile', type=str, help="Output file")

args = parser.parse_args()

#inputfile = open("pipeline_evaluation_data/sentence_splitting/UD_"+args.lang+".dataset")
#outputfile = open("nltk."+ args.langcode, "w")
input_f = open(args.inputfile, "r")
output_f = open(args.outputfile, "w")


for i in input_f:
    try:
        sents = sent_tokenize(i, args.lang.lower())
    except:
        #print("Failed tokenizer for " + args.lang.lower()), #fallback to 'en'
        sents = sent_tokenize(i)
    for s in sents:
        output_f.write(s+"\n")