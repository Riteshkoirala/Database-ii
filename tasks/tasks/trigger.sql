CREATE OR REPLACE TRIGGER trigger_retreat_name
BEFORE INSERT ON retreat
FOR EACH ROW
DECLARE
	vn_coll NUMBER(3);
BEGIN
	SELECT COUNT(retreat_name) INTO vn_coll FROM retreat 
	WHERE retreat_name = :NEW.retreat_name;
	IF vn_coll>0 THEN
		RAISE_APPLICATION_ERROR (-20001,'ERROR! THE PROVIDED name ALREADY EXISTS');
	END IF;
END trig_retreat_name;
/
SHOW ERRORS;


CREATE OR REPLACE TRIGGER trigger_review_name
BEFORE INSERT ON review
FOR EACH ROW
DECLARE
	vn_coll NUMBER(3);
BEGIN
	SELECT COUNT(user_name) INTO vn_coll FROM review 
	WHERE user_name = :NEW.user_name;
	IF vn_coll>0 THEN
		RAISE_APPLICATION_ERROR (-20001,'ERROR! THE PROVIDED Name ALREADY EXISTS, SO DELETE YOU exiting REVIEW and TRY AGAIN');
	END IF;
END trig_review_name;
/
SHOW ERRORS;

CREATE OR REPLACE TRIGGER trigger_accomo_sty_name
BEFORE INSERT ON accommodation_style
FOR EACH ROW
DECLARE
	vn_coll NUMBER(3);
BEGIN
	SELECT COUNT(accommodation_type) INTO vn_coll FROM accommodation_style 
	WHERE accommodation_type = :NEW.accommodation_type;
	IF vn_coll>0 THEN
		RAISE_APPLICATION_ERROR (-20001,'ERROR! THE PROVIDED Name ALREADY EXISTS, SO DELETE YOU exiting REVIEW and TRY AGAIN');
	END IF;
END trigger_accomo_sty_name;
/
SHOW ERRORS;



CREATE or REPLACE TRIGGER trig_insertable_accommodation 
BEFORE INSERT OR UPDATE ON accommodation 
FOR EACH ROW 
DECLARE 
    vn_count_id_status NUMBER(10);
BEGIN
    SELECT COUNT(accommodation_style_id)
    INTO vn_count_id_status
    FROM accommodation_style
    WHERE accommodation_style_id = :NEW.accommodation_style_id;
IF vn_count_id_status < 1 THEN
    RAISE_APPLICATION_ERROR(-20000,'There is no data with the given id in 
the accommodation style table');
ELSE NULL;
END IF;
END trig_insertable_accommodation;
/
SHOW ERRORS;



CREATE OR REPLACE TRIGGER trig_insertable_rsetting
BEFORE INSERT OR UPDATE ON retreat_setting
FOR EACH ROW
DECLARE
	vn_count_sid NUMBER(10);
	vn_count_rid NUMBER(10);
BEGIN
	SELECT COUNT(setting_id)
	INTO vn_count_sid
	FROM setting
	WHERE setting_id = :NEW.setting_id;

	SELECT COUNT(retreat_id)
	INTO vn_count_rid
	FROM retreat
	WHERE retreat_id = :NEW.retreat_id;

IF vn_count_sid < 1 THEN
	RAISE_APPLICATION_ERROR(-20000,'There is no reference data with the given id in 
the settings table');
ELSE NULL;
END IF;
IF vn_count_rid < 1 THEN
	RAISE_APPLICATION_ERROR(-20000,'There is no reference data with the given id in 
the retreat table');
ELSE NULL;
END IF;
END trig_insertable_rsetting;
/
SHOW ERRORS;





