import os
import sys
import timeit
import argparse
import hunspell
import logging
from sacremoses import MosesTokenizer

def error_rate(text,lan,spchk,tknzr):
    tktxt=tknzr.tokenize(text, escape=False)
    try:
       error_list=list(map(spchk.spell,tktxt))
    except UnicodeEncodeError as uee:
        logging.error(uee)
        return 1   
    except LookupError as le:
        logging.error(le)
        return 1    
    errors=sum(error_list*1)
    total_lenght=len(error_list)
    if total_lenght == 0:
        return 1
    error_rate=errors/total_lenght
    return 1-error_rate


dictpath="/usr/share/hunspell/"

parser = argparse.ArgumentParser(prog=os.path.basename(sys.argv[0]), formatter_class=argparse.ArgumentDefaultsHelpFormatter, description=__doc__)
parser.add_argument('lang', type=str)
args = parser.parse_args()


if (args.lang == "gl"):
    dict_trg = dictpath+"/gl_ES"
    tokenizer_trg = MosesTokenizer("es") #not available for gl
elif (args.lang == "ca"):
    dict_trg = dictpath+"/ca_ES"
    tokenizer_trg = MosesTokenizer("ca")
elif (args.lang == "es"):
    dict_trg = dictpath+"/es_ES"
    tokenizer_trg = MosesTokenizer("es")
elif (args.lang == "da"):
    dict_trg = dictpath+"/da_DK"
    tokenizer_trg = MosesTokenizer("da")
elif (args.lang == "nb"): 
    dict_trg = dictpath+"/nb_NO"
    tokenizer_trg = MosesTokenizer("nb")
elif (args.lang == "nn"):
    dict_trg = dictpath+"/nn_NO"
    tokenizer_trg = MosesTokenizer("nb") #not available for nn
elif (args.lang == "ro"):
    dict_trg = dictpath+"/ro_RO"
    tokenizer_trg = MosesTokenizer("ro")
elif (args.lang == "hr"):
    dict_trg = dictpath+"/hr_HR"
    tokenizer_trg = MosesTokenizer("en") #not available for hr    
elif (args.lang == "bg"):
    dict_trg = dictpath+"/bg_BG"
    tokenizer_trg = MosesTokenizer("en") #not available for bg
elif (args.lang == "bs"):
    dict_trg = dictpath+"/bs_BA"
    tokenizer_trg = MosesTokenizer("en") #not available for bs
elif (args.lang == "cs"):
    dict_trg = dictpath+"/cs_CZ"
    tokenizer_trg = MosesTokenizer("cs") 
elif (args.lang == "me"):
    dict_trg = dictpath+"/sr_ME"
    tokenizer_trg = MosesTokenizer("en")    
elif (args.lang == "el"):
    dict_trg = dictpath+"/el_GR"
    tokenizer_trg = MosesTokenizer("el")
elif (args.lang == "mk"):
    dict_trg = dictpath+"/mk_MK"
    tokenizer_trg = MosesTokenizer("en")  #not available for mk
elif (args.lang == "sk"):
    dict_trg = dictpath+"/sk_SK"
    tokenizer_trg = MosesTokenizer("sk")
elif (args.lang == "sl"):
    dict_trg = dictpath+"/sl_SI"
    tokenizer_trg = MosesTokenizer("sl")
elif (args.lang == "sq"):
    dict_trg = dictpath+"/sq_AL"
    tokenizer_trg = MosesTokenizer("en") #Not available for sq
elif (args.lang == "sr"):
    dict_trg = dictpath+"/sr_Latn_RS"
    tokenizer_trg = MosesTokenizer("en") #Not available for sr
elif (args.lang == "tr"):
    dict_trg = dictpath+"/tr_TR"
    tokenizer_trg = MosesTokenizer("tr") 
else:
    logging.error("Invalid lang")
    sys.exit()


threshold = 0.25

hunspell_trg = hunspell.HunSpell(dict_trg+'.dic', dict_trg+'.aff')
start_time = timeit.default_timer()

for line in sys.stdin:
    parts = line.strip().split("\t")
    sent = parts[0]

#    trg_toks = tokenizer_trg.tokenize(sent, escape=False)
#    trg_corrects = sum(list(map(hunspell_trg.spell, trg_toks))*1)
    
    #decoded_sent = sent.encode('latin-1', 'replace' ).decode('latin-1')
    #print(sent)
    
    decoded_sent= sent.encode(encoding='UTF-8',errors='strict').decode('UTF-8')
    
    #print(decoded_sent)
    
    errors = error_rate(decoded_sent, args.lang, hunspell_trg, tokenizer_trg)


    if (errors <= threshold):
        print(sent+"\t"+args.lang)
    else:
       print(sent+"\tunk")
    
end_time = timeit.default_timer()
        

print("Elapsed time: {}".format(end_time - start_time))