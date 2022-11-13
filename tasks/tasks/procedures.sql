SET SERVEROUTPUT ON

CREATE OR REPLACE PROCEDURE proc_avg_rating AS
	vn_avg NUMBER(5):= func_avg_rating;
BEGIN
	IF vn_avg>0 THEN
		DBMS_OUTPUT.PUT_LINE('There is average '|| vn_avg || ' rating in the system.');
	ELSE 
		DBMS_OUTPUT.PUT_LINE('There is no rating available.');
	END IF;
END proc_avg_rating;
/
SHOW ERRORS;
EXECUTE proc_avg_rating;



CREATE OR REPLACE PROCEDURE proc_show_acco_style
IS as_id accommodation_style.accommodation_style_id%TYPE;
   as_type accommodation_style.accommodation_type%TYPE;
   as_desc accommodation_style.description%TYPE;


BEGIN
SELECT accommodation_style_id, accommodation_type, description
INTO as_id, as_type, as_desc
FROM accommodation_style;

		DBMS_OUTPUT.PUT_LINE('accommodation_style_id' || '        '|| 'accommodation_type' ||'                '||'description');
		DBMS_OUTPUT.PUT_LINE(as_id || '                 '|| as_type ||'                       '|| as_desc);

EXCEPTION

WHEN too_many_rows THEN
dbms_output.put_line('It can only fetch one data');

END proc_show_acco_style;
/
SHOW ERRORS;
EXECUTE proc_show_acco_style;



CREATE OR REPLACE PROCEDURE proc_retreat(val IN retreat.retreat_id%TYPE)
IS r_id retreat.retreat_id%TYPE;
   r_name retreat.retreat_name%TYPE;
   r_description retreat.description%TYPE;

BEGIN
SELECT retreat_id, retreat_name, description
INTO r_id, r_name, r_description
FROM retreat
WHERE retreat_id=val;

		DBMS_OUTPUT.PUT_LINE('retreat_id' || '        '|| 'retreat_name' ||'                '||'description');
		DBMS_OUTPUT.PUT_LINE(r_id || '                 '|| r_name ||'                       '|| r_description);

EXCEPTION
      WHEN no_data_found THEN 
      dbms_output.put_line('There is no data available');
   WHEN others THEN 
      dbms_output.put_line('Error!'); 

END proc_retreat;
/
SHOW ERRORS;
EXECUTE proc_retreat(1);



CREATE OR REPLACE PROCEDURE proc_retreat_setting
IS s_id retreat_setting.retreat_setting_id%TYPE;

BEGIN
for c in (SELECT retreat_setting_id INTO s_id FROM retreat_setting)

loop
	s_id := c.retreat_setting_id;
	dbms_output.put_line(s_id);
end loop;

END proc_retreat_setting;
/
SHOW ERRORS;
EXECUTE proc_retreat_setting;



CREATE OR REPLACE PROCEDURE proc_setting(val IN setting.setting_id%TYPE)
IS s_id setting.setting_id%TYPE;
   s_name setting.setting_name%TYPE;
   s_description setting.description%TYPE;

BEGIN
SELECT setting_id, setting_name, description
INTO s_id, s_name, s_description
FROM setting
WHERE setting_id=val;
		DBMS_OUTPUT.PUT_LINE('setting_id' || '        '|| 'setting_name' ||'                ' ||'description');
		DBMS_OUTPUT.PUT_LINE(s_id || '                '|| s_name ||'                        ' || s_description);
EXCEPTION
      WHEN no_data_found THEN 
      dbms_output.put_line('There is no data available');
   WHEN others THEN 
      dbms_output.put_line('Error!'); 

END proc_setting;
/
SHOW ERRORS;
EXECUTE proc_setting(2);



CREATE OR REPLACE PROCEDURE proc_retreat_accommodation(val IN retreat_accommodation.retreat_accommodation_id%TYPE) IS 
   ra_id retreat_accommodation.retreat_accommodation_id%TYPE;
   ra_mentor VARCHAR2(50);
   ra_convention VARCHAR2(50);

BEGIN
SELECT retreat_accommodation_id, t.*
INTO ra_id, ra_mentor, ra_convention
FROM retreat_accommodation a, table (a.scheme) t
WHERE retreat_accommodation_id=val;
		DBMS_OUTPUT.PUT_LINE('retreat_accommodation_id' || '        '|| 'mentor_name' ||'                ' ||'convention');
		DBMS_OUTPUT.PUT_LINE(ra_id || '                '|| ra_mentor ||'                        ' || ra_convention);
EXCEPTION
      WHEN no_data_found THEN 
      dbms_output.put_line('There is no data available');
   WHEN others THEN 
      dbms_output.put_line('Error!'); 

END proc_retreat_accommodation;
/
SHOW ERRORS;
EXECUTE proc_retreat_accommodation(2);



CREATE OR REPLACE PROCEDURE proc_total_expense_func_user(in_accommodation_id NUMBER) IS
	vn_expense_made_individually NUMBER(10);

BEGIN 
	vn_expense_made_individually := func_sum_total_amount(in_accommodation_id);
 
	DBMS_OUTPUT.PUT_LINE('The total expenses made was ' ||  vn_expense_made_individually);

EXCEPTION
      WHEN no_data_found THEN 
      	dbms_output.put_line('We cannot find any data according to given detail');
   	WHEN others THEN 
      	dbms_output.put_line('Opps! wrong!');
END proc_total_expense_func_user;
/
SHOW ERRORS;
EXECUTE proc_total_expense_func_user(1);



CREATE OR REPLACE PROCEDURE proc_find_amount(in_accommodation_id NUMBER) IS
vn_total_cost NUMBER(10);
vn_user_to_id NUMBER(10);
BEGIN
    SELECT c.total_amount
    INTO vn_total_cost
    FROM accommodation a, TABLE(a.cost)c
    WHERE accommodation_id =  in_accommodation_id;

    vn_total_cost := func_find_total_tax(vn_total_cost);
    DBMS_OUTPUT.PUT_LINE('The total bill after tax and service charge is ' ||  vn_total_cost);

EXCEPTION
      WHEN no_data_found THEN 
          dbms_output.put_line('We cannot find any data according to given detail');
       WHEN others THEN 
          dbms_output.put_line('Opps! wrong!');
END proc_find_amount;
/
SHOW ERRORS;
EXECUTE proc_find_amount(1);



CREATE OR REPLACE PROCEDURE proc_find_address(in_accommodation_id NUMBER) IS 
	vn_expected_city VARCHAR2(50);
	vn_expected_street VARCHAR2(50);
	vn_expected_country VARCHAR2(50);
	vn_expected_zip NUMBER(10);
BEGIN 
	SELECT a.address.city,a.address.street,a.address.country,a.address.zip_code
	INTO vn_expected_city,vn_expected_street,vn_expected_country,vn_expected_zip
	FROM accommodation a
	WHERE accommodation_id = in_accommodation_id;
	DBMS_OUTPUT.PUT_LINE('The Accommodation with id ' || in_accommodation_id || ' is located at : ');
	DBMS_OUTPUT.PUT_LINE('Country: ' || vn_expected_country);
	DBMS_OUTPUT.PUT_LINE('City: ' || vn_expected_city);
	DBMS_OUTPUT.PUT_LINE('Street: ' || vn_expected_street);
	DBMS_OUTPUT.PUT_LINE('Zip line: ' || vn_expected_zip);

EXCEPTION
      WHEN no_data_found THEN 
      	dbms_output.put_line('We cannot find any data according to given detail);
   	WHEN others THEN 
      	dbms_output.put_line('Opps! wrong!');
END proc_find_address;
/
SHOW ERRORS;
EXECUTE proc_find_address(2);



CREATE SEQUENCE seq_accommmodation_style_id
START WITH 1
INCREMENT BY 1
MINVALUE 1
MAXVALUE 500
CACHE 10;

CREATE OR REPLACE PROCEDURE proc_style_accommodation_insert(in_accommodation_type VARCHAR2, in_description VARCHAR2) IS
BEGIN
    INSERT INTO accommodation_style(accommodation_style_id, accommodation_type, description)
    VALUES (seq_accommmodation_style_id.nextval,in_accommodation_type,in_description);

    DBMS_OUTPUT.PUT_LINE('A new row has been inserted into accommodation style table.');

END proc_style_accommodation_insert;
/
SHOW ERRORS;
EXECUTE proc_style_accommodation_insert('cabin', 'private space for travellers');
EXECUTE proc_style_accommodation_insert('teepee', 'special cone shaped tents');
EXECUTE proc_style_accommodation_insert('luxury', 'abundance ease and comfort');
EXECUTE proc_style_accommodation_insert('rustic', 'simple and rough');
EXECUTE proc_style_accommodation_insert('tree house', 'treeshed among the trunk or branches');



CREATE OR REPLACE PROCEDURE proc_insert_addresses(in_street IN VARCHAR2, in_city IN VARCHAR2, in_country IN VARCHAR2, in_zip_code IN NUMBER) IS

BEGIN
    INSERT INTO addresses (street,city,country,zip_code)
    VALUES (in_street,in_city,in_country, in_zip_code);
    DBMS_OUTPUT.PUT_LINE('ROW INSERTED SUCESSFULLY');
END proc_insert_addresses;
/
SHOW ERRORS;
EXECUTE proc_insert_addresses('Sankhu', 'Ktm', 'Nepal', 44600);
EXECUTE proc_insert_addresses('Jorpati', 'Ktm', 'Nepal', 44600);
EXECUTE proc_insert_addresses('Maitidevi', 'Ktm', 'Nepal', 44600);
EXECUTE proc_insert_addresses('Thamel', 'Ktm', 'Nepal', 44600);
EXECUTE proc_insert_addresses('Sabda Marga', 'Ktm', 'Nepal', 44600);




INSERT INTO accommodation
SELECT 1, TO_DATE('1989-12-09','YYYY-MM-DD'), 5, 2, cost_varray_type(cost_type(10000, 900, 9100)),
REF (a)
FROM addresses a 
WHERE street = 'Sankhu';

INSERT INTO accommodation
SELECT 2, TO_DATE('1999-11-09','YYYY-MM-DD'), 4, 2, cost_varray_type(cost_type(20000, 900, 19100)),
REF (a)
FROM addresses a 
WHERE street = 'Jorpati';

INSERT INTO accommodation
SELECT 3, TO_DATE('1949-12-09','YYYY-MM-DD'), 3, 2, cost_varray_type(cost_type(30000, 900, 29100)),
REF (a)
FROM addresses a 
WHERE street = 'Thamel';

INSERT INTO accommodation
SELECT 4, TO_DATE('1999-11-09','YYYY-MM-DD'), 4, 2, cost_varray_type(cost_type(30000, 900, 10100)),
REF (a)
FROM addresses a 
WHERE street = 'Maitidevi';

INSERT INTO accommodation
SELECT 5, TO_DATE('1949-12-09','YYYY-MM-DD'), 3, 2, cost_varray_type(cost_type(40000, 900, 20100)),
REF (a)
FROM addresses a 
WHERE street = 'Sabda Marga';



CREATE SEQUENCE seq_setting_id
START WITH 1
INCREMENT BY 1
MINVALUE 1
MAXVALUE 500
CACHE 10;

CREATE OR REPLACE PROCEDURE proc_insert_setting(in_setting_name VARCHAR2, in_description VARCHAR2) IS
BEGIN
    INSERT INTO setting(setting_id, setting_name, description)
    VALUES (seq_setting_id.nextval,in_setting_name,in_description);

    DBMS_OUTPUT.PUT_LINE('ROW INSERTED SUCESSFULLY');

END proc_insert_setting;
/
SHOW ERRORS;
EXECUTE proc_insert_setting('costal', 'coolera than places inland');
EXECUTE proc_insert_setting('woodland', 'open grassy spaces');
EXECUTE proc_insert_setting('lakeside', 'summer cottage on the lakeside');
EXECUTE proc_insert_setting('winter wonderland', 'a lodge with soft wollen blankers');
EXECUTE proc_insert_setting('eco friendly', 'not environmentally harmful');



CREATE SEQUENCE seq_retreat_id
START WITH 1
INCREMENT BY 1
MINVALUE 1
MAXVALUE 500
CACHE 10;

CREATE OR REPLACE PROCEDURE proc_insert_retreat(in_retreat_name VARCHAR2, in_description VARCHAR2) IS
BEGIN
	INSERT INTO retreat(retreat_id, retreat_name, description)
	VALUES (seq_retreat_id.nextval,in_retreat_name,in_description);

    DBMS_OUTPUT.PUT_LINE('ROW INSERTED SUCESSFULLY');

END proc_insert_retreat;
/
SHOW ERRORS; 
EXECUTE proc_insert_retreat('Personal Growth', 'level up yourself to become best self');
EXECUTE proc_insert_retreat('Self Discovery', 'discover the real you');
EXECUTE proc_insert_retreat('Spiritual', 'closer connection with spiritual things');
EXECUTE proc_insert_retreat('Fitness', 'promote health and longevity');
EXECUTE proc_insert_retreat('Emotional Healing', 'addresses traumatic events');



CREATE SEQUENCE seq_main_id
START WITH 1
INCREMENT BY 1
MINVALUE 1
MAXVALUE 500
CACHE 10;

CREATE OR REPLACE PROCEDURE proc_insert_converge(in_retreat_id VARCHAR2, in_accommodation_id NUMBER, in_mentor_name VARCHAR2, in_convention_name VARCHAR2) IS
BEGIN
	INSERT INTO retreat_accommodation(retreat_accommodation_id, retreat_id, accommodation_id, scheme)
	VALUES (seq_main_id.nextval, in_retreat_id, in_accommodation_id, scheme_table_type(scheme_type(in_mentor_name,in_convention_name)));

    DBMS_OUTPUT.PUT_LINE('ROW INSERTED SUCESSFULLY');

END proc_insert_converge;
/
SHOW ERRORS;
EXECUTE proc_insert_converge(1, 3, 'Ritesh','well trained');
EXECUTE proc_insert_converge(3, 1, 'Nischal','acrobatic');
EXECUTE proc_insert_converge(2, 2, 'Adwait','exceptional');
EXECUTE proc_insert_converge(3, 2, 'Tshering','beginner');
EXECUTE proc_insert_converge(1, 3, 'Dipak','intermediate');



CREATE OR REPLACE PROCEDURE proc_insert_retreat_setting(in_id NUMBER, in_retreat_id NUMBER, in_setting_id NUMBER) IS
BEGIN
	INSERT INTO retreat_setting(retreat_setting_id, retreat_id, setting_id)
	VALUES (in_id, in_retreat_id, in_setting_id);

    DBMS_OUTPUT.PUT_LINE('ROW INSERTED SUCESSFULLY');

END proc_insert_retreat_setting;
/
SHOW ERRORS;
EXECUTE proc_insert_retreat_setting(1, 5, 3);
EXECUTE proc_insert_retreat_setting(2, 4, 1);
EXECUTE proc_insert_retreat_setting(3, 2, 5);
EXECUTE proc_insert_retreat_setting(4, 3, 2);
EXECUTE proc_insert_retreat_setting(5, 1, 4);



CREATE OR REPLACE PROCEDURE proc_insert_review(in_review_id NUMBER, in_username VARCHAR2, in_review_point NUMBER, in_retreat_setting_id NUMBER, in_feedback VARCHAR2) IS
BEGIN
	INSERT INTO review(review_id, user_name, review_Point, retreat_setting_id, feedback)
	VALUES (in_review_id, in_username, in_review_point, in_retreat_setting_id, in_feedback);

    DBMS_OUTPUT.PUT_LINE('ROW INSERTED SUCESSFULLY');

END proc_insert_review;
/
SHOW ERRORS;
EXECUTE proc_insert_review(1, 'Ritesh', 4, 1, 'VERY GOOD');
EXECUTE proc_insert_review(2, 'Nischal', 3, 4, 'EXCELLENT');
EXECUTE proc_insert_review(3, 'Kirito', 2, 5, 'BRILLIANT');
EXECUTE proc_insert_review(4, 'Adwait', 5, 2, 'AMAZING');
EXECUTE proc_insert_review(5, 'Tshering', 3, 3, 'GOOD');


