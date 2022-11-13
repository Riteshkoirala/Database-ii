--altering table accommoation_style for constraints
ALTER TABLE accommodation_style
	ADD CONSTRAINT PK_accommodation_style PRIMARY KEY (accommodation_style_id)
	MODIFY accommodation_type VARCHAR2(50) NOT NULL
	MODIFY description VARCHAR2(50) NOT NULL;



--altering table accommoation for constraints
ALTER TABLE accommodation
	ADD CONSTRAINT accommodation PRIMARY KEY (accommodation_id)
	MODIFY no_of_room NUMBER(10) NOT NULL
	ADD CONSTRAINT FK_accommodation
	FOREIGN KEY (accommodation_style_id) REFERENCES accommodation_style(accommodation_style_id);



--altering table retreat for constraints
ALTER TABLE retreat
	ADD CONSTRAINT PK_retreat PRIMARY KEY (retreat_id)
	MODIFY retreat_name VARCHAR2(50) NOT NULL
	MODIFY description VARCHAR2(50) NOT NULL;



--altering table setting for constraints
ALTER TABLE setting
	ADD CONSTRAINT PK_setting PRIMARY KEY (setting_id)
	MODIFY setting_name VARCHAR2(50) NOT NULL
	MODIFY description VARCHAR2(50) NOT NULL;



--altering table retreat_setting for constraints
ALTER TABLE retreat_setting
	ADD CONSTRAINT PK_retreat_setting PRIMARY KEY (retreat_setting_id)
	ADD CONSTRAINT FK_RetreatSetting
	FOREIGN KEY (retreat_id) REFERENCES retreat(retreat_id)
	ADD CONSTRAINT FK_SettingRetreat
	FOREIGN KEY (setting_id) REFERENCES setting(setting_id);



--altering table retreat_accommodation for constraints
ALTER TABLE retreat_accommodation
	ADD CONSTRAINT PK_retreat_accommodation PRIMARY KEY (retreat_accommodation_id)
	ADD CONSTRAINT FK_RetreatAccommodation
	FOREIGN KEY (retreat_id) REFERENCES retreat(retreat_id)
	ADD CONSTRAINT FK_AccommodationRetreat
	FOREIGN KEY (accommodation_id) REFERENCES accommodation(accommodation_id);



--altering table review for constraints
ALTER TABLE review
	ADD CONSTRAINT PK_review PRIMARY KEY (review_id)
	MODIFY user_name VARCHAR2(45) NOT NULL 
	MODIFY review_Point NUMBER(10) NOT NULL 
	ADD CONSTRAINT FK_review 
	FOREIGN KEY (retreat_setting_id) REFERENCES retreat_setting(retreat_setting_id)
	MODIFY feedback VARCHAR2(100) NOT NULL;