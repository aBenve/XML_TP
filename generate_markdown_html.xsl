<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">


<xsl:template match="/">
<html>
    <head>
        <meta charset="utf-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
        <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css"/>
    </head>
    <body>
        <xsl:apply-templates/>
    </body>
    
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="bootstrap/js/bootstrap.min.js"></script>
</html>
</xsl:template>

<xsl:template match="//error">
    <div class="container p-3">
        <div class="alert alert-danger mb-3  text-center">
            <div class="card-title">
                <h3>
                    <xsl:value-of select="."/>
                </h3>
            </div>
            <p class="card-text mb-0">
                Try again by changing the arguments.
            </p>
        </div>
    </div>
</xsl:template>


<xsl:template match="nascar_data[./drivers]">

        <h1 class="text-center text-dark">Drivers for NARCAR <xsl:value-of select="./serie_type"/> Series for <xsl:value-of select="./year"/> season</h1>
        <div class="container">
            <br/>
            <div class="row">
                <div class="card-columns">
                    <xsl:for-each select="./drivers/driver">
                        <xsl:call-template name="driversEstructure">
                            <xsl:with-param name="driver" select="."/>
                        </xsl:call-template>
                    </xsl:for-each>
                </div>
            </div>
        </div>

</xsl:template>

<xsl:template name="driversEstructure">
    <xsl:param name="driver"/>
    <div class="card bg-light mb-3 border-black">
        <div class="card-body">
        <h3 class= "card-title text-center"><xsl:value-of select="$driver/full_name"/></h3>   <!-- Nombre del conductor --> 
<xsl:call-template name="driverInfoList">
        <xsl:with-param name="driver" select="$driver"/>
    </xsl:call-template>
        </div>
    </div>
</xsl:template>

<xsl:template name="driverInfoList">
    <xsl:param name="driver"/>
    <div class="card-text">
    <ol>
        <li><b>Country: </b> <xsl:value-of select="//$driver/country"/> </li>
        <li><b>Birth date: </b> <xsl:value-of select="//$driver/birth_date"/> </li>
        <li><b>Birthplace: </b> <xsl:value-of select="//$driver/birth_place"/> </li>
        <li><b>Car manufacturer: </b> <xsl:value-of select="//$driver/car"/> </li>
        <li><b>Rank: </b> <xsl:value-of select="//$driver/rank"/> </li>
    </ol>
    <xsl:choose>
        <xsl:when test="not(contains($driver/rank, '-')) ">
            <xsl:call-template name="getStatistics">
                <xsl:with-param name="driver" select="$driver"/>
            </xsl:call-template>
        </xsl:when>
        <xsl:otherwise>
            <br></br>   
        </xsl:otherwise>
    </xsl:choose>
    </div>
</xsl:template>

<xsl:template name="getStatistics">
    <xsl:param name="driver"/>
    <div>
    <h4 class="text-center"> Statistics </h4>
    <div class="list-group">
        <a href="#" class="list-group-item list-group-item-action list-group-item-light">Season points: <xsl:value-of select="//$driver/statistic/season_points"/></a>
        <a href="#" class="list-group-item list-group-item-action list-group-item-success">Wins: <xsl:value-of select="//$driver/statistic/wins"/> </a>
        <a href="#" class="list-group-item list-group-item-action list-group-item-light">Poles: <xsl:value-of select="//$driver/statistic/poles"/> </a>
        <a href="#" class="list-group-item list-group-item-action list-group-item-danger">Races not finished: <xsl:value-of select="//$driver/statistic/races_not_finished"/> </a>
        <a href="#" class="list-group-item list-group-item-action list-group-item-light">Laps Completed: <xsl:value-of select="//$driver/statistic/laps_completed"/> </a>
    </div>
    <br/>
    </div>
</xsl:template>
</xsl:stylesheet>
