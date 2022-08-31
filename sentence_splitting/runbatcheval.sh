LC=$1
TOOL=$2


PREFIX=UD
case $LC in
	bg)
		LN=Bulgarian
		;;
	cnr)
		LN=Montenegrin
		PREFIX=MESUBS
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
		PREFIX=SETIMES
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
		LN)Ukrainian
		;;	
					
esac
	

for FLAVOUR in none all mixed
do
	echo $LN
	echo $FLAVOUR
	echo $PREFIX
done


#gold=testsets/$prefix"_"$LN.dataset.gold; testset=testsets/$prefix"_"$LN".dataset".$flavour; outfile=outfiles/$prefix"_"$LN"_"$flavour"_nltk.out";time python3.10 nltk_segmenter.py $LN $LC $testset  $outfile && python3.10 segmenteval.py  $gold $outfile
#LC=is; LN=Icelandic; prefix=UD; flavour=all; gold=testsets/$prefix"_"$LN.dataset.gold; testset=testsets/$prefix"_"$LN".dataset".$flavour; outfile=outfiles/$prefix"_"$LN"_"$flavour"_nltk.out";\
#time python3.10 nltk_segmenter.py $LN $LC $testset  $outfile && python3.8 segmenteval.py  $gold $outfile