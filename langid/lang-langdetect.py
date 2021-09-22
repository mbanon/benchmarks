import sys
import timeit
from langdetect import detect


start_time = timeit.default_timer()

for line in sys.stdin:
    parts = line.strip().split("\t")
    sent = parts[0]

    print(sent+"\t"+detect(sent))

    
end_time = timeit.default_timer()
        

print("Elapsed time: {}".format(end_time - start_time))