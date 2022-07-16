CREATE TABLE ga_order(
	order_idx			INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    user_idx 			INT NOT NULL,
    order_total_amount 	INT NOT NULL,
    email				VARCHAR(60) NOT NULL,
    tel					VARCHAR(20)	NOT NULL,
    user_delivery_idx	INT NOT NULL,
    order_admin_memo	TEXT NOT NULL,
    created_date 		DATETIME NOT NULL DEFAULT now(),
	foreign key(user_idx) references ga_user(user_idx)
);



CREATE TABLE ga_order_list(
	order_list_idx		INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    order_idx			INT NOT NULL,
    item_idx			INT NOT NULL,
    item_name			VARCHAR(255) NOT NULL,
    item_image			VARCHAR(255) NOT NULL,
    item_price			INT NOT NULL,
    item_option_flag	VARCHAR(1) NOT NULL,
    option_idx			INT,
    option_name			VARCHAR(255),
    option_price		VARCHAR(255),
    order_quantity		INT NOT NULL,
    order_status_code	VARCHAR(1) NOT NULL DEFAULT 1,
    created_date 		DATETIME NOT NULL DEFAULT now(),
    foreign key(item_idx) references ga_item(item_idx),
    foreign key(order_idx) references ga_order(order_idx)
);


CREATE TABLE ga_user_delivery(
	user_delivery_idx INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	user_idx 		  INT NOT NULL,
    default_flag	  VARCHAR(1) NOT NULL,
    title			  VARCHAR(50) NOT NULL,
    delivery_name	  VARCHAR(50) NOT NULL,
    delivery_tel      VARCHAR(20) NOT NULL,
    postcode		  VARCHAR(255) NOT NULL,
    roadAddress		  VARCHAR(255) NOT NULL,
    detailAddress	  VARCHAR(255) NOT NULL,
    extraAddress	  VARCHAR(255),
    address			  VARCHAR(255) NOT NULL,
    message			  VARCHAR(500), 
    created_date 		DATETIME NOT NULL DEFAULT now(),
    foreign key(user_idx) references ga_user(user_idx)
);

drop table ga_user_delivery;
select from ga_user_delivery where user_idx = 1 and default_flag = 'y';