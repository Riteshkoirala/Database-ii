CREATE OR REPLACE PROCEDURE proc_setting_retreat IS
c_setting_name VARCHAR2(50);
c_setting_desc VARCHAR2(50);
c_retreat_name VARCHAR2(50);
c_retreat_desc VARCHAR2(50);
CURSOR cs_retval IS
SELECT s.setting_name,s.description,r.retreat_name,r.description
FROM setting s 
JOIN retreat_setting rs 
ON s.setting_id = rs.setting_id 
JOIN retreat r
ON r.retreat_id = rs.retreat_id;
BEGIN 
OPEN cs_retval;
	LOOP
    	FETCH cs_retval INTO c_setting_name,c_setting_desc,c_retreat_name,c_retreat_desc;
	EXIT WHEN cs_retval%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('Setting name: ' || c_setting_name);
        DBMS_OUTPUT.PUT_LINE('Setting desc: ' ||  c_setting_desc);
        DBMS_OUTPUT.PUT_LINE('Retreat name: ' ||  c_retreat_name);
        DBMS_OUTPUT.PUT_LINE('Retreat desc: ' ||  c_retreat_desc);
        DBMS_OUTPUT.PUT_LINE('');
    END LOOP;
EXCEPTION
    WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE(SQLERRM);
END proc_setting_retreat;
/
SHOW ERRORS;
EXECUTE proc_setting_retreat;



DECLARE
      v_name VARCHAR2(30);
      v_desc VARCHAR2(45);

	CURSOR cur_rev_name IS
	SELECT user_name, feedback
	FROM review
	WHERE review_point >= 4;
BEGIN
  OPEN cur_rev_name;
  LOOP 
     FETCH cur_rev_name INTO v_name, v_desc;
     EXIT WHEN cur_rev_name%NOTFOUND;
		DBMS_OUTPUT.PUT_LINE('-----------------------------------------------------------------------');
		DBMS_OUTPUT.PUT_LINE('NAME' ||'                                                '||'FEEDBACK');
		DBMS_OUTPUT.PUT_LINE(v_name ||'                                                '||v_desc);
		DBMS_OUTPUT.PUT_LINE('-----------------------------------------------------------------------');
	END LOOP;
      CLOSE cur_rev_name;

END;
/
SHOW ERRORS;