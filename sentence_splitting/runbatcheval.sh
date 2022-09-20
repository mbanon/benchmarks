LC=$1
TOOL=$2

#Edit the vars below to adapt this script to your environment
PYTHON=python3.10
#loomchild
SEGMENT_TARGET_PATH=~/segment/segment-ui/target/
export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64/
#moses
PREPROCESS_PATH=~/preprocess/
#ulysses
BITEXTOR_PATH=~/bitextor-5.0.0/
PYTHON2=python2.7
#rustsrx
RUSTSRX_PATH=~/srx/target/release/

PREFIX=UD #UniversalDependencies
case $LC in
	bg)
		LN=Bulgarian
		RULES=OmegaT
		;;
	cnr)
		LN=Montenegrin
		PREFIX=MESUBS #MontenegrinSubs
		RULES=NonAggressive
		;;
	cs)
		LN=Czech
		RULES=OmegaT
		;;
	da)
		LN=Danish
		RULES=language_tools.segment
		;;
	de)
		LN=German
		RULES=language_tools.segment
		;;
	el)
		LN=Greek
		RULES=PTDR
		;;
	en)
		LN=English
		RULES=language_tools.segment
		;;			
 	es)
		LN=Spanish
		RULES=OmegaT
		;;
	et)
		LN=Estonian
		RULES=PTDR
		;;
	fi)
		LN=Finnish
		RULES=PTDR
		;;
	fr)
		LN=French
		RULES=rust
		;;
	hr)
		LN=Croatian
		RULES=PTDR
		;;
	hu)
		LN=Hungarian
		RULES=OmegaT
		;;
	is)
		LN=Icelandic
		RULES=language_tools.segment
		;;
	it)	
		LN=Italian
		RULES=NonAggressive
		;;
	lt)
		LN=Lithuanian
		RULES=OmegaT
		;;
	lv)	
		LN=Latvian
		RULES=PTDR
		;;
	mk)
		LN=Macedonian
		PREFIX=SETIMES #Souteast European Times  
		RULES=OmegaT
		;;
	mt)
		LN=Maltese
		RULES=PTDR
		;;
	nb)
		LN=Norwegian-Bokmaal
		RULES=NonAggressive
		;;
	nl)
		LN=Dutch
		RULES=rust
		;;
	nn)
		LN=Norwegian-Nynorsk
		RULES=NonAggressive
		;;
	pl)
		LN=Polish
		RULES=language_tools.segment
		;;
	pt)
		LN=Portuguese
		RULES=language_tools.segment
		;;
	ro)
		LN=Romanian
		RULES=language_tools.segment
		;;
	sk)
		LN=Slovak
		RULES=language_tools.segment	
		;;
	sl)
		LN=Slovenian
		RULES=OmegaT
		;;
	sq)
		LN=Albanian
		PREFIX=SETIMES
		RULES=OmegaT
		;;
	sr)
		LN=Serbian
		RULES=language_tools.segment
		;;	
	sv)
		LN=Swedish
		RULES=OmegaT
		;;
	tr)
		LN=Turkish
		RULES=NonAggressive
		;;
	uk)
		LN=Ukrainian
		RULES=rust
		;;	
					
esac

mkdir -p outfiles/
GOLD=testsets/$PREFIX"_"$LN.dataset.gold;

echo "#################################"
echo $LC "("$LN")"
echo "Gold standard:" $PREFIX
echo "Tool: " $TOOL
echo "#################################"
	
for FLAVOUR in none all mixed
do

        echo "Testset segmentation (none: no line breaks; all: same as gold standard; mixed: paragraph-like text):" $FLAVOUR
        TESTFILE=testsets/$PREFIX"_"$LN.dataset.$FLAVOUR
        OUTFILE=outfiles/$PREFIX"_"$LC"_"$TOOL.$FLAVOUR.out
        case $TOOL in
                loomchild)
                	#for RULES in OmegaT NonAggressive PTDR language_tools.segment rust
	                #do
	                	#Installation: https://github.com/mbanon/segment/blob/master/README.md#installation 
	                        echo "Loomchild SRX rules: " $RULES
	                        OUTFILE=outfiles/$PREFIX"_"$LC"_"$TOOL"_"$RULES.$FLAVOUR.out
	                        time java -cp $SEGMENT_TARGET_PATH/segment-ui-2.0.4-SNAPSHOT.jar:$SEGMENT_TARGET_PATH/segment-2.0.4-SNAPSHOT/lib/* net.loomchild.segment.ui.console.Segment -l $LC -i $TESTFILE -o $OUTFILE -s srxrules/$RULES.srx
	                        $PYTHON  segmenteval.py $GOLD $OUTFILE
        	                echo "============================="
        	        #done
                        ;;
                moses)  
                	#git clone https://github.com/kpu/preprocess/
                	time $PREPROCESS_PATH/moses/ems/support/split-sentences.perl -l $LC < $TESTFILE > $OUTFILE
			$PYTHON  segmenteval.py $GOLD $OUTFILE                	
			echo "============================="
                        ;;
                ulysses)
                	#wget https://downloads.sourceforge.net/project/bitextor/bitextor/bitextor-5.0/bitextor-5.0.0-RC3.tar.gz
                	time $PYTHON2  $BITEXTOR_PATH/ulysses/ulysses/ulysses.py  $TESTFILE $OUTFILE
			$PYTHON segmenteval.py $GOLD $OUTFILE
			echo "============================="
                        ;;
                nltk)   
                	#$PYTHON -m pip install nltk
                	time $PYTHON nltk_segmenter.py $LN $TESTFILE  $OUTFILE
			$PYTHON segmenteval.py  $GOLD $OUTFILE
			echo "============================="
                        ;;
                ersatz) 
                	#$PYTHON -m pip install ersatz
                	time (cat $TESTFILE | $PYTHON -m ersatz > $OUTFILE)
			$PYTHON segmenteval.py $GOLD $OUTFILE
			echo "============================="
                        ;;
                pymoses)
                	#$PYTHON -m pip install sentence_splitter
                	time $PYTHON moses_segmenter.py $LC $TESTFILE $OUTFILE
			$PYTHON segmenteval.py $GOLD $OUTFILE
                        ;;
                pyloomchild)
                	#$PYTHON -m pip install loomchild-segment
                	time $PYTHON loomchild_segmenter.py $LC $TESTFILE $OUTFILE
			$PYTHON segmenteval.py $GOLD $OUTFILE
                        ;;
                rustsrx)
                	#git clone https://github.com/lpla/srx
                	#cargo build --all-features --release
                	time $RUSTSRX_PATH/srx --input $TESTFILE --output $OUTFILE --srxfile srxrules/examplesrust.srx --language $LC
                        $PYTHON segmenteval.py $GOLD $OUTFILE
			;;                	
                *)
                        echo "Unsupported tool"
                        exit 1
                        ;;
        esac
done

