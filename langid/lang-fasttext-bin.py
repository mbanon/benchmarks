import sys
import timeit
import fasttext

model = fasttext.load_model('lid.176.bin')

start_time = timeit.default_timer()

prefix = "__label__"


for line in sys.stdin:
    parts = line.strip().split("\t")
    sent = parts[0]
    print(sent+"\t"+model.predict(sent, k=1)[0][0][len(prefix):])

    
end_time = timeit.default_timer()
        

print("Elapsed time: {}".format(end_time - start_time))