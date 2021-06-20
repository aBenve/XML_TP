<nascar_data>
	<year>{data(doc("drivers_list.xml")//series/season/@year)}</year>
	<serie_type>{data(doc("drivers_list.xml")//series/@alias)}</serie_type>
	<drivers>
		{
		for $a in doc("drivers_list.xml")//series/season/driver,
			$b in doc("drivers_standings.xml")//series/season
			order by $a/@full_name
			return
				<driver>
					<full_name>{data($a/@full_name)}</full_name>
					<country>{data($a/@country)}</country>
					<birth_date>{data($a/@birthday)}</birth_date>
					<birth_place>{data($a/@birth_place)}</birth_place>
					<car>
						{
						if($a/car/manufacturer)
						then data($a/car[1]/manufacturer/@name)
						else "-"
						}
					</car>
					<rank>
						{
						if(some $c in $b satisfies ($c/driver/@id = $a/@id))
						then data($b/driver[@id = $a/@id]/@rank)
						else "-"
						}
					</rank>
					<statistic>
						<season_points>{data($b/driver[@id = $a/@id]/@points)}</season_points>
						<wins>{data($b/driver[@id = $a/@id]/@wins)}</wins>
						<poles>{data($b/driver[@id = $a/@id]/@poles)}</poles>
						<races_not_finished>{data($b/driver[@id = $a/@id]/@races_not_finished)}</races_not_finished>
						<laps_completed>{data($b/driver[@id = $a/@id]/@laps_completed)}</laps_completed>
					</statistic>
				</driver>
		}
	</drivers>
</nascar_data>