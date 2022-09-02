# Sentence splitting tests

Tests performed by [@mbanon](https://github.com/mbanon), in sept'22.

Benchmarked tools:
* [Loomchild](https://github.com/mbanon/segment): Java tool, segmentation based on SRX rules (several SRX files benchmarked)
* [Moses](https://github.com/kpu/preprocess/blob/master/moses/ems/support/split-sentences.perl): Perl tool
* [Ulysses](https://sourceforge.net/projects/bitextor/files/bitextor/bitextor-5.0/): Python 2 tool, statistical segmentation.
* [NLTK](https://www.nltk.org/_modules/nltk/tokenize.html#sent_tokenize): Python 3 tool, segmentation based on a punctuation model.
* [ersatz](https://github.co/rewicks/ersatz)
* [sentence_splitter](https://github.com/mediacloud/sentence-splitter): Pyhon port of Moses.
* [loomchild-segment](https://github.com/zuny26/loomchild-segment-py): Python module for the Loomchild Java tool.
* [srx](https://github.com/bminixhofer/srx): Rust reimplementation of the SRX standard

Gold Standards are located in this repository.
Benchmarks ran on a Intel(R) Core(TM) i7-7800X CPU @ 3.50GHz machine.

## How to reproduce

### Building test sets

First, build the test sets from the gold standard files:
```
python3 build-testset.py
```
For each gold standard file (`{resource}_{languagename}.dataset.gold`), this produces three test files:
  * `{resource}_{languagename}.dataset.none`: All line breaks are removed, all sentences from the gold standard are concat in a single paragraph.
  * `{resource}_{languagename}.dataset.all`: All line breaks are kept, each sentence is in a separated paragraph.
  * `{resource}_{languagename}.dataset.mixed`: Sentences are joined in paragraph with a length of 3-8 sentences, mocking real-world text structure.

### Installing the tools

Then, install the tools to be benchmarked.

#### Loomchild (Java)

Follow [installation guide](https://github.com/mbanon/segment/blob/master/README.md). 

#### Moses (Perl)

`git clone https://github.com/kpu/preprocess/`

#### Ulysses

Download and extract [Bitextor 5.0](https://sourceforge.net/projects/bitextor/files/bitextor/bitextor-5.0/).  

#### NLTK

`python3 -m pip install nltk`.

#### Ersatz

`python3 -m pip install ersatz`.


#### Sentence Splitter (Moses Python port)

`python3 -m pip install sentence_splitter`


#### Loomchild Segment (Loomchild Python module)

`python3 -m pip install loomchild-segment`

#### srx (Rust)

```
git clone https://github.com/lpla/srx
cargo build --all-features --release
```

### Run the tests

Take a look to `runbatcheval.sh` and change paths if needed. Then run
```
./runbatcheval.sh {LANGCODE} {TOOL}
```

#### Supported language codes

`bg, cnr, cs, da, de, el, en, es, et, fi, fr, hr, hu, is, it, lt, lv, mk, mt, nb, nl, nn, pl, pt, ro, sk, sl, sq, sr, sv, tk, uk`

#### Supported tools
`loomchild, moses, ulysses, nltk, ersatz, pymoses, pyloomchild, rustsrx`

Several SRX rules files are provided in `srxrules`. The tool autoselects the one with the higher F-1 score
for the requested language (based on the benchmark results located in
`/benchmarks_results/srx-rules/{LANGCODE}.loomchild`

### Run everything

In case you want to run benchmarks for all supported tools in all supported languages, simply run `./runeverything.sh`. Results will be stored in`/benchmark_results/{TOOL}/{LANGUAGECODE}.{TOOL}`
### Results

Coming soon...

Deprecated: https://docs.google.com/spreadsheets/d/1mGJ9MSyMlsK0EUDRC2J50uxApiti3ggnlrzAWn8rkMg/edit#gid=0
