sample : rd_sample mm_sample csv_sample rd_composition_sample

rd_sample :
	cat sample.rd | requidef --parse-lenient --from=rd --to=dot | dot -Tjpg -o rd.jpg 

rd_composition_sample :
	cat sample.rd sample2.rd | requidef --parse-lenient --from=rd --to=dot | dot -Tjpg -o rd_composition.jpg 

mm_sample :
	cat sample.mm | requidef --from=mm --to=rd | requidef --from=rd --to=dot | dot -Tjpg -o mm.jpg

csv_sample :
	cat sample.html | requidef --from=html --to=rd | requidef --from=rd --to=csv > html.csv

clean_sample :
	rm rd.jpg mm.jpg html.csv rd_composition.jpg
	
