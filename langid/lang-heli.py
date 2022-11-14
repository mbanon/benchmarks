import sys
import timeit
import time
from toolwrapper import ToolWrapper

heli = ToolWrapper(['java', '-jar', 'heliots/HeLI.jar'])
time.sleep(8)

start_time = timeit.default_timer()

for line in sys.stdin:
    parts = line.strip().split("\t")
    sent = parts[0]

    heli.writeline(sent)
    print(sent+"\t"+heli.readline())

end_time = timeit.default_timer()

print("Elapsed time: {}".format(end_time - start_time), file=sys.stderr)
