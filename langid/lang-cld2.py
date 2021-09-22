import sys
import timeit
import pycld2 as cld2



start_time = timeit.default_timer()

for line in sys.stdin:
    parts = line.strip().split("\t")
    sent = parts[0]

    isReliable, textBytesFound, details = cld2.detect(sent)
    lang_detected = details[0][1]

    if isReliable:
        print(sent+"\t"+lang_detected)
    else:
        print(sent+"\tunk")
    
end_time = timeit.default_timer()
        

print("Elapsed time: {}".format(end_time - start_time))