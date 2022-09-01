LC=$1
TOOL=$2

#Edit the vars below to adapt this script to your environment
PYTHON2=python2.7
PYTHON=python3.10
#loomchild
SEGMENT_TARGET_PATH=~/segment/segment-ui/target/
export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64/
#moses
PREPROCESS_PATH=~/preprocess/
#ulysses
BITEXTOR_PATH=~/bitextor-5.0.0/


PREFIX=UD #UniversalDependencies
case $LC in
	bg)
		LN=Bulgarian
		;;
	cnr)
		LN=Montenegrin
		PREFIX=MESUBS #MontenegrinSubs
		;;
	cs)
		LN=Czech
		;;
	da)
		LN=Danish
		;;
	de)
		LN=German
		;;
	el)
		LN=Greek
		;;
	en)
		LN=English
		;;			
 	es)
		LN=Spanish
		;;
	et)
		LN=Estonian
		;;
	fi)
		LN=Finish
		;;
	fr)
		LN=French
		;;
	hr)
		LN=Croatian
		;;
	hu)
		LN=Hungarian
		;;
	is)
		LN=Icelandic
		;;
	it)
		LN=Italian
		;;
	lt)
		LN=Lithuanian
		;;
	lv)	
		LN=Latvian
		;;
	mk)
		LN=Macedonian
		PREFIX=SETIMES #Souteast European Times  
		;;
	mt)
		LN=Maltese
		;;
	nb)
		LN=Norwegian-Bokmaal
		;;
	nl)
		LN=Dutch
		;;
	nn)
		LN=Norwegian-Nynorsk
		;;
	pl)
		LN=Polish
		;;
	pt)
		LN=Portuguese
		;;
	ro)
		LN=Romanian
		;;
	sk)
		LN=Slovak
		;;
	sl)
		LN=Slovenian
		;;
	sq)
		LN=Albanian
		PREFIX=SETIMES
		;;
	sr)
		LN=Serbian
		;;	
	sv)
		LN=Swedish
		;;
	tk)
		LN=Turkish
		;;
	uk)
		LN=Ukrainian
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
                	#Installation: https://github.com/mbanon/segment/blob/master/README.md#installation 
                        for RULES in OmegaT NonAggressive PTDR language_tools.segment
                        do
                                echo "Loomchild SRX rules: " $RULES
                                OUTFILE=outfiles/$PREFIX"_"$LC"_"$TOOL"_"$RULES.$FLAVOUR.out
                                time java -cp $SEGMENT_TARGET_PATH/segment-ui-2.0.4-SNAPSHOT.jar:$SEGMENT_TARGET_PATH/segment-2.0.4-SNAPSHOT/lib/* net.loomchild.segment.ui.console.Segment -l $LC -i $TESTFILE -o $OUTFILE -s $SEGMENT_TARGET_PATH/../../srx/$RULES.srx
                                $PYTHON  segmenteval.py $GOLD $OUTFILE
                                echo "============================="
                        done
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
                        ;;
                ersatz) 
                        ;;
                pymoses)
                        ;;
                pyloomchild)
                        ;;
                *)
                        echo "Unsupported tool"
                        exit 1
                        ;;
        esac
done

#gold=testsets/$prefix"_"$LN.dataset.gold; testset=testsets/$prefix"_"$LN".dataset".$flavour; outfile=outfiles/$prefix"_"$LN"_"$flavour"_nltk.out";time python3.10 nltk_segmenter.py $LN $LC $testset  $outfile && python3.10 segmenteval.py  $gold $outfile
#LC=is; LN=Icelandic; prefix=UD; flavour=all; gold=testsets/$prefix"_"$LN.dataset.gold; testset=testsets/$prefix"_"$LN".dataset".$flavour; outfile=outfiles/$prefix"_"$LN"_"$flavour"_nltk.out";\
#time python3.10 nltk_segmenter.py $LN $LC $testset  $outfile && python3.8 segmenteval.py  $gold $outfile