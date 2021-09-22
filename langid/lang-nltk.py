import sys
import timeit
import nltk

nltk.download("crubadan")
tc = nltk.classify.textcat.TextCat() 


start_time = timeit.default_timer()

for line in sys.stdin:
    parts = line.strip().split("\t")
    sent = parts[0]

    print(sent+"\t"+tc.guess_language(sent))

    
end_time = timeit.default_timer()
        

print("Elapsed time: {}".format(end_time - start_time))