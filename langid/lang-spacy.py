import sys
import timeit
import spacy

import spacy_fastlang

nlp = spacy.blank("xx")
nlp.add_pipe("language_detector")


start_time = timeit.default_timer()

for line in sys.stdin:
    parts = line.strip().split("\t")
    sent = parts[0]
    
    doc = nlp(sent)

    prediction = doc._.language
    print(sent+"\t"+prediction)
    
end_time = timeit.default_timer()
        

print("Elapsed time: {}".format(end_time - start_time))