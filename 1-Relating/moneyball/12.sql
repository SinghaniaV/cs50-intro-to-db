WITH per_hit AS (
    SELECT
        players.first_name,
        players.last_name,
        salaries.salary / performances.H AS "dollars per hit"
    FROM
        players
        JOIN salaries ON players.id = salaries.player_id
        JOIN performances ON players.id = performances.player_id
        AND salaries.year = performances.year
    WHERE
        performances.year = 2001
        AND performances.H > 0
    ORDER BY
        "dollars per hit"
    LIMIT
        10
),

per_rbi AS (
    SELECT
        players.first_name,
        players.last_name,
        salaries.salary / performances.RBI AS "dollars per rbi"
    FROM
        players
        JOIN salaries ON players.id = salaries.player_id
        JOIN performances ON players.id = performances.player_id
        AND salaries.year = performances.year
    WHERE
        performances.year = 2001
        AND performances.RBI > 0
    ORDER BY
        "dollars per rbi"
    LIMIT
        10
)

SELECT
    per_rbi.first_name, per_rbi.last_name
FROM
    per_rbi
JOIN
    per_hit ON per_hit.first_name = per_rbi.first_name
ORDER BY
    per_rbi.last_name;
