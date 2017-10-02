# ABIP

default: 
	@echo "make -n ... to display commands with running"
	@echo "make -s ... to not display commands when running them"
	@echo "Choices: html, latex, images, list (prints copy-paste select image creation), counterr, toperr, typeerr, allerr"
	@echo "make all will make html, latex, and images"

${BEE}/user/mathbook-abip-latex.xsl: mathbook-abip-latex.xsl
	cp mathbook-abip-latex.xsl ${BEE}/user/

${BEE}/user/mathbook-abip-html.xsl: mathbook-abip-html.xsl
	cp mathbook-abip-html.xsl ${BEE}/user/

ABIP.xml.peep: ABIP.sed ABIP.xml
	sed -i.peep -f ABIP.sed ABIP.xml

html: ABIP.xml.peep ${BEE}/user/mathbook-abip-html.xsl ABIP.xml
	xsltproc -stringparam html.css.file mathbook-5.css ${BEE}/user/mathbook-abip-html.xsl ABIP.xml && cp ABIP.xml.peep ABIP.xml || cp ABIP.xml.peep ABIP.xml 

latex: ${BEE}/user/mathbook-abip-latex.xsl ABIP.xml
	xsltproc ${BEE}/user/mathbook-abip-latex.xsl ABIP.xml 
	sed -i.chap -f Connected.sed Connected.tex
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

checkref: ABIP.xml
	grep "</xref>" ABIP.xml | sed 's@.*\(\<xref .*\/xref\>\).*@\1@g' | grep -v "text=" | sort -k2
	grep "</xref>" ABIP.xml | sed 's@\(.*\)\(\<xref .*\/xref\>\)\(.*\)@\1@g' | grep "</xref>" | sed 's@\(.*\)\(\<xref .*\/xref\>\)\(.*\)@\2@g' | grep -v "text=" | sort -k2
	grep "</xref>" ABIP.xml | sed 's@\(.*\)\(\<xref .*\/xref\>\)\(.*\)@\1@g' | grep "</xref>" ABIP.xml | sed 's@\(.*\)\(\<xref .*\/xref\>\)\(.*\)@\1@g' | grep "</xref>" | sed 's@\(.*\)\(\<xref .*\/xref\>\)\(.*\)@\2@g' | grep -v "text=" | sort -k2
	grep "</xref>" ABIP.xml | sed 's@\(.*\)\(\<xref .*\/xref\>\)\(.*\)@\3@g' | grep "</xref>" | sed 's@\(.*\)\(\<xref .*\/xref\>\)\(.*\)@\2@g' | grep -v "text=" | sort -k2
	grep "</xref>" ABIP.xml | sed 's@\(.*\)\(\<xref .*\/xref\>\)\(.*\)@\3@g' | grep "</xref>" ABIP.xml | sed 's@\(.*\)\(\<xref .*\/xref\>\)\(.*\)@\1@g' | grep "</xref>" | sed 's@\(.*\)\(\<xref .*\/xref\>\)\(.*\)@\2@g' | grep -v "text=" | sort -k2


counterr: ${BEE}/../jing-trang/build/jing.jar ${BEE}/schema/pretext.rng ABIP.xml 
	@echo `java -jar ${BEE}/../jing-trang/build/jing.jar ${BEE}/schema/pretext.rng ABIP.xml | wc -l`" errors"
	@echo "part: "`java -jar ${BEE}/../jing-trang/build/jing.jar ${BEE}/schema/pretext.rng ABIP.xml | grep ": element \"part" | wc -l`
	@echo ">6000: "`java -jar ${BEE}/../jing-trang/build/jing.jar ${BEE}/schema/pretext.rng ABIP.xml | grep ":6[0-9][0-9][0-9]:" | wc -l`
	@echo "font: "`java -jar ${BEE}/../jing-trang/build/jing.jar ${BEE}/schema/pretext.rng ABIP.xml | grep ": element \"font" | wc -l`

toperr: ${BEE}/../jing-trang/build/jing.jar ${BEE}/schema/pretext.rng ABIP.xml 
	java -jar ${BEE}/../jing-trang/build/jing.jar ${BEE}/schema/pretext.rng ABIP.xml | head -5

typeerr: counterr ${BEE}/../jing-trang/build/jing.jar ${BEE}/schema/pretext.rng ABIP.xml 
	java -jar ${BEE}/../jing-trang/build/jing.jar ${BEE}/schema/pretext.rng ABIP.xml | \
		grep -v ": element \"part" | \
		grep -v ":6[0-9][0-9][0-9]:" | \
		grep -v ": element \"font" | \
		sed 's/.*:\([0-9][0-9]*\):\([0-9][0-9]*\): error: element "\([a-zA-Z][a-zA-Z]*\)".*/\3 line \1:\2/g' | \
		sort -k1

# To find the errors on "todo"  (must change in two places)                                                vvvv                                                 vvvv
# 	java -jar ${BEE}/../jing-trang/build/jing.jar ${BEE}/schema/pretext.rng ABIP.xml | grep ": element \"todo" | sed 's/.*:\([0-9][0-9]*\):\([0-9][0-9]*\):.*/todo line \1:\2/g'
#                                                                                                          ^^^^                                                 ^^^^

allerr: checkref counterr ${BEE}/../jing-trang/build/jing.jar ${BEE}/schema/pretext.rng ABIP.xml 
	java -jar ${BEE}/../jing-trang/build/jing.jar ${BEE}/schema/pretext.rng ABIP.xml | \
		grep -v ": element \"part" | \
		grep -v ":6[0-9][0-9][0-9]:" | \
		grep -v ": element \"font" | \
		sort -k4  

all: html latex images