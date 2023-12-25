update job.tb_match_aptlist b
set apt_cd = a.apt_cd
    ,aptnm_naver = a.aptnm
from public.tb_aptinfo a
where a.pnu = b.pnu
  and a.pnu in (select pnu from public.tb_aptinfo group by pnu having count(*) = 1)
  and b.pnu in (select pnu from job.tb_match_aptlist group by pnu having count(*) = 1)
  and b.apt_cd = ''



  select a.pnu,	b.aptnm  ,	a.aptnm,	b.apt_cd
  from job.tb_match_aptlist a, job.tb_naver_aptlist_org b
  where a.pnu = b.pnu
    and a.apt_cd = ''