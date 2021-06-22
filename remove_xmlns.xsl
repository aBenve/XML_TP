<xsl:stylesheet
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"  version="2.0">
  <xsl:template match="*">
    <xsl:element name="{local-name()}">
      <xsl:apply-templates select="@* | node()"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="@* | text() | comment() | processing-instruction()">
    <xsl:copy/>
  </xsl:template>
</xsl:stylesheet>
