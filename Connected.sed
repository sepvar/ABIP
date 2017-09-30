s/section\*{/subsection\*{/g
s/section\[/subsection\[/g
s/chapter\*{/section\*{/g
s/chapter\[/section\[/g
s/part\[\(.*\)label{c/chapter\[\1label{c/g
s/\\end{insight}/\\hspace*{\\fill}\\rule[-5pt]{1pt}{10pt}\\hspace{-2.5in}\\rule[-5pt]{2.5in}{1pt}\n\\end{insight}/g
s/\\end{remark}/\\hspace*{\\fill} \\rule[-5pt]{1pt}{10pt}\\hspace{-2.5in}\\rule[-5pt]{2.5in}{1pt}\n\\end{remark}/g
s/\\end{convention}/\\hspace*{\\fill} \\rule[-5pt]{1pt}{10pt}\\hspace{-2.5in}\\rule[-5pt]{2.5in}{1pt}\n\\end{convention}/g
s/\\end{example}/\\hspace*{\\fill} \\rule[-5pt]{1pt}{10pt}\\hspace{-\\textwidth}\\rule[-5pt]{\\textwidth}{1pt}\n\\end{example}/g
s/\\end{investigation}/\\hspace*{\\fill} \\rule[-5pt]{1pt}{10pt}\\hspace{-\\textwidth}\\rule[-5pt]{\\textwidth}{1pt}\n\\end{investigation}/g
s/\\end{exploration}/\\hspace*{\\fill} \\rule[-5pt]{1pt}{10pt}\\hspace{-\\textwidth}\\rule[-5pt]{\\textwidth}{1pt}\n\\end{exploration}/g
