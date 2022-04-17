<?xml version='1.0'?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xqxft="http://www.w3.org/2007/xpath-full-text"
                xmlns:xqx="http://www.w3.org/2005/XQueryX">

<!-- Initial creation                            2006-08-17: Jim Melton   -->
<!-- Added ftOptionDecl, ftScoreVariableBinding  2006-08-21: Jim Melton   -->
<!-- First version believed complete             2006-08-29: Jim Melton   -->
<!-- Revised to align with 2008-01-24 draft      2008-02-08: Jim Melton   -->
<!-- Revised position of "weight" in grammar     2008-11-12: Jim Melton   -->
<!-- Various bug fixes                           2009-07-14: Michael Dyck -->
<!-- ftcontains => "contains text", Bug 7247     2009-09-17: Jim Melton   -->
<!-- with => using, stop words default, Bug 7271 2009-09-17: Jim Melton   -->
<!-- {} around weight values, around empty
     selection after pragmas                     2010-09-07: Jim Melton   -->

<xsl:import href="http://www.w3.org/2005/XQueryX/xqueryx.xsl"/>


<!-- ftOptionDecl -->
<xsl:template match="xqxft:ftOptionDecl">
  <xsl:text>declare ft-option </xsl:text>
  <xsl:apply-templates/>
</xsl:template>


<!-- ftScoreVariableBinding -->
<xsl:template match="xqxft:ftScoreVariableBinding">
  <xsl:text> score </xsl:text>
  <xsl:value-of select="$DOLLAR"/>
  <xsl:if test="@xqx:prefix">
    <xsl:value-of select="@xqx:prefix"/>
    <xsl:value-of select="$COLON"/>
  </xsl:if>
  <xsl:value-of select="."/>
</xsl:template>


<!-- ftcontains -->
<xsl:template match="xqxft:ftContainsExpr">
  <xsl:apply-templates select="xqxft:ftRangeExpr"/>
  <xsl:text> contains text </xsl:text>
  <xsl:apply-templates select="xqxft:ftSelectionExpr"/>
  <xsl:apply-templates select="xqxft:ftIgnoreOption"/>
</xsl:template>


<xsl:template match="xqxft:value">
  <xsl:apply-templates/>
</xsl:template>


<xsl:template match="xqxft:ftRangeExpr">
  <xsl:apply-templates/>
</xsl:template>


<xsl:template match="xqxft:ftSelectionExpr">
  <xsl:apply-templates/>
</xsl:template>


<xsl:template match="xqxft:ftIgnoreOption">
  <xsl:text>without content </xsl:text>
  <xsl:apply-templates/>
</xsl:template>


<xsl:template match="xqxft:ftSelection">
  <xsl:apply-templates select="xqxft:ftSelectionSource"/>
  <xsl:value-of select="$NEWLINE"/>
  <xsl:text>    </xsl:text>
  <xsl:apply-templates select="xqxft:ftPosFilter"/>
</xsl:template>


<xsl:template match="xqxft:ftSelectionSource">
  <xsl:apply-templates/>
  <xsl:text> </xsl:text>
</xsl:template>


<xsl:template match="xqxft:ftPosFilter">
  <xsl:apply-templates/>
  <xsl:value-of select="$NEWLINE"/>
  <xsl:text>      </xsl:text>
</xsl:template>


<!-- FTProximity alternative: ordered -->
<xsl:template match="xqxft:ftOrdered">
  <xsl:text>ordered </xsl:text>
  <xsl:value-of select="$NEWLINE"/>
</xsl:template>

<!-- FTProximity alternative: window -->
<xsl:template match="xqxft:ftWindow">
  <xsl:text>window </xsl:text>
  <xsl:apply-templates select="xqxft:value"/>
  <xsl:text> </xsl:text>
  <xsl:value-of select="xqxft:unit"/>
  <xsl:text>s</xsl:text>
  <xsl:value-of select="$NEWLINE"/>
</xsl:template>

<!-- FTProximity alternative: distance -->
<xsl:template match="xqxft:ftDistance">
  <xsl:text>distance </xsl:text>
  <xsl:apply-templates select="xqxft:ftRange"/>
  <xsl:text> </xsl:text>
  <xsl:value-of select="xqxft:unit"/>
  <xsl:text>s</xsl:text>
  <xsl:value-of select="$NEWLINE"/>
</xsl:template>

<!-- FTProximity alternative: scope -->
<xsl:template match="xqxft:ftScope">
  <xsl:value-of select="xqxft:type"/>
  <xsl:text> </xsl:text>
  <xsl:value-of select="xqxft:unit"/>
  <xsl:value-of select="$NEWLINE"/>
</xsl:template>

<!-- FTProximity alternative: content -->
<xsl:template match="xqxft:ftContent">
  <xsl:value-of select="xqxft:location"/>
  <xsl:value-of select="$NEWLINE"/>
</xsl:template>

<xsl:template match="xqxft:exactlyRange">
  <xsl:text>exactly </xsl:text>
  <xsl:apply-templates select="xqxft:value"/>
</xsl:template>

<xsl:template match="xqxft:atLeastRange">
  <xsl:text>at least </xsl:text>
  <xsl:apply-templates select="xqxft:value"/>
</xsl:template>

<xsl:template match="xqxft:atMostRange">
  <xsl:text>at most </xsl:text>
  <xsl:apply-templates select="xqxft:value"/>
</xsl:template>

<xsl:template match="xqxft:fromToRange">
  <xsl:text>from </xsl:text>
  <xsl:apply-templates select="xqxft:lower"/>
  <xsl:text> to </xsl:text>
  <xsl:apply-templates select="xqxft:upper"/>
  <xsl:text> </xsl:text>
</xsl:template>

<xsl:template match="xqxft:lower">
  <xsl:apply-templates/>
</xsl:template>

<xsl:template match="xqxft:upper">
  <xsl:apply-templates/>
</xsl:template>


<!-- ftMatchOption alternative: case -->
<xsl:template match="xqxft:case">
  <xsl:text> using </xsl:text>
  <xsl:value-of select="xqxft:value"/>
  <xsl:value-of select="$NEWLINE"/>
</xsl:template>


<!-- ftMatchOption alternative: diacritics -->
<xsl:template match="xqxft:diacritics">
  <xsl:text> using </xsl:text>
  <xsl:value-of select="xqxft:value"/>
  <xsl:value-of select="$NEWLINE"/>
</xsl:template>


<!-- ftMatchOption alternative: stemming -->
<xsl:template match="xqxft:stem">
  <xsl:text> using </xsl:text>
  <xsl:value-of select="xqxft:value"/>
  <xsl:value-of select="$NEWLINE"/>
</xsl:template>


<!-- ftMatchOption alternative: thesaurus -->
<xsl:template match="xqxft:thesaurus">
  <xsl:text> using </xsl:text>
  <xsl:choose>
    <xsl:when test="xqxft:noThesauri">
      <xsl:text>no thesaurus </xsl:text>
    </xsl:when>
    <xsl:otherwise>
      <xsl:apply-templates/>
    </xsl:otherwise>
  </xsl:choose>
  <xsl:value-of select="$NEWLINE"/>
</xsl:template>

<xsl:template match="xqxft:thesauri">
  <xsl:text> </xsl:text>
  <xsl:text>thesaurus </xsl:text>
  <xsl:choose>
    <xsl:when test="child::*[2]">
      <xsl:call-template name="parenthesizedList"/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:apply-templates/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template match="xqxft:default">
  <xsl:text>default </xsl:text>
</xsl:template>

<xsl:template match="xqxft:thesaurusID">
  <xsl:apply-templates/>
</xsl:template>

<xsl:template match="xqxft:at">
  <xsl:text>at "</xsl:text>
  <xsl:value-of select="."/>
  <xsl:text>" </xsl:text>
</xsl:template>

<xsl:template match="xqxft:relationship">
  <xsl:text>relationship "</xsl:text>
  <xsl:value-of select="."/>
  <xsl:text>" </xsl:text>
</xsl:template>

<xsl:template match="xqxft:levels">
  <xsl:apply-templates/>
  <xsl:text> levels </xsl:text>
</xsl:template>


<!-- ftMatchOption alternative: stopword -->
<xsl:template match="xqxft:stopword">
  <xsl:text>using </xsl:text>
  <xsl:choose>
    <xsl:when test="xqxft:noStopwords">
      <xsl:text>no stop words </xsl:text>
    </xsl:when>
    <xsl:otherwise>
      <xsl:apply-templates/>
    </xsl:otherwise>
  </xsl:choose> 
  <xsl:value-of select="$NEWLINE"/>
</xsl:template>

<xsl:template match="xqxft:stopwords">
  <xsl:text> </xsl:text>
  <xsl:choose>
    <xsl:when test="xqxft:default">
      <xsl:text>stop words default </xsl:text>
    </xsl:when>
    <xsl:otherwise>
      <xsl:text>stop words </xsl:text>
      <xsl:apply-templates select="xqxft:ftStopWords"/>
    </xsl:otherwise>
  </xsl:choose>
  <xsl:apply-templates select="xqxft:ftStopWordsInclExcl"/>
</xsl:template>

<xsl:template match="xqxft:ftStopWords">
  <xsl:call-template name="ftStopWords_type"/>
</xsl:template>

<xsl:template name="ftStopWords_type">
  <xsl:choose>
    <xsl:when test="xqxft:ref">
      <xsl:text>at "</xsl:text>
      <xsl:value-of select="xqxft:ref"/>
      <xsl:text>" </xsl:text>
    </xsl:when>
    <xsl:otherwise>
      <xsl:apply-templates/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template match="xqxft:list">
  <xsl:call-template name="parenthesizedList"/>
  <xsl:text> </xsl:text>
</xsl:template>

<xsl:template match="xqxft:FTStopWordsInclExcl">
  <xsl:apply-templates/>
</xsl:template>

<xsl:template match="xqxft:union">
  <xsl:text>union </xsl:text>
  <xsl:call-template name="ftStopWords_type"/>
</xsl:template>

<xsl:template match="xqxft:except">
  <xsl:text>except </xsl:text>
  <xsl:call-template name="ftStopWords_type"/>
</xsl:template>


<xsl:template match="xqxft:language">
  <xsl:text>using language "</xsl:text>
  <xsl:apply-templates/>
  <xsl:text>"</xsl:text>
  <xsl:value-of select="$NEWLINE"/>
</xsl:template>


<xsl:template match="xqxft:wildcard">
  <xsl:text>using </xsl:text>
  <xsl:apply-templates/>
  <xsl:value-of select="$NEWLINE"/>
</xsl:template>


<xsl:template match="xqxft:ftAnd">
  <xsl:apply-templates select="xqx:firstOperand"/>
  <xsl:text> ftand </xsl:text>
  <xsl:apply-templates select="xqx:secondOperand"/>
  <xsl:text> </xsl:text>
</xsl:template>


<xsl:template match="xqxft:ftOr">
  <xsl:apply-templates select="xqx:firstOperand"/>
  <xsl:text> ftor </xsl:text>
  <xsl:apply-templates select="xqx:secondOperand"/>
  <xsl:text> </xsl:text>
</xsl:template>


<xsl:template match="xqxft:ftMildNot">
  <xsl:apply-templates select="xqx:firstOperand"/>
  <xsl:text> not in </xsl:text>
  <xsl:apply-templates select="xqx:secondOperand"/>
  <xsl:text> </xsl:text>
</xsl:template>


<xsl:template match="xqxft:ftUnaryNot">
  <xsl:text>ftnot </xsl:text>
  <xsl:apply-templates select="xqx:operand"/>
  <xsl:text> </xsl:text>
</xsl:template>


<xsl:template match="xqxft:ftPrimaryWithOptions">
  <xsl:apply-templates/>
</xsl:template>


<xsl:template match="xqxft:ftPrimary">
  <xsl:apply-templates/>
</xsl:template>


<xsl:template match="xqxft:parenthesized">
  <xsl:text>( </xsl:text>
  <xsl:apply-templates/>
  <xsl:text> ) </xsl:text>
</xsl:template>


<xsl:template match="xqxft:ftWords">
  <xsl:apply-templates/>
</xsl:template>


<xsl:template match="xqxft:ftWordsValue">
  <xsl:apply-templates/>
</xsl:template>


<xsl:template match="xqxft:ftWordsLiteral">
  <xsl:apply-templates/>
</xsl:template>


<xsl:template match="xqxft:ftWordsExpression">
  <xsl:text> { </xsl:text>
  <xsl:apply-templates/>
  <xsl:text> } </xsl:text>
</xsl:template>


<xsl:template match="xqxft:ftAnyAllOption">
  <xsl:value-of select="."/>
  <xsl:text> </xsl:text>
</xsl:template>


<xsl:template match="xqxft:ftTimes">
  <xsl:text>occurs </xsl:text>
  <xsl:apply-templates/>
  <xsl:text> times </xsl:text>
</xsl:template>


<xsl:template match="xqxft:ftExtensionSelection">
  <xsl:apply-templates select="xqxft:pragma"/>
  <xsl:text> { </xsl:text>
  <xsl:apply-templates select="xqxft:ftSelection"/>
  <xsl:text> } </xsl:text>
</xsl:template>


<xsl:template match="xqxft:pragma">
  <xsl:value-of select="$PRAGMA_BEGIN"/>
  <xsl:apply-templates select="xqx:pragmaName"/>
  <xsl:value-of select="$SPACE"/>
  <xsl:value-of select="xqx:pragmaContents"/>
  <xsl:value-of select="$PRAGMA_END"/>
</xsl:template>


<xsl:template match="xqxft:ftExtensionOption">
  <xsl:text>using option </xsl:text>
  <xsl:apply-templates/>
</xsl:template>


<xsl:template match="xqxft:ftExtensionName">
  <xsl:if test="@xqx:prefix">
    <xsl:value-of select="@xqx:prefix"/>
    <xsl:value-of select="$COLON"/>
  </xsl:if>
  <xsl:apply-templates/>
</xsl:template>


<xsl:template match="xqxft:ftExtensionValue">
  <xsl:text> "</xsl:text>
  <xsl:apply-templates/>
  <xsl:text>"</xsl:text>
</xsl:template>


<xsl:template match="xqxft:weight">
  <xsl:text> weight { </xsl:text>
  <xsl:apply-templates/>
  <xsl:text> } </xsl:text>
</xsl:template>


</xsl:stylesheet>

