import os
import re

from random import randint

dataset_path = os.path.join(os.path.dirname(__file__), "testsets")
#option = ["all", "none", "mixed"]


for gold in os.listdir(dataset_path):
    if gold.endswith(".gold"):
        with open(os.path.join(dataset_path, gold), "r")  as g_file:
            sentences = []
            for sent in g_file:
                sentences.append(sent.strip())
        all_filename = re.sub('.gold$', '.all', gold)
        none_filename = re.sub('.gold$', '.none', gold)
        mixed_filename = re.sub('.gold$', '.mixed', gold)

        #All: Contains all the line breaks as the gold standard file
        with open(os.path.join(dataset_path, all_filename), "w") as all_file:
            for sent in sentences:
                all_file.write(sent+"\n")
                
        #None: No line breaks
        with open(os.path.join(dataset_path, none_filename), "w") as none_file:
            none_file.write(" ".join(sentences) + "\n")
                
        #Mixed: Simmulate paragraphs with a length of 3-8 sentences                        
        with open(os.path.join(dataset_path, mixed_filename), "w") as mixed_file:
            paragraph_length = 0
            paragraph = []
            for sent in sentences:
                if paragraph_length == 0:
                    paragraph_length = randint(3,8)
                paragraph.append(sent)
                paragraph_length = paragraph_length-1    
                if paragraph_length == 0:
                    mixed_file.write(" ".join(paragraph) + "\n")
                    paragraph = []
            mixed_file.write(" ".join(paragraph) + "\n")

                
            
    