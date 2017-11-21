# ABIP

default: 
	@echo "make -n ... to display commands with running"
	@echo "make -s ... to not display commands when running them"
	@echo "Choices: html, latex, images, list (prints copy-paste select image creation), counterr, toperr, typeerr, allerr"
	@echo "make all will make html, latex, and images"

git: 
	git diff-index --stat master

${BEE}/user/mathbook-abip-latex.xsl: mathbook-abip-latex.xsl
	cp mathbook-abip-latex.xsl ${BEE}/user/

${BEE}/user/mathbook-abip-html.xsl: mathbook-abip-html.xsl
	cp mathbook-abip-html.xsl ${BEE}/user/

Connected.html: ABIP.sed ${BEE}/user/mathbook-abip-html.xsl ABIP.xml
	sed -i.peep -f ABIP.sed ABIP.xml
	xsltproc ${BEE}/user/mathbook-abip-html.xsl ABIP.xml && mv ABIP.xml.peep ABIP.xml || mv ABIP.xml.peep ABIP.xml 
	@echo ""

html: Connected.html

Connected.tex: ${BEE}/user/mathbook-abip-latex.xsl ABIP.xml Connected.sed
	xsltproc ${BEE}/user/mathbook-abip-latex.xsl ABIP.xml 
	sed -i.chap -f Connected.sed Connected.tex

Connected.ind: Connected.idx Connected.tex
	makeindex Connected.idx

Connected.pdf: Connected.ind Connected.tex
	pdflatex Connected.tex && pdflatex Connected.tex  || pdflatex Connected.tex 

latex: Connected.tex

index: Connected.idx

pdf: Connected.pdf

images: ABIP.xml
	${BEE}/script/mbx -v -c latex-image -f svg -d images ${AIY}/ABIP.xml
#	${BEE}/script/mbx -v -c latex-image -r [specific image reference] -f svg -d images ${AIY}/ABIP.xml


# To list the images in the xml and print a line that will check to see if that image exists and (if not) try to create the image...

list: ABIP.xml
	rm -f runlist
	cp .script runlist
	cat ABIP.xml | \
		sed 's/^ *<image/<image/g' | \
		grep '<image' | grep -v "images" | \
		sed 's/ width=.*>/>/g' | \
		sed 's+^.*xml:id=\"\(.*\)\">+ls images/\1.svg || ${BEE}/script/mbx \-v \-c latex-image \-r \1 \-f svg \-d images ${AIY}/ABIP.xml || ${BEE}/script/mbx \-v \-c latex-image \-r \1 \-f source \-d images ${AIY}/ABIP.xml+g' >> runlist
	@echo "run the script   ./runlist   to create any images that do not currently exist."

checkref: ABIP.xml
	@echo "The following checks for common mistakes I have made in the past (bad xrefs)"
	@grep "</xref>" ABIP.xml | sed 's@.*\(\<xref .*\/xref\>\).*@\1@g' | grep -v "text=" | sort -k2
	@grep "</xref>" ABIP.xml | sed 's@\(.*\)\(\<xref .*\/xref\>\)\(.*\)@\1@g' | grep "</xref>" | sed 's@\(.*\)\(\<xref .*\/xref\>\)\(.*\)@\2@g' | grep -v "text=" | sort -k2
	@grep "</xref>" ABIP.xml | sed 's@\(.*\)\(\<xref .*\/xref\>\)\(.*\)@\1@g' | grep "</xref>" ABIP.xml | sed 's@\(.*\)\(\<xref .*\/xref\>\)\(.*\)@\1@g' | grep "</xref>" | sed 's@\(.*\)\(\<xref .*\/xref\>\)\(.*\)@\2@g' | grep -v "text=" | sort -k2
	@grep "</xref>" ABIP.xml | sed 's@\(.*\)\(\<xref .*\/xref\>\)\(.*\)@\3@g' | grep "</xref>" | sed 's@\(.*\)\(\<xref .*\/xref\>\)\(.*\)@\2@g' | grep -v "text=" | sort -k2
	@grep "</xref>" ABIP.xml | sed 's@\(.*\)\(\<xref .*\/xref\>\)\(.*\)@\3@g' | grep "</xref>" ABIP.xml | sed 's@\(.*\)\(\<xref .*\/xref\>\)\(.*\)@\1@g' | grep "</xref>" | sed 's@\(.*\)\(\<xref .*\/xref\>\)\(.*\)@\2@g' | grep -v "text=" | sort -k2


counterr: ${BEE}/../jing-trang/build/jing.jar ${BEE}/schema/pretext.rng ABIP.xml 
	@echo "Counting lines from checking for specific types of errors"
	@echo `java -jar ${BEE}/../jing-trang/build/jing.jar ${BEE}/schema/pretext.rng ABIP.xml | wc -l`" errors (41 known errors)"
	@echo -e "part: \t\t"`java -jar ${BEE}/../jing-trang/build/jing.jar ${BEE}/schema/pretext.rng ABIP.xml | grep ": element \"part" | wc -l`" \t(24 known, hidden)"
	@echo -e "font: \t\t"`java -jar ${BEE}/../jing-trang/build/jing.jar ${BEE}/schema/pretext.rng ABIP.xml | grep ": element \"font" | wc -l`" \t(4 known, hidden)"
	@echo -e "paragraph: \t"`java -jar ${BEE}/../jing-trang/build/jing.jar ${BEE}/schema/pretext.rng ABIP.xml | grep ": element \"paragraph" | wc -l`" \t(1 known, hidden)"
	@echo -e "tabular: \t"`java -jar ${BEE}/../jing-trang/build/jing.jar ${BEE}/schema/pretext.rng ABIP.xml | grep ": element \"tabular" | wc -l`" \t(1 known, hidden)"
	@set TEMPVAR=`grep -n "Known tag abuse 2" ABIP.xml | sed s/:.*//g`
	@echo -e "license: \t"`java -jar ${BEE}/../jing-trang/build/jing.jar ${BEE}/schema/pretext.rng ABIP.xml | grep ${TEMPVAR} | wc -l`" \t(11 known, hidden)"
	@echo -e "license: \t"`java -jar ${BEE}/../jing-trang/build/jing.jar ${BEE}/schema/pretext.rng ABIP.xml | grep 375 | wc -l`" \t(11 known, hidden)"

toperr: ${BEE}/../jing-trang/build/jing.jar ${BEE}/schema/pretext.rng ABIP.xml 
	java -jar ${BEE}/../jing-trang/build/jing.jar ${BEE}/schema/pretext.rng ABIP.xml | head -5

typeerr: counterr ${BEE}/../jing-trang/build/jing.jar ${BEE}/schema/pretext.rng ABIP.xml 
	java -jar ${BEE}/../jing-trang/build/jing.jar ${BEE}/schema/pretext.rng ABIP.xml | \
		grep -v ": element \"part" | \
		grep -v ": element \"font" | \
		grep -v `grep -n "xml:id=\"p-intuition-motion" ABIP.xml | sed s/:.*//g` | \
		grep -v `grep -n "Known tag abuse 1" ABIP.xml | sed s/:.*//g` | \
		grep -v `grep -n "Known tag abuse 2" ABIP.xml | sed s/:.*//g` | \
		sed 's/.*:\([0-9][0-9]*\):\([0-9][0-9]*\): error: element "\([a-zA-Z][a-zA-Z]*\)".*/\3 line \1:\2/g' | \
		sort -k1

# To find the errors on "todo"  (must change in two places)                                                vvvv                                                 vvvv
# 	java -jar ${BEE}/../jing-trang/build/jing.jar ${BEE}/schema/pretext.rng ABIP.xml | grep ": element \"todo" | sed 's/.*:\([0-9][0-9]*\):\([0-9][0-9]*\):.*/todo line \1:\2/g'
#                                                                                                          ^^^^                                                 ^^^^

allerr: checkref counterr ${BEE}/../jing-trang/build/jing.jar ${BEE}/schema/pretext.rng ABIP.xml 
	java -jar ${BEE}/../jing-trang/build/jing.jar ${BEE}/schema/pretext.rng ABIP.xml | \
		grep -v ": element \"part" | \
		grep -v ": element \"font" | \
		grep -v `grep -n "xml:id=\"p-intuition-motion" ABIP.xml | sed s/:.*//g` | \
		grep -v `grep -n "Known tag abuse 1" ABIP.xml | sed s/:.*//g` | \
		grep -v `grep -n "Known tag abuse 2" ABIP.xml | sed s/:.*//g` | \
		sort -k4  

all: html latex images
