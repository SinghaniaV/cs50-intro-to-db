SELECT
	"title", "air_date"
FROM
	"episodes"
GROUP BY
	strftime('%Y', air_date);
