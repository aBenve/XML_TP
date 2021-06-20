<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template match="nascar_data">
# Drivers for NARCAR <xsl:value-of select="./serie_type"/> Series for <xsl:value-of select="./year"/> season
---
---
<xsl:for-each select="./drivers/driver">
    <xsl:call-template name="driversEstructure">
        <xsl:with-param name="driver" select="."/>
    </xsl:call-template>
</xsl:for-each>

</xsl:template>

<xsl:template name="driversEstructure">
    <xsl:param name="driver"/>
### <xsl:value-of select="$driver/full_name"/>   <!-- Nombre del conductor --> 
<xsl:call-template name="driverInfoList">
        <xsl:with-param name="driver" select="$driver"/>
    </xsl:call-template>
</xsl:template>

<xsl:template name="driverInfoList">
    <xsl:param name="driver"/>
1. Country: <xsl:value-of select="//$driver/country"/> 
2. Birth date: <xsl:value-of select="//$driver/birth_date"/> 
3. Birthplace: <xsl:value-of select="//$driver/birth_place"/> 
4. Car manufacturer: <xsl:value-of select="//$driver/car"/> 
5. Rank: <xsl:value-of select="//$driver/rank"/> 
    <xsl:choose>
        <xsl:when test="not(contains($driver/rank, '-')) ">
            <xsl:call-template name="getStatistics">
                <xsl:with-param name="driver" select="$driver"/>
            </xsl:call-template>
        </xsl:when>
        <xsl:otherwise>
---
        </xsl:otherwise>
    </xsl:choose>
</xsl:template>

<xsl:template name="getStatistics">
    <xsl:param name="driver"/>
    ##### Statistics
    - Season points: <xsl:value-of select="//$driver/statistic/season_points"/>
    - Wins: <xsl:value-of select="//$driver/statistic/wins"/> 
    - Poles: <xsl:value-of select="//$driver/statistic/poles"/> 
    - Races not finished: <xsl:value-of select="//$driver/statistic/races_not_finished"/> 
    - Laps Completed: <xsl:value-of select="//$driver/statistic/laps_completed"/> 
---
</xsl:template>
</xsl:stylesheet>