import sys
import timeit
#from fastspell import FastSpell
import fastspell

#model = fasttext.load_model('lid.176.bin')

start_time = timeit.default_timer()

#prefix = "__label__"

lang=sys.argv[1]
#fsobj = FastSpell.FastSpell(lang, mode="aggr")

fs = fastspell.FastSpell(lang, mode="cons")

for line in sys.stdin:
    parts = line.strip().split("\t")
    sent = parts[0]
    print(sent+"\t"+fs.getlang(sent))

    
end_time = timeit.default_timer()
        

print("Elapsed time: {}".format(end_time - start_time))
