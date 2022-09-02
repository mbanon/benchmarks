mkdir -p outfiles/
RESULTS_PATH=benchmarks_results/
for LC in bg cnr cs da de el en es et fi fr hr hu is it lt lv mk mt nb nl nn pl pt ro sk sl sq sr sv tk uk
do
	for TOOL in loomchild moses ulysses nltk ersatz pymoses pyloomchild rustsrx
	do
		mkdir -p $RESULTS_PATH/$TOOL
		echo "Running $TOOL for $LC"
		./runbatcheval.sh $LC $TOOL &> $RESULTS_PATH/$TOOL/$LC.$TOOL
        done
done

