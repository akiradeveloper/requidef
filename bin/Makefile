sample : dot_sample csv_sample

dot_sample :
	requidef --type=dot --file=sample.rd > sample.dot
	dot -Tjpg sample.dot -o sample.jpg

csv_sample :
	requidef -t csv -f sample.rd > sample.csv

clean_sample :
	rm sample.dot sample.csv sample.jpg
	
