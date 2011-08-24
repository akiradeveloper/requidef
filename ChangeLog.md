# ChangeLog 
ChangeLogs for Milestones.

## Version 0.1.0 (Aug. 21, 2011)
The consequence of 10H rapid developement.   
It had many bugs so we could not use the command after 'gem install'ing. 

## Version 0.2.0 (Aug. 22, 2011)
I have found that the .rd file is not as easy to edit I had expected.  
So I decided to edit file in XMind, a free MindMap tool, export it to HTML to translate to .rd file.  
Other features,  

* The commandline I/F is changed.
* Fixed the flashed bugs in 0.1.0.
* Provides some converter functionality.
* It is now ready to get started by just gem installing.
* etc.

## Version 0.3.0 (Aug. 24, 2011)
In development of this version, I have found that
this software does not meet my requirements.
So I have decided to release it as version 0.3.0
and redesign the software toward version 0.4.0.

Deeply sorry for users. 
I do not recommend
to use version before 0.4.0 because it is obsolete.

* Parser Enhancement (Hopefully all but few would be eliminated).  
Comment Out,  
Empty Line,  
[[tagname]] -> [[tagname:tagname]] for DRY.  
* Add --parse-lenient option.
* etc.

## Version 0.4.0 (Forecast)
Will almost completely discard backward-compatibility.

* Add more format to translate (TGF, GML, ..).  
RD and TGF will be compatible.
* CLI Interface changes.  
* RD format changes.  
For convenience, I have decided to change the RD format and hence discard backward-compatibility. 
* Parser for .mm format will be extended.  
Version before 0.4.0 only supports .mm of simple tree.  
Version 0.4.0 supports links freely come across the tree.
