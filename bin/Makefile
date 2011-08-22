sample : dot_sample csv_sample

dot_sample :
	cat sample.mm | requidef --from=mm --to=rd | requidef --to=dot > sample.dot
	dot -Tjpg sample.dot -o sample.jpg

csv_sample :
	cat sample.html | requidef --from=html --to=rd | requidef --to=csv > sample.csv

clean_sample :
	rm sample.dot sample.csv sample.jpg
	
