## These are necessary when chapters are NOT included in parts
## This does not allow modularization
## # Fix the trouble with using parts; for some reason, PTX makes both "parts" and "chapters" into parts.
## ## adjust section to subsection AND subsection to subsubsection AND subsubsection to subsubsubsection
## s/section\*{/subsection\*{/g
## s/section\[/subsection\[/g
## ## adjust chapter to section
## s/chapter\*{/section\*{/g
## s/chapter\[/section\[/g
## ## Adjust Part to chapter
## s/part\[\(.*\)label{c/chapter\[\1label{c/g
# This is a hold-over from before I decided how to distinguish examples, etc.  
# I now use the THMBOX package to resolve this.
# s/\\end{insight}/\\hspace*{\\fill}\\rule[-5pt]{1pt}{10pt}\\hspace{-2.5in}\\rule[-5pt]{2.5in}{1pt}\n\\end{insight}/g
# s/\\end{remark}/\\hspace*{\\fill} \\rule[-5pt]{1pt}{10pt}\\hspace{-2.5in}\\rule[-5pt]{2.5in}{1pt}\n\\end{remark}/g
# s/\\end{convention}/\\hspace*{\\fill} \\rule[-5pt]{1pt}{10pt}\\hspace{-2.5in}\\rule[-5pt]{2.5in}{1pt}\n\\end{convention}/g
# s/\\end{example}/\\hspace*{\\fill} \\rule[-5pt]{1pt}{10pt}\\hspace{-\\textwidth}\\rule[-5pt]{\\textwidth}{1pt}\n\\end{example}/g
# s/\\end{investigation}/\\hspace*{\\fill} \\rule[-5pt]{1pt}{10pt}\\hspace{-\\textwidth}\\rule[-5pt]{\\textwidth}{1pt}\n\\end{investigation}/g
# s/\\end{exploration}/\\hspace*{\\fill} \\rule[-5pt]{1pt}{10pt}\\hspace{-\\textwidth}\\rule[-5pt]{\\textwidth}{1pt}\n\\end{exploration}/g
# s/\\begin{insight}/\\begin{leftbar}\n\\begin{insight}/g
# s/\\begin{proposition}/\\begin{leftbar}\n\\begin{proposition}/g
# s/\\begin{remark}/\\begin{leftbar}\n\\begin{remark}/g
# s/\\begin{convention}/\\begin{leftbar}\n\\begin{convention}/g
# s/\\end{insight}/\\end{insight}\n\\end{leftbar}/g
# s/\\end{proposition}/\\end{proposition}\n\\end{leftbar}/g
# s/\\end{remark}/\\end{remark}\n\\end{leftbar}/g
# s/\\end{convention}/\\end{convention}\n\\end{leftbar}/g
#
# This is here to keep THMBOX from thinking there are empty titles on these environments
s/\\begin{insight}\[\]/\\begin{insight}/g
s/\\begin{convention}\[\]/\\begin{convention}/g
s/\\begin{remark}\[\]/\\begin{remark}/g
#
# This comments out the piece that makes chapter numbers reset in each part
# This will be resolved when parts are set to Decorative, rather than Structural
s/\\\@addtoreset{chapter}{part}/%\\\@addtoreset{chapter}{part}/g
