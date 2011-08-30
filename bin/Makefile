sample : rd_sample mm_sample csv_sample rd_composition_sample

dir = ../resources

rd_sample :
	cat $(dir)/sample.rd | rd --to=dot | dot -Tjpg -o rd.jpg 

rd_composition_sample :
	cat $(dir)/sample.rd $(dir)/sample2.rd | rd --to=dot | dot -Tjpg -o rd_composition.jpg 

mm_sample :
	cat $(dir)/sample.mm | rd --from=mm | rd --to=dot | dot -Tjpg -o mm.jpg
	# cat $(dir)/sample.mm | requidef --from=mm --to=rd 

csv_sample :
	cat $(dir)/sample.html | rd --from=html | rd --to=csv > html.csv

clean_sample :
	rm rd.jpg mm.jpg html.csv rd_composition.jpg
	
