import sys
import timeit
import cld3



start_time = timeit.default_timer()

for line in sys.stdin:
    parts = line.strip().split("\t")
    sent = parts[0]

    prediction = cld3.get_language(sent)

    if prediction.is_reliable:
        print(sent+"\t"+prediction.language)
    else:
        print(sent+"\tunk")
    
end_time = timeit.default_timer()
        

print("Elapsed time: {}".format(end_time - start_time))