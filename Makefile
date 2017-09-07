# ABIP

ABIP.xml.peep: ABIP.sed ABIP.xml
	sed -i.peep -f ABIP.sed ABIP.xml

html: ABIP.xml.peep ${BEE}/user/mathbook-abip-html.xsl ABIP.xml
	xsltproc ${BEE}/user/mathbook-abip-html.xsl ABIP.xml && mv ABIP.xml.peep ABIP.xml || mv ABIP.xml.peep ABIP.xml 

latex: ABIP.xml.peep ${BEE}/user/mathbook-abip-latex.xsl ABIP.xml
	xsltproc ${BEE}/user/mathbook-abip-latex.xsl ABIP.xml && mv ABIP.xml.peep ABIP.xml || mv ABIP.xml.peep ABIP.xml
	echo "Use WindEdt to pdflatex"

images: ABIP.xml
	${BEE}/script/mbx -v -c latex-image -f svg -d images ${AIY}/ABIP.xml
#	${BEE}/script/mbx -v -c latex-image -r [specific image reference] -f svg -d images ${AIY}/ABIP.xml


# To list the images in the xml and print a line that will check to see if that image exists and (if not) try to create the image...

list: ABIP.xml
	cat ABIP.xml | \
		sed 's/^ *<image/<image/g' | \
		grep '<image' | grep -v "images" | \
		sed 's/ width=.*>/>/g' | \
		sed 's+^.*xml:id=\"\(.*\)\">+ls images/\1.svg || C:/Users/tensen/Desktop/Book/mathbook/script/mbx \-v \-c latex-image \-r \1 \-f svg \-d images ${AIY}/ABIP.xml+g'

counterr: ${BEE}/../jing-trang/build/jing.jar ${BEE}/schema/pretext.rng ABIP.xml 
	@echo `java -jar ${BEE}/../jing-trang/build/jing.jar ${BEE}/schema/pretext.rng ABIP.xml | wc -l`" errors"
	@echo "part: "`java -jar ${BEE}/../jing-trang/build/jing.jar ${BEE}/schema/pretext.rng ABIP.xml | grep ": element \"part" | wc -l`
	@echo "conclusion: "`java -jar ${BEE}/../jing-trang/build/jing.jar ${BEE}/schema/pretext.rng ABIP.xml | grep ": element \"conclusion" | wc -l`
	@echo "paragraphs: "`java -jar ${BEE}/../jing-trang/build/jing.jar ${BEE}/schema/pretext.rng ABIP.xml | grep ": element \"paragraphs" | wc -l`

toperr: ${BEE}/../jing-trang/build/jing.jar ${BEE}/schema/pretext.rng ABIP.xml 
	java -jar ${BEE}/../jing-trang/build/jing.jar ${BEE}/schema/pretext.rng ABIP.xml | head -5

typeerr: ${BEE}/../jing-trang/build/jing.jar ${BEE}/schema/pretext.rng ABIP.xml 
	java -jar ${BEE}/../jing-trang/build/jing.jar ${BEE}/schema/pretext.rng ABIP.xml | \
		grep -v ": element \"part" | \
		grep -v ": element \"conclusion" | \
		grep -v ": element \"paragraphs" | \
		sed 's/.*:\([0-9][0-9]*\):\([0-9][0-9]*\): error: element "\([a-zA-Z][a-zA-Z]*\)".*/\3 line \1:\2/g' | \
		sort -k1

# To find the errors on "todo"  (must change in two places)                                                vvvv                                                 vvvv
# 	java -jar ${BEE}/../jing-trang/build/jing.jar ${BEE}/schema/pretext.rng ABIP.xml | grep ": element \"todo" | sed 's/.*:\([0-9][0-9]*\):\([0-9][0-9]*\):.*/todo line \1:\2/g'
#                                                                                                          ^^^^                                                 ^^^^

allerr: ${BEE}/../jing-trang/build/jing.jar ${BEE}/schema/pretext.rng ABIP.xml 
	java -jar ${BEE}/../jing-trang/build/jing.jar ${BEE}/schema/pretext.rng ABIP.xml | \
		grep -v ": element \"part" | \
		grep -v ": element \"conclusion" | \
		grep -v ": element \"paragraphs" | \
		sort -k4  

default: 
	@echo "make -n ... to display commands with running"
	@echo "make -s ... to not display commands when running them"
	@echo "Choices: html, latex, images, list (prints copy-paste select image creation), counterr, toperr, typeerr, allerr"
	@echo "make all will make html, latex, and images"

all: html latex images
