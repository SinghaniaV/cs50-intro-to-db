with hit_cost as (
    select
        pf.player_id,
        s.salary,
        pf.H,
        s.salary / pf.H as dollars_per_hit
    from
        salaries as s
    join
        performances as pf
        on s.player_id = pf.player_id
        and s.year = pf.year
    where
        s.year = 2001 and
        pf.H > 0
),

hit_cost_ranked as (
    select
        player_id,
        dollars_per_hit,
        rank() over (order by dollars_per_hit) as dollars_per_hit_rank
    from
        hit_cost
),

rbi_cost as (
    select
        pf.player_id,
        s.salary,
        pf.RBI,
        s.salary / pf.RBI as dollars_per_rbi
    from
        salaries as s
    join
        performances as pf
        on s.player_id = pf.player_id
        and s.year = pf.year
    where
        s.year = 2001 and
        pf.RBI > 0
),

rbi_cost_ranked as (
    select
        player_id,
        dollars_per_rbi,
        rank() over (order by dollars_per_rbi) as dollars_per_rbi_rank
    from
        rbi_cost
),

cheapest_players as (
    select
        hcr.player_id
    from
        hit_cost_ranked as hcr
    inner join
        rbi_cost_ranked as rcr
        on hcr.player_id = rcr.player_id
    where
        hcr.dollars_per_hit_rank <= 10 and
        rcr.dollars_per_rbi_rank <= 10
)

select
    pl.first_name,
    pl.last_name
from
    cheapest_players as cp
inner join
    players as pl
    on cp.player_id = pl.id
order by
    pl.id;
