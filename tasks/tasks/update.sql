UPDATE accommodation_style
SET accommodation_type = 'Balcony',
description = 'Give the beautiful view of sea'
WHERE accommodation_style_id = 1;

UPDATE retreat
SET retreat_name = 'Healthy',
description = 'Give you more life span'
WHERE retreat_id = 1;

UPDATE setting
SET setting_name = 'sea',
description = 'Stay above the water'
WHERE setting_id = 1;

UPDATE review
SET user_name = 'Deva',
review_point = 4,
feedback = 'Very nice hospitality'
WHERE review_id = 3;

UPDATE retreat_accommodation r
SET r.scheme = scheme_table_type(scheme_type('Mahadev', 'Not done till now'))
WHERE r.retreat_accommodation_id = 2;

UPDATE accommodation a
SET no_of_room = 7,
a.cost = cost_varray_type(cost_type(100000, 5000, 95000))
WHERE accommodation_id = 1;

