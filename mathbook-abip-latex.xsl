<?xml version='1.0'?> <!-- As XML file -->

<!-- For Thomas More College's Lab Manual -->

<!-- Identify as a stylesheet -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<!-- Import the usual LaTeX conversion templates            -->
<!-- Place this file in  mathbook/user  (mkdir if necessary)-->
<xsl:import href="../xsl/mathbook-latex.xsl" />

<xsl:param name="latex.preamble.late">
    <xsl:text>\setlength{\evensidemargin}{0in}&#xa;</xsl:text>
    <xsl:text>\setlength{\oddsidemargin}{-.15in}&#xa;</xsl:text>
    <xsl:text>\setlength{\textwidth}{6.6in}&#xa;</xsl:text>
    <xsl:text>\setlength{\marginparwidth}{.6in}&#xa;</xsl:text>
    <xsl:text>\setlength{\marginparsep}{.15in}&#xa;</xsl:text>
    
    <xsl:text>\setlength{\topmargin}{-0.75in}&#xa;</xsl:text>
    <xsl:text>\setlength{\headheight}{0.1in}&#xa;</xsl:text>
    <xsl:text>\setlength{\headsep}{0.25in}&#xa;</xsl:text>
    <xsl:text>\setlength{\textheight}{9.2in}&#xa;</xsl:text>
    <xsl:text>\setlength{\footskip}{0.5in}&#xa;</xsl:text>
</xsl:param>


<!--  -->
<!-- PDF Watermarking                    -->
<!-- Non-empty string makes it happen    -->
<!-- Scale works well for "CONFIDENTIAL" -->
<!-- or  for "DRAFT YYYY/MM/DD"          -->
<!-- <xsl:param name="latex.watermark" select="''"/>
    <xsl:param name="latex.watermark.scale" select="2.0"/>
    -->

<!--  -->
<!-- Print Option                                         -->
<!-- For a non-electronic copy, inactive links in black   -->
<!-- Any color options go to black and white, as possible -->
<!-- <xsl:param name="latex.print" select="'no'"/>
    -->


</xsl:stylesheet>
