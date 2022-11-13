DROP TABLE retreat_accommodation;
DROP SEQUENCE seq_accommmodation_style_id;
DROP SEQUENCE seq_setting_id;
DROP SEQUENCE seq_retreat_id;
DROP SEQUENCE seq_main_id;


DROP TABLE accommodation;
DROP TABLE accommodation_style;
DROP TABLE review;
DROP TABLE retreat_setting;
DROP TABLE retreat;
Drop TABLE setting;
DROP TABLE addresses;

DROP TYPE  address_type;
DROP TYPE cost_varray_type;
DROP TYPE cost_type;
DROP TYPE scheme_table_type;
DROP TYPE scheme_type;

DROP FUNCTION func_sum_total_amount;
DROP FUNCTION func_after_service;
DROP FUNCTION func_find_total_tax;
DROP FUNCTION func_avg_rating;

DROP FUNCTION func_sum_total_amount;
DROP FUNCTION func_high_expense;
DROP FUNCTION func_high_expense_id;
DROP FUNCTION func_avg_rating;

DROP PROCEDURE proc_insert_converge;
DROP PROCEDURE proc_style_accommodation_insert;
DROP PROCEDURE proc_insert_review;
DROP PROCEDURE proc_insert_retreat_setting;
DROP PROCEDURE proc_insert_retreat;
DROP PROCEDURE proc_insert_setting;
DROP PROCEDURE proc_insert_addresses;

DROP PROCEDURE proc_avg_rating; 
DROP PROCEDURE proc_show_acco_style;
DROP PROCEDURE proc_retreat;
DROP PROCEDURE proc_retreat_setting;
DROP PROCEDURE proc_setting;
DROP PROCEDURE proc_retreat_accommodation;
DROP PROCEDURE proc_total_expense_func_user;
DROP PROCEDURE proc_find_amount;
DROP PROCEDURE proc_find_address;

DROP TRIGGER trigger_retreat_name;
DROP TRIGGER trigger_review_name;
DROP TRIGGER trigger_accomo_sty_name;
DROP TRIGGER trig_insertable_accommodation ;
DROP TRIGGER trig_insertable_rsetting;




