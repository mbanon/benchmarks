import sys
import timeit
from langid.langid import LanguageIdentifier, model

identifier = LanguageIdentifier.from_modelstring(model, norm_probs=True)
threshold = 0.5

start_time = timeit.default_timer()

for line in sys.stdin:
    parts = line.strip().split("\t")
    sent = parts[0]

    prediction = identifier.classify(sent)
    label = prediction[0]    
    probability = prediction[1]

    
    if probability >= threshold:
        print(sent+"\t"+label)
    else:
        print(sent+"\tunk")
    
end_time = timeit.default_timer()
        

print("Elapsed time: {}".format(end_time - start_time))