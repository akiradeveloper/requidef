# ChangeLog 
ChangeLogs for Milestones.

## Version 0.1.0 (Aug. 21, 2011)
The consequence of 10H rapid developement.   
It had many bugs so we could not use the command after 'gem install'ing. 

## Version 0.2.0 (Aug. 22, 2011)
We found that the .rd file is not as easy to edit as we had expected.  
So we decided to edit file in XMind, a free MindMap tool, export it to HTML to translate to .rd file.  
Other features,  

* The commandline I/F is changed.
* Fixed the flashed bugs in 0.1.0.
* Provides some converter functionality.
* It is now ready to get started by just gem installing.

## Version 0.3.0 (Forecast)
* Add more format to translate (TGF, GML, ..).
* Parser Enhancement (Hopefully all but few would be eliminated).
1. Comment Out,  
2. Line Breaking,  
3. Empty Line,  
4. [[tagname]] -> [[tagname:tagname]] for DRY.  
* Not all the (>>dest) does not have the real destination. Even in that case, works fine.  
Imagine if all the link must have definitly the real desitination. What could be happened?
* Code Clean
Testing will be automated so that the future development will be saved.
