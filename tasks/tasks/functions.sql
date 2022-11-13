//TO find the individual total expense.

CREATE OR REPLACE FUNCTION func_sum_total_amount(in_accommodation_id NUMBER)
RETURN NUMBER IS vn_individual_expense NUMBER(10);
BEGIN 
	SELECT SUM(c.total_amount)
	INTO vn_individual_expense
	FROM accommodation a, TABLE(a.cost)c
	WHERE accommodation_id = in_accommodation_id;

	RETURN vn_individual_expense;

END func_Sum_total_amount;
/
SHOW ERRORS;



CREATE OR REPLACE FUNCTION func_after_service(in_total_amount NUMBER)
RETURN NUMBER IS 
vn_after_service NUMBER(10);
BEGIN
    vn_after_service := in_total_amount + (0.5 * in_total_amount);
RETURN vn_after_service;
END func_after_service;
/
SHOW ERRORS;



CREATE OR REPLACE FUNCTION func_find_total_tax(in_total_amount NUMBER)
RETURN NUMBER IS 
vn_after_vat NUMBER(10);
vn_after_all NUMBER(10);
BEGIN
    vn_after_vat := in_total_amount +  (0.13 * in_total_amount);
    vn_after_all := func_after_service(vn_after_vat);
RETURN vn_after_all;
END func_find_total_tax;
/
SHOW ERRORS;



CREATE OR REPLACE FUNCTION func_avg_rating RETURN NUMBER IS
vn_avg NUMBER(5);
BEGIN 
	SELECT AVG(review_point)
	INTO vn_avg
	FROM review;
RETURN vn_avg;
END func_avg_rating;
/
SHOW ERRORS;