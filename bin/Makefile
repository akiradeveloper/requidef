sample : dot_sample csv_sample

dot_sample :
	ruby requidef -t dot -f sample.rd > sample.dot
	dot -Tjpg sample.dot -o sample.jpg

csv_sample :
	ruby requidef -t csv -f sample.rd > sample.csv

clean_sample :
	rm sample.dot sample.csv sample.jpg
	
