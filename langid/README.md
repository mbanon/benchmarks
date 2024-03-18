# benchmarks

## Language identification


Benchmarked tools:
* [pycdl2](https://github.com/aboSamoor/pycld2): Python bindings for the Compact Langauge Detect 2 (CLD2).
* [pycld3](https://pypi.org/project/pycld3/): Python bindings to the Compact Language Detector v3 (CLD3).
* [langid](https://github.com/saffsd/langid.py): Stand-alone language identification system
* [fastlang](https://spacy.io/universe/project/spacy_fastlang): Part of Spacy, based on FastText. 
* [langdetect](https://github.com/Mimino666/langdetect): Port of Google's language-detection library to Python.
* [NLTK](https://www.nltk.org/api/nltk.classify.html#nltk.classify.textcat.TextCat.guess_language)
* [spirit](https://pypi.org/project/guess_language-spirit/)
* [fasttext](https://fasttext.cc/docs/en/language-identification.html): FastText is a library for text classification and representation. It transforms text into continuous vectors that can later be used on any language related task.
* [hunspell](http://hunspell.github.io/): Spellchecker
* [FastSpell](https://github.com/mbanon/fastspell): Targetted language identificator, based on FastText and Hunspell
* [HeLI-OTS](https://zenodo.org/record/7066611): HeLI off-the-shelf language identifier with language models for 200 languages.


Run each lang-\*\*.py file, for example:

```
cat testsets/gold/goldstandard.gl  | python3.7 lang-cld3.py 
```

(except for `lang-fastspell.py` that requires the targetted language to be passed as an argument, for example: `cat testsets/gold/goldstandard.gl  | python3.7 lang-cld3.py gl`)

For some tools and/or languages, you may need to install some packages (i.e. `hunspell-??` for Hunspell) or download some files (i.e. FastText models). Also, each file has different requirements (so no `requirements.txt` file is
provided), but most of them can be installed directly from `pip`.

For a comparable output:

```
for L in ca da es gl nb nn bg bs cs el hr me mk ro sk sl sq sr tr; do echo $L && cat testsets/gold/goldstandard.$L  | python3.7 lang-cld3.py | cut -f2 | sort | uniq -c | sort -nr  ; done
```

Test files are located under `/testsets/`, being `/testsets/gold/goldstandard.??` the gold standards (all sentences are in the target language), and `/testsets/antigold/not.??` (all sentences in languages that are not the target language).
Gold standards were extracted from [Paracrawl](http://paracrawl.eu) human evaluations (sentences tagged as "Valid"): https://github.com/paracrawl/human-evaluations/tree/master/paracrawl-v7-validation 

Some benchmark results as in March'24: https://docs.google.com/spreadsheets/d/158ZRWMgRH5TptlFWpKyh5uRL5jTkKW1d4KGJg1AZf7A/edit?usp=sharing


## Installation
### HeLI-OTS
Install Zenodo downloader:
```
pip install zenodo_get
```
and download HeLI:
```
mkdir heliots && cd heliots
zenodo_get 7066611
cd ..
```
