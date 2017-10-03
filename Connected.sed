s/section\*{/subsection\*{/g
s/section\[/subsection\[/g
s/chapter\*{/section\*{/g
s/chapter\[/section\[/g
s/part\[\(.*\)label{c/chapter\[\1label{c/g
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
s/\\begin{insight}\[\]/\\begin{insight}/g
s/\\begin{convention}\[\]/\\begin{convention}/g
s/\\begin{remark}\[\]/\\begin{remark}/g
#
s/\\\@addtoreset{chapter}{part}/%\\\@addtoreset{chapter}{part}/g
