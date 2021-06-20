<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">


<xsl:template match="nascar_data">
    <html>
        <head>
            <title>Drivers for NARCAR <xsl:value-of select="./series_type"/> Series for <xsl:value-of select="./year"/> season</title>
        </head>
        <body>
          <xsl:apply-templates/>
          <xsl:call-template name="driversEstructure">
              <xsl:with-param name="driver" select="//driver"/>
          </xsl:call-template>
        </body>
    </html>
</xsl:template>

<xsl:template name="driversEstructure">
    <xsl:param name="driver"/>
    <h1>$driver</h1>
    <xsl:call-template name="driverInfoList">
        <xsl:with-param name="driver" select="//driver[full_name = $driver]"/>
    </xsl:call-template>
</xsl:template>

<xsl:template name="driverInfoList">
    <xsl:param name="driver"/>
    <ol>
        <li>Country: <xsl:value-of select="//$driver/country"/> </li>
        <li>Birth date: <xsl:value-of select="//$driver/birth_date"/> </li>
        <li>Birthplace: <xsl:value-of select="//$driver/birth_place"/> </li>
        <li>Car manufacturer: <xsl:value-of select="//$driver/car"/> </li>
        <li>Rank: <xsl:value-of select="//$driver/rank"/> </li>
    </ol>
    <xsl:choose>
        <xsl:when test="contains(//$driver/rank, '-') ">
            <xsl:call-template name="getStatistics">
                <xsl:with-param name="driver" select="//driver[full_name = $driver]"/>
            </xsl:call-template>
        </xsl:when>
    </xsl:choose>
    
</xsl:template>

<xsl:template name="getStatistics">
    <xsl:param name="driver"/>
    <h3>Statistics</h3>
    <ul>
        <li>Season points: <xsl:value-of select="//$driver/statistics/season_points"/></li>
        <li>Wins: <xsl:value-of select="//$driver/statistics/wins"/> </li>
        <li>Poles: <xsl:value-of select="//$driver/statistics/poles"/> </li>
        <li>Races not finished: <xsl:value-of select="//$driver/statistics/races_not_finished"/> </li>
        <li>Laps Completed: <xsl:value-of select="//$driver/statistics/laps_completed"/> </li>
    </ul>
    <br></br>
    <br></br>
</xsl:template>

</xsl:stylesheet>