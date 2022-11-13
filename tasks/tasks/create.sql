CREATE OR REPLACE TYPE address_type AS OBJECT(
	city VARCHAR2(50),
	street VARCHAR2(50),
	country VARCHAR2(50),
	zip_code NUMBER(10));
/

CREATE TABLE addresses OF address_type;


CREATE OR REPLACE TYPE cost_type AS OBJECT(
	amount NUMBER(10),
	discount NUMBER(10),
	total_amount NUMBER(10)
);
/

CREATE TYPE cost_varray_type AS VARRAY(55) OF cost_type;
/


CREATE OR REPLACE TYPE scheme_type AS OBJECT(
	mentor_name VARCHAR2(50),
	convention_name VARCHAR2(50)
);
/

CREATE TYPE scheme_table_type AS TABLE OF scheme_type;
/


CREATE TABLE accommodation_style(
	accommodation_style_id NUMBER(10),
	accommodation_type VARCHAR2(50),
	description VARCHAR2(50)
);




CREATE TABLE accommodation(
	accommodation_id NUMBER(10),
	arrival_date DATE,
	no_of_room NUMBER(10),
	accommodation_style_id NUMBER(10),
	cost cost_varray_type,
	address REF address_type SCOPE IS addresses
);


CREATE TABLE retreat(
	retreat_id NUMBER(10),
	retreat_name VARCHAR2(50),
	description VARCHAR2(50)
);


CREATE TABLE setting(
	setting_id NUMBER(10),
	setting_name VARCHAR2(50),
	description VARCHAR2(50)
);



CREATE TABLE retreat_setting(
	retreat_setting_id NUMBER(10),
	retreat_id NUMBER(10),
	setting_id NUMBER(10)
);



CREATE TABLE retreat_accommodation(
	retreat_accommodation_id NUMBER(10),
	retreat_id NUMBER(10),
	accommodation_id NUMBER(10),
	scheme scheme_table_type)
NESTED TABLE scheme STORE AS nested_scheme_table_type;


CREATE TABLE review(
	review_id NUMBER(10),
	user_name VARCHAR2(45),
	review_Point NUMBER(10),
	retreat_setting_id NUMBER(10),
	feedback VARCHAR2(100)
);