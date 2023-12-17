CREATE OR REPLACE PROCEDURE job.make_tbadr_zone()
 LANGUAGE plpgsql
AS $procedure$
	begin 
		
		insert into public.tbadr_zone 
		select substring(zone_cd, 1, 4), substring(zone_cd, 1, 8), zone_nm 
		from job.tb_zone_org  
		
		commit;
	end;
$procedure$
;
