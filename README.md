# ABIP

These are the files for my algebra-based introductory physics book		

In this directory, I have a file ABIP.tex which is written in LaTeX.  This is the original version of the book.
There are a lot of latex .sty files included to try some fancy stuff.

I am also going to create an ABIP.xml for accessing the MathbookXML format.
I will need to translate ABIP.tex into xml 
That file will need a new name...  Maybe I will call that the "Connected Physics" that I took as the temporary title.

NOTES:
the mathbook-abip-html file resides in mathbook/user/ and holds the specific preferences for formatting style
	I have copied the mathbook-abip-* files to my directory in order to include them in git
	If change the file, then re-copy (not automatic)
	If git pull finds changes, then re-copy to mathbook/user (not automatic)
The location of the files are different on the Surface, the laptop, and the server.
AIY = ABIP
BEE = mathbook
CEE = lab manual

To compile the XML to HTML 
	(Use aiy to get to the correct directory)
	xsltproc $BEE/user/mathbook-abip-html.xsl ABIP.xml

To complie the XML to LaTeX
	xsltproc $BEE/user/mathbook-abip-latex.xsl ABIP.xml
	(Use WindEdt to pdflatex)

To render the images in SVG (useful for HTML)
	$BEE/script/mbx -v -c latex-image -f svg -d images $AIY/ABIP.xml
	$BEE/script/mbx -v -c latex-image -r [specific image reference] -f svg -d images $AIY/ABIP.xml

To remove the \student latex commands:
	sed -i.bak -f ABIP.sed ABIP.xml
	(compile it)
	mv ABIP.xml.bak ABIP.xml
	(git status, etc)

To list the images in the xml and print a line that will check to see if that image exists and (if not) try to create the image...
cat ABIP.xml | sed 's/^ *<image/<image/g' | grep '<image' | sed 's+^.*images/\(.*\)\.svg.*+ls images/\1.svg || $BEE/script/mbx \-v \-c latex-image \-r \1 \-f svg \-d images $AIY/ABIP.xml+g'

To VERIFY the code  (top 5)
	java -jar $BEE/../jing-trang/build/jing.jar $BEE/schema/pretext.rng ABIP.xml | wc -l
	java -jar $BEE/../jing-trang/build/jing.jar $BEE/schema/pretext.rng ABIP.xml | head -5
	java -jar $BEE/../jing-trang/build/jing.jar $BEE/schema/pretext.rng ABIP.xml | sort -k4 | head -15
To find the errors on "todo"  (must change in two places)                                                vvvv                                                 vvvv
	java -jar $BEE/../jing-trang/build/jing.jar $BEE/schema/pretext.rng ABIP.xml | grep ": element \"todo" | sed 's/.*:\([0-9][0-9]*\):\([0-9][0-9]*\):.*/todo line \1:\2/g'
                                                                                                         ^^^^                                                 ^^^^
java -jar $BEE/../jing-trang/build/jing.jar $BEE/schema/pretext.rng ABIP.xml | sed 's/.*:\([0-9][0-9]*\):\([0-9][0-9]*\): error: element "\([a-zA-Z][a-zA-Z]*\)".*/\3 line \1:\2/g' | sort -k1
