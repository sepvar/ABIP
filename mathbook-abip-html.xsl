<?xml version='1.0'?> <!-- As XML file -->

<!-- For Joe Christensen's textbook -->

<!-- Identify as a stylesheet -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<!-- Import the usual LaTeX conversion templates            -->
<!-- Place this file in  mathbook/user  (mkdir if necessary)-->
<xsl:import href="../xsl/mathbook-html.xsl" />

<!-- Intend output for rendering by pdflatex -->
<!-- <xsl:output method="html" /> -->

<xsl:param name="chunk.level" select="'4'" />
<xsl:param name="author-tools" select="'yes'" />
<xsl:param name="toc.level" select="'1'" />
<xsl:param name="numbering.biblio.level" select="'1'" />
<xsl:param name="numbering.theorems.level" select="'2'" />
<xsl:param name="numbering.projects.level" select="'2'" />
<!-- Default level 3
<xsl:param name="numbering.equations.level" select="''" />
<xsl:param name="numbering.maximum.level" select="''" />
-->
<xsl:param name="html.css.file"   select="'mathbook-5.css'" />

</xsl:stylesheet>
