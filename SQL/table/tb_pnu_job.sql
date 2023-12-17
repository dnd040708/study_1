CREATE TABLE job.tb_pnu_job (
	addr_cd serial4 NOT NULL,
	addr varchar(100) NOT NULL,
	pnu varchar(19) NULL,
	cty_cd varchar(4) NULL,
	zone_cd varchar(8) NULL
);
CREATE UNIQUE INDEX idx_tb_pnu_job ON job.tb_pnu_job USING btree (addr_cd);