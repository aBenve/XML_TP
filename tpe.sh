#!/bin/bash

valid_race_types=("sc" "xf" "cw" "go" "mc" "enas")
valid_dates=("2013" "2021")

founded="1"

if [ "$#" -eq "2" ]; then
	if [ "$1" -ge "${valid_dates[0]}" ];
	then
		if [ "$1" -le "${valid_dates[1]}" ];
		then
			for i in "${valid_race_types[@]}";
			do
				if [ "$2" == "$i" ];
				then
					curl http://api.sportradar.us/nascar-ot3/"$2"/"$1"/drivers/list.xml?api_key=${SPORTRADAR_API} -o drivers_list.xml
					java net.sf.saxon.Transform -s:drivers_list.xml -xsl:remove_xmlns.xsl  -o:drivers_list.xml
					
					curl http://api.sportradar.us/nascar-ot3/"$2"/"$1"/standings/drivers.xml?api_key=${SPORTRADAR_API} -o drivers_standings.xml
					java net.sf.saxon.Transform -s:drivers_standings.xml -xsl:remove_xmlns.xsl -o:drivers_standings.xml
					
					java net.sf.saxon.Query extract_nascar_data.xq !indent=yes -o:nascar_data.xml
					java dom.Writer -v –n –s –f nascar_data.xml
					
					java net.sf.saxon.Transform -s:nascar_data.xml -xsl:generate_markdown.xsl -o:nascar_page.md
					java net.sf.saxon.Transform -s:nascar_data.xml -xsl:generate_markdown_html.xsl -o:nascar_page_html.html
					founded="0"
				fi
			done

			if [ "$founded" == "1" ];
			then
		   		echo "Parameter 2: 'race_type' is incorrect"
		   	fi
		else
			echo "Parameter 1: 'year' must be lesser than or equal to '2021' "
		fi
	else
		echo "Parameter 1: 'year' must be greater than or equal to '2013' "
	fi
else
	echo "There is needed 2 parameters: 'year' 'race_type' "
fi
