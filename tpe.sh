#!/bin/bash

valid_race_types=("sc" "xf" "cw" "go" "mc" "enas")
valid_dates=("2013" "2021")

special_race_date=("enas" "2020")

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
					# Si estamos hablando de una carrera que solo se celebró un determinado año
					
					if [ "$2" == "${special_race_date[0]}" ];
					then
						if [ "$1" -ne "${special_race_date[1]}" ];
						then ./get_error.sh "Parameter 1: Parameter 2 is ok but ' "${special_race_date[0]}" ' its only supported for ' "${special_race_date[1]}" ' season"
						fi
					fi
					
					# Si los argumentos son validos, se almacena la informacion en nascar_data.xml

					curl http://api.sportradar.us/nascar-ot3/"$2"/"$1"/drivers/list.xml?api_key=${SPORTRADAR_API} -o drivers_list.xml
					java net.sf.saxon.Transform -s:drivers_list.xml -xsl:remove_xmlns.xsl  -o:drivers_list.xml
					
					curl http://api.sportradar.us/nascar-ot3/"$2"/"$1"/standings/drivers.xml?api_key=${SPORTRADAR_API} -o drivers_standings.xml
					java net.sf.saxon.Transform -s:drivers_standings.xml -xsl:remove_xmlns.xsl -o:drivers_standings.xml
					
					java net.sf.saxon.Query extract_nascar_data.xq !indent=yes -o:nascar_data.xml
					founded="0"
				fi
			done
			if [ "$founded" == "1" ];
			then
		   		./get_error.sh "Parameter 2: 'race_type' is incorrect"
		   	fi
		else
			./get_error.sh "Parameter 1: 'year' must be lesser than or equal to '2021' "
		fi
	else
		./get_error.sh "Parameter 1: 'year' must be greater than or equal to '2013' "
	fi
else
	./get_error.sh "There is needed 2 parameters: 'year' 'race_type' "
fi

# Sea que llego con error o no, se ejecuta y se obtiene un markdown y pagina HTML

java net.sf.saxon.Transform -s:nascar_data.xml -xsl:generate_markdown.xsl -o:nascar_page.md
java net.sf.saxon.Transform -s:nascar_data.xml -xsl:generate_markdown_html.xsl -o:nascar_page_html.html
