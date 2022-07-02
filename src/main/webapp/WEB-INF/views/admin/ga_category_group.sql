show tables;

create table ga_category_group(
	category_group_idx 		INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	category_group_code		varchar(8) NOT NULL UNIQUE,
	category_group_name		varchar(10) NOT NULL,
	category_group_use_yn	varchar(1) NOT NULL DEFAULT 'y',
	category_group_level	INT NOT NULL,
	category_group_del_yn	varchar(1) NOT NULL DEFAULT 'n'
);

desc ga_category_group;