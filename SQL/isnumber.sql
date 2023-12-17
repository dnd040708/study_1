CREATE OR REPLACE FUNCTION job.isnumber(string_ character varying)
 RETURNS numeric
 LANGUAGE plpgsql
AS $function$
	declare 
		v_string numeric := -1;
	begin 
		
		v_string := string_:: integer;
		RETURN 1;
		EXCEPTION
		WHEN OTHERS THEN
		RETURN 0;
	end;
$function$
;
