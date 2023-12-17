CREATE OR REPLACE PROCEDURE job.make_pnu()
 LANGUAGE plpgsql
AS $procedure$
	declare
		v_cursor record; 
	
		v_str1 varchar(10) := '';
		v_str2 varchar(10) := '';
		v_str3 varchar(10) := '';
		v_str4 varchar(30) := '';
	
		v_cty_cd varchar(4) := '';
		v_zone_cd varchar(8) := '';
		v_jibun varchar(9) := '';
		v_main_jibun varchar(10) := '';
		v_sub_jibun varchar(10) := '';
		o_v varchar(50) := '';
		i numeric := 1;
		n numeric := 10;
		j numeric := 0;
	begin 
		select count(*)
		into n
		from job.tb_pnu_job;
       
		loop 
			v_jibun := '';
		
			select length(addr) - length(replace(addr,' ',''))
			into j
			from job.tb_pnu_job
		    where addr_cd = i;
		
			if j = 3 THEN
				select 
					split_part(addr, ' ', 1)
					, split_part(addr, ' ', 2)
					, split_part(addr, ' ', 3)
					, split_part(addr, ' ', 4)
				into v_str1, v_str2, v_str3, v_str4
				from job.tb_pnu_job
				where addr_cd = i;
			end if;
		
			if position(v_str1 in '서울') >= 0 then
				select a.cty_cd, b.zone_cd
				into v_cty_cd, v_zone_cd
				from public.tbadr_cty a , public.tbadr_zone b
				where v_str2 = a.cty_nm 
				  and a.cty_cd = b.cty_cd
			      and v_str3 = b.zone_nm;
			end if;
			
			if v_str4 like '산%' then
				v_jibun := concat(v_jibun, '1');
				v_str4 := replace(v_str4,'산','');
			else
				v_jibun := concat(v_jibun, '0');
			end if;
			
			if j = 3 THEN
				if job.isnumber(replace(v_str4, '-', null)) then
					if job.isnumber(split_part(v_str4, '-', 1)) then
						v_main_jibun := split_part(v_str4, '-', 1);
						if split_part(v_str4, '-', 2) = '' then
							v_sub_jibun := '0';
						end if;
					
						if job.isnumber(split_part(v_str4, '-', 2)) = 1 then
							v_sub_jibun := split_part(v_str4, '-', 2);
						end if;
					end if;
				end if;
			
			    v_jibun := concat(v_jibun, LPAD(v_main_jibun,4,'0'));
			    v_jibun := concat(v_jibun, LPAD(v_sub_jibun,4,'0'));
			else
				v_zone_cd := null;
				v_cty_cd := null;
				v_jibun := null;
			end if;
			
		    update job.tb_pnu_job
            SET   pnu                = v_zone_cd ||  v_jibun
                 ,cty_cd             = v_cty_cd
                 ,zone_cd            = v_zone_cd
            where addr_cd = i
              and j = 3;
			exit when i = n ; 
			i := i + 1;
		END LOOP;
	commit;
	end;
$procedure$
;