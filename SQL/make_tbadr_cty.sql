CREATE OR REPLACE PROCEDURE job.make_tbadr_cty()
 LANGUAGE plpgsql
AS $procedure$
	begin 
		
		insert into public.tbadr_cty 
		select substring(cty_cd , 1, 4), cty_nm  
		from job.tb_cty_org  
		
		commit;
	end;
$procedure$
;
