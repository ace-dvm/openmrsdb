--Consider changing the patient identifier from 10000X to a random number
--Consider changing the patient id numbers from starting with 191 to starting with whatever the first available ID is (probably 7)
--DEFINITELY check/change patient IDs if working on EPR97!!

/* under each subsection, there's code to add IrmaMaandag (copied literally from the database diffs),
and code to add IrmaDinsdag, which is the same patient but with a different name and patient ID (with notes about keys in other tables).*/

/* add patients */
INSERT INTO `person` VALUES(191,'F','1950-03-07',0,0,NULL,NULL,1,'2021-03-19 10:36:22',NULL,NULL,0,NULL,NULL,NULL,'7b935f6f-9a3c-44ff-8f00-8c5fa2815cf4',0,NULL);
INSERT INTO `patient` VALUES (191,1,'2021-03-19 10:36:22',NULL,NULL,0,NULL,NULL,NULL,'Unknown');
INSERT INTO `patient_identifier` VALUES (181,191,'10000X',3,1,6,1,'2021-03-19 10:36:23',NULL,NULL,0,NULL,NULL,NULL,'e059f230-4f7a-40a6-876c-6f7015c2c6fc');
INSERT INTO `person_address` VALUES (1,191,1,'Nieuwezijds Voorburgwal 147',NULL,'Amsterdam',NULL,'1012 RJ',NULL,NULL,NULL,NULL,NULL,1,'2021-03-19 10:36:23',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'65fcd794-a5f7-4324-991b-7db56e6dc16e',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `person_attribute` VALUES (1,191,'0687654321',8,1,'2021-03-19 10:36:23',NULL,NULL,0,NULL,NULL,NULL,'f34be185-c168-43a6-b296-08fec1590811');
INSERT INTO `person_name` VALUES (192,1,191,NULL,'IrmaMaandag',NULL,NULL,'Andriessen1',NULL,NULL,NULL,1,'2021-03-19 10:36:23',0,NULL,NULL,NULL,NULL,NULL,'21b82a41-3b0b-4536-9f2a-013c822d4828');

INSERT INTO `person` VALUES(192,'F','1950-03-07',0,0,NULL,NULL,1,'2021-03-19 10:36:22',NULL,NULL,0,NULL,NULL,NULL,(select UUID()),0,NULL);
INSERT INTO `patient` VALUES (192,1,'2021-03-19 10:36:22',NULL,NULL,0,NULL,NULL,NULL,'Unknown');
INSERT INTO `patient_identifier` (`patient_id`, `identifier`, `identifier_type`, `preferred`, `location_id`, `creator`, `date_created`, `date_changed`, `changed_by`, `voided`, `voided_by`, `date_voided`, `void_reason`, `uuid`) VALUES (192,'10000810001',3,1,6,1,'2021-03-19 10:36:23',NULL,NULL,0,NULL,NULL,NULL,(select UUID()));
INSERT INTO `person_address` (`person_id`, `preferred`, `address1`, `address2`, `city_village`, `state_province`, `postal_code`, `country`, `latitude`, `longitude`, `start_date`, `end_date`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `county_district`, `address3`, `address4`, `address5`, `address6`, `date_changed`, `changed_by`, `uuid`, `address7`, `address8`, `address9`, `address10`, `address11`, `address12`, `address13`, `address14`, `address15`) VALUES  (192,1,'Nieuwezijds Voorburgwal 147',NULL,'Amsterdam',NULL,'1012 RJ',NULL,NULL,NULL,NULL,NULL,1,'2021-03-19 10:36:23',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,(select UUID()),NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `person_attribute` (`person_id`, `value`, `person_attribute_type_id`, `creator`, `date_created`, `changed_by`, `date_changed`, `voided`, `voided_by`, `date_voided`, `void_reason`, `uuid`) VALUES (192,'0687654321',8,1,'2021-03-19 10:36:23',NULL,NULL,0,NULL,NULL,NULL,(select UUID()));
INSERT INTO `person_name` (`preferred`, `person_id`, `prefix`, `given_name`, `middle_name`, `family_name_prefix`, `family_name`, `family_name2`, `family_name_suffix`, `degree`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `changed_by`, `date_changed`, `uuid`) VALUES (1,192,NULL,'IrmaDinsdag',NULL,NULL,'Andriessen1',NULL,NULL,NULL,1,'2021-03-19 10:36:23',0,NULL,NULL,NULL,NULL,NULL,(select UUID()));

--IMPORTANT: After inserting new patients, rebuild the search index: Legacy page. Administration>Advance Adminstration. Check for Search Index under Maintenance item


/* add visits */
INSERT INTO `visit` (`patient_id`, `visit_type_id`, `date_started`, `date_stopped`, `indication_concept_id`, `location_id`, `creator`, `date_created`, `changed_by`, `date_changed`, `voided`, `voided_by`, `date_voided`, `void_reason`, `uuid`) VALUES (191,1,'2021-03-19 13:12:39',NULL,NULL,8,1,'2021-03-19 13:12:39',NULL,NULL,0,NULL,NULL,NULL,'d7225a06-d081-4214-bdc1-3990952dbbc8');

INSERT INTO `visit` (`patient_id`, `visit_type_id`, `date_started`, `date_stopped`, `indication_concept_id`, `location_id`, `creator`, `date_created`, `changed_by`, `date_changed`, `voided`, `voided_by`, `date_voided`, `void_reason`, `uuid`) VALUES (192,1,'2021-03-19 13:12:39',NULL,NULL,8,1,'2021-03-19 13:12:39',NULL,NULL,0,NULL,NULL,NULL, (select UUID()));

/* add diagnoses */
INSERT INTO `encounter` VALUES (4973,3,191,6,2,'2021-03-19 13:27:14',1,'2021-03-19 13:27:14',0,NULL,NULL,NULL,NULL,NULL,369,'410f6375-f53b-4ea0-b94c-d4f17f5ae36e');
INSERT INTO `encounter_provider` VALUES (366,4973,1,1,1,'2021-03-19 13:27:14',NULL,NULL,0,NULL,NULL,NULL,'398d4224-889a-4563-8e56-fda869ab793e');
INSERT INTO `obs` VALUES (7144,191,159947,4973,NULL,'2021-03-19 13:27:14',6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'2021-03-19 13:27:14',0,NULL,NULL,NULL,'5a6908d7-5d46-4988-b6d9-47a02ed473b5',NULL,NULL,'FINAL',NULL),(7145,191,1284,4973,NULL,'2021-03-19 13:27:14',6,7144,NULL,NULL,142473,42200,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'2021-03-19 13:27:14',0,NULL,NULL,NULL,'16a39a53-396a-46d7-b495-cc4f4378ceb1',NULL,NULL,'FINAL',NULL),(7146,191,159394,4973,NULL,'2021-03-19 13:27:14',6,7144,NULL,NULL,159393,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'2021-03-19 13:27:14',0,NULL,NULL,NULL,'17176e45-ae9e-4762-bfe8-3ebb33b2b75d',NULL,NULL,'FINAL',NULL),(7147,191,159946,4973,NULL,'2021-03-19 13:27:14',6,7144,NULL,NULL,159943,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'2021-03-19 13:27:14',0,NULL,NULL,NULL,'b0579199-e1f6-4bf1-9390-ca147d4813cd',NULL,NULL,'FINAL',NULL),(7148,191,159947,4973,NULL,'2021-03-19 13:27:14',6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'2021-03-19 13:27:14',0,NULL,NULL,NULL,'b84cf467-8da0-4170-a08c-d7b3239f955d',NULL,NULL,'FINAL',NULL),(7149,191,1284,4973,NULL,'2021-03-19 13:27:14',6,7148,NULL,NULL,140987,40735,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'2021-03-19 13:27:14',0,NULL,NULL,NULL,'35b051ca-af4c-47be-8b0d-1304aef4f10f',NULL,NULL,'FINAL',NULL),(7150,191,159946,4973,NULL,'2021-03-19 13:27:14',6,7148,NULL,NULL,159944,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'2021-03-19 13:27:14',0,NULL,NULL,NULL,'df0081a0-14fd-415d-9945-b9aae188ca9b',NULL,NULL,'FINAL',NULL),(7151,191,159394,4973,NULL,'2021-03-19 13:27:14',6,7148,NULL,NULL,159393,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'2021-03-19 13:27:14',0,NULL,NULL,NULL,'603315aa-e211-4980-abb0-eb8d7d0c2dbb',NULL,NULL,'FINAL',NULL),(7152,191,159947,4973,NULL,'2021-03-19 13:27:14',6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'2021-03-19 13:27:14',0,NULL,NULL,NULL,'cd6d712e-9cd9-42c3-9322-41c0eb4a9cf6',NULL,NULL,'FINAL',NULL),(7153,191,161602,4973,NULL,'2021-03-19 13:27:14',6,7152,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'chronic venous insufficiency',NULL,NULL,1,'2021-03-19 13:27:14',0,NULL,NULL,NULL,'78a283aa-14e9-4599-b326-28e5b711699f',NULL,NULL,'FINAL',NULL),(7154,191,159946,4973,NULL,'2021-03-19 13:27:14',6,7152,NULL,NULL,159944,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'2021-03-19 13:27:14',0,NULL,NULL,NULL,'a799af46-c3ee-4632-9a7d-aead65ff9b89',NULL,NULL,'FINAL',NULL),(7155,191,159394,4973,NULL,'2021-03-19 13:27:14',6,7152,NULL,NULL,159393,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'2021-03-19 13:27:14',0,NULL,NULL,NULL,'b32da71d-1d65-4b07-8d64-8c8ba3b6c87e',NULL,NULL,'FINAL',NULL),(7156,191,159947,4973,NULL,'2021-03-19 13:27:14',6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'2021-03-19 13:27:14',0,NULL,NULL,NULL,'cea900c9-e82a-4ea4-a648-722589d607fe',NULL,NULL,'FINAL',NULL),(7157,191,161602,4973,NULL,'2021-03-19 13:27:14',6,7156,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'gonarthrosis',NULL,NULL,1,'2021-03-19 13:27:14',0,NULL,NULL,NULL,'7736a776-3f3f-4824-86da-68103099a148',NULL,NULL,'FINAL',NULL),(7158,191,159946,4973,NULL,'2021-03-19 13:27:14',6,7156,NULL,NULL,159944,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'2021-03-19 13:27:14',0,NULL,NULL,NULL,'49be06a5-0ed5-464d-ada5-7e26c08cfb68',NULL,NULL,'FINAL',NULL),(7159,191,159394,4973,NULL,'2021-03-19 13:27:14',6,7156,NULL,NULL,159393,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'2021-03-19 13:27:14',0,NULL,NULL,NULL,'83e1bdad-6a75-489b-af9b-849be8732a5f',NULL,NULL,'FINAL',NULL);

-- note that this uses the visit_id set above (row inserted by INSERT INTO visit = 370)
INSERT INTO `encounter` (`encounter_type`, `patient_id`, `location_id`, `form_id`, `encounter_datetime`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `changed_by`, `date_changed`, `visit_id`, `uuid`) VALUES (3,192,6,2,'2021-03-19 13:27:14',1,'2021-03-19 13:27:14',0,NULL,NULL,NULL,NULL,NULL,370,(select uuid()));
-- note that this uses the encounter_id (row inserted by the line above)
INSERT INTO `encounter_provider` (`encounter_id`, `provider_id`, `encounter_role_id`, `creator`, `date_created`, `changed_by`, `date_changed`, `voided`, `date_voided`, `voided_by`, `void_reason`, `uuid`) VALUES (4981,1,1,1,'2021-03-19 13:27:14',NULL,NULL,0,NULL,NULL,NULL,(select uuid()));

-- note that each dx has 4 rows, and the obs_group_id for rows 2-4 are set to the obs_id of row 1.
-- encounter_id must match the encounter_id above
-- other values in these rows will depend on the IDs assigned to the diagnosis concepts.
INSERT INTO `obs` (`person_id`, `concept_id`, `encounter_id`, `order_id`, `obs_datetime`, `location_id`, `obs_group_id`,
`accession_number`, `value_group_id`, `value_coded`, `value_coded_name_id`, `value_drug`, `value_datetime`, `value_numeric`, `value_modifier`, `value_text`, 
`value_complex`, `comments`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `uuid`, `previous_version`, `form_namespace_and_path`, `status`, `interpretation`) VALUES 
(192,159947,4981,NULL,'2021-03-19 13:27:14',6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'2021-03-19 13:27:14',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
-- the first one inserts at 7186; we can use this to figure the obs_group_id for the rest

INSERT INTO `obs` (`person_id`, `concept_id`, `encounter_id`, `order_id`, `obs_datetime`, `location_id`, `obs_group_id`,
`accession_number`, `value_group_id`, `value_coded`, `value_coded_name_id`, `value_drug`, `value_datetime`, `value_numeric`, `value_modifier`, `value_text`, 
`value_complex`, `comments`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `uuid`, `previous_version`, `form_namespace_and_path`, `status`, `interpretation`) VALUES 
(192,1284,4981,NULL,'2021-03-19 13:27:14',6,7186,NULL,NULL,142473,42200,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'2021-03-19 13:27:14',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(192,159394,4981,NULL,'2021-03-19 13:27:14',6,7186,NULL,NULL,159393,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'2021-03-19 13:27:14',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(192,159946,4981,NULL,'2021-03-19 13:27:14',6,7186,NULL,NULL,159943,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'2021-03-19 13:27:14',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(192,159947,4981,NULL,'2021-03-19 13:27:14',6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'2021-03-19 13:27:14',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(192,1284,4981,NULL,'2021-03-19 13:27:14',6,7190,NULL,NULL,140987,40735,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'2021-03-19 13:27:14',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(192,159946,4981,NULL,'2021-03-19 13:27:14',6,7190,NULL,NULL,159944,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'2021-03-19 13:27:14',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(192,159394,4981,NULL,'2021-03-19 13:27:14',6,7190,NULL,NULL,159393,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'2021-03-19 13:27:14',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(192,159947,4981,NULL,'2021-03-19 13:27:14',6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'2021-03-19 13:27:14',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(192,161602,4981,NULL,'2021-03-19 13:27:14',6,7194,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'chronic venous insufficiency',NULL,NULL,1,'2021-03-19 13:27:14',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(192,159946,4981,NULL,'2021-03-19 13:27:14',6,7194,NULL,NULL,159944,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'2021-03-19 13:27:14',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(192,159394,4981,NULL,'2021-03-19 13:27:14',6,7194,NULL,NULL,159393,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'2021-03-19 13:27:14',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(192,159947,4981,NULL,'2021-03-19 13:27:14',6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'2021-03-19 13:27:14',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(192,161602,4981,NULL,'2021-03-19 13:27:14',6,7198,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'gonarthrosis',NULL,NULL,1,'2021-03-19 13:27:14',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(192,159946,4981,NULL,'2021-03-19 13:27:14',6,7198,NULL,NULL,159944,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'2021-03-19 13:27:14',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(192,159394,4981,NULL,'2021-03-19 13:27:14',6,7198,NULL,NULL,159393,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'2021-03-19 13:27:14',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL);

/* add meds: Each drug order creates an entry in each of the 4 tables. */
-- one drug order
INSERT INTO `encounter` VALUES (4974,8,191,NULL,NULL,'2021-03-19 13:32:04',1,'2021-03-19 13:32:04',0,NULL,NULL,NULL,NULL,NULL,NULL,'cee7763e-a919-44b7-888b-5646d799eb3a');
INSERT INTO `encounter_provider` VALUES (367,4974,1,2,1,'2021-03-19 13:32:04',NULL,NULL,0,NULL,NULL,NULL,'8817ddfb-7cb3-4b5f-9c2b-0392a5658423');
INSERT INTO `orders` VALUES (30071,2,165483,1,4974,NULL,'2021-03-19 13:32:04','2022-03-19 13:32:03',NULL,NULL,NULL,1,'2021-03-19 13:32:04',0,NULL,NULL,NULL,191,NULL,'75b18286-2abd-4266-a10a-19812c77076a','ROUTINE','ORD-1',NULL,'NEW',NULL,1,NULL,NULL,NULL);
INSERT INTO `drug_order` VALUES (30071,4,1000,0,'org.openmrs.SimpleDosingInstructions',180,NULL,0,NULL,1,1734,1513,160240,161553,11,NULL,0,NULL);

-- mor drug orders
INSERT INTO `encounter` VALUES (4975,8,191,NULL,NULL,'2021-03-19 13:38:24',1,'2021-03-19 13:38:25',0,NULL,NULL,NULL,NULL,NULL,NULL,'8a93faf7-458a-4c63-9a5a-8f3826b3e5ac'),(4976,8,191,NULL,NULL,'2021-03-19 13:41:52',1,'2021-03-19 13:41:52',0,NULL,NULL,NULL,NULL,NULL,NULL,'ad1c8a91-faeb-4101-98f4-f1db64b2943d');
INSERT INTO `encounter_provider` VALUES (368,4975,1,2,1,'2021-03-19 13:38:25',NULL,NULL,0,NULL,NULL,NULL,'dc22275b-3459-4f15-abbf-888c3f8b8433'),(369,4976,1,2,1,'2021-03-19 13:41:52',NULL,NULL,0,NULL,NULL,NULL,'963e07de-a831-4c9e-acd7-6e2e2905c063');
INSERT INTO `orders` VALUES (30072,2,166329,1,4975,NULL,'2021-03-19 13:38:25','2022-03-19 13:38:24',NULL,NULL,NULL,1,'2021-03-19 13:38:25',0,NULL,NULL,NULL,191,NULL,'ee34598f-ad72-4403-9271-24a375027064','ROUTINE','ORD-2',NULL,'NEW',NULL,1,NULL,NULL,NULL),(30073,2,167867,1,4976,NULL,'2021-03-19 13:41:52','2022-03-19 13:41:51',NULL,NULL,NULL,1,'2021-03-19 13:41:52',0,NULL,NULL,NULL,191,NULL,'7797fc76-dc44-4254-afb3-83c14422c333','ROUTINE','ORD-3',NULL,'NEW',NULL,1,NULL,NULL,NULL),(30074,2,166394,1,4976,NULL,'2021-03-19 13:41:52','2022-03-19 13:41:51',NULL,NULL,NULL,1,'2021-03-19 13:41:52',0,NULL,NULL,NULL,191,NULL,'3a4d2bca-7412-4509-8bc2-9951d1c1893e','ROUTINE','ORD-4',NULL,'NEW',NULL,1,NULL,NULL,NULL);
INSERT INTO `drug_order` VALUES (30072,133,5,0,'org.openmrs.SimpleDosingInstructions',90,NULL,0,NULL,1,1734,1513,160240,161553,16,NULL,0,NULL),(30073,159,50,0,'org.openmrs.SimpleDosingInstructions',260,'pain',0,'zo nodig tot 3dd 50mg bij pijn',1,1734,1513,160240,161553,20,NULL,0,NULL),(30074,139,40,0,'org.openmrs.SimpleDosingInstructions',90,NULL,0,NULL,1,1734,1513,160240,161553,16,NULL,0,NULL);

-- see notes above re: encounters and dependency on other tables
INSERT INTO `encounter` (`encounter_type`, `patient_id`, `location_id`, `form_id`, `encounter_datetime`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `changed_by`, `date_changed`, `visit_id`, `uuid`) VALUES  (8,192,NULL,NULL,'2021-03-19 13:32:04',1,'2021-03-19 13:32:04',0,NULL,NULL,NULL,NULL,NULL,NULL,(select UUID()));
INSERT INTO `encounter_provider` (`encounter_id`, `provider_id`, `encounter_role_id`, `creator`, `date_created`, `changed_by`, `date_changed`, `voided`, `date_voided`, `voided_by`, `void_reason`, `uuid`) VALUES  (4982,1,2,1,'2021-03-19 13:32:04',NULL,NULL,0,NULL,NULL,NULL,(select uuid()));
-- order uses encounter_id
INSERT INTO `orders` (`order_type_id`, `concept_id`, `orderer`, `encounter_id`, `instructions`, `date_activated`, `auto_expire_date`, `date_stopped`, `order_reason`, `order_reason_non_coded`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `patient_id`, `accession_number`, `uuid`, `urgency`, `order_number`, `previous_order_id`, `order_action`, `comment_to_fulfiller`, `care_setting`, `scheduled_date`, `order_group_id`, `sort_weight`) VALUES (2,165483,1,4982,NULL,'2021-03-19 13:32:04','2022-03-19 13:32:03',NULL,NULL,NULL,1,'2021-03-19 13:32:04',0,NULL,NULL,NULL,192,NULL,(select uuid()),'ROUTINE','ORD-1',NULL,'NEW',NULL,1,NULL,NULL,NULL);
-- uses order_id from orders
INSERT INTO `drug_order` (`order_id`, `drug_inventory_id`, `dose`, `as_needed`, `dosing_type`, `quantity`, `as_needed_condition`, `num_refills`, `dosing_instructions`, `duration`, `duration_units`, `quantity_units`, `route`, `dose_units`, `frequency`, `brand_name`, `dispense_as_written`, `drug_non_coded`) VALUES  (30075,4,1000,0,'org.openmrs.SimpleDosingInstructions',180,NULL,0,NULL,1,1734,1513,160240,161553,11,NULL,0,NULL);

-- orders that are signed together share an encounter and encounter-provider
INSERT INTO `encounter` (`encounter_type`, `patient_id`, `location_id`, `form_id`, `encounter_datetime`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `changed_by`, `date_changed`, `visit_id`, `uuid`) VALUES
(8,192,NULL,NULL,'2021-03-19 13:38:24',1,'2021-03-19 13:38:25',0,NULL,NULL,NULL,NULL,NULL,NULL,(select uuid())),
(8,192,NULL,NULL,'2021-03-19 13:41:52',1,'2021-03-19 13:41:52',0,NULL,NULL,NULL,NULL,NULL,NULL,(select uuid()));
INSERT INTO `encounter_provider` (`encounter_id`, `provider_id`, `encounter_role_id`, `creator`, `date_created`, `changed_by`, `date_changed`, `voided`, `date_voided`, `voided_by`, `void_reason`, `uuid`) VALUES 
(4983,1,2,1,'2021-03-19 13:38:25',NULL,NULL,0,NULL,NULL,NULL,(select uuid())),
(4984,1,2,1,'2021-03-19 13:41:52',NULL,NULL,0,NULL,NULL,NULL,(select uuid()));
-- note that subsequent orders for this patient are getting a sequential order number (ord-1 for the first one, now ord-2, ord-3, and ord-4)
-- the last two orders were signed together and thus share an encounter_id
INSERT INTO `orders` (`order_type_id`, `concept_id`, `orderer`, `encounter_id`, `instructions`, `date_activated`, `auto_expire_date`, `date_stopped`, `order_reason`, `order_reason_non_coded`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `patient_id`, `accession_number`, `uuid`, `urgency`, `order_number`, `previous_order_id`, `order_action`, `comment_to_fulfiller`, `care_setting`, `scheduled_date`, `order_group_id`, `sort_weight`) VALUES 
(2,166329,1,4983,NULL,'2021-03-19 13:38:25','2022-03-19 13:38:24',NULL,NULL,NULL,1,'2021-03-19 13:38:25',0,NULL,NULL,NULL,192,NULL,(select uuid()),'ROUTINE','ORD-2',NULL,'NEW',NULL,1,NULL,NULL,NULL),
(2,167867,1,4984,NULL,'2021-03-19 13:41:52','2022-03-19 13:41:51',NULL,NULL,NULL,1,'2021-03-19 13:41:52',0,NULL,NULL,NULL,192,NULL,(select uuid()),'ROUTINE','ORD-3',NULL,'NEW',NULL,1,NULL,NULL,NULL),
(2,166394,1,4984,NULL,'2021-03-19 13:41:52','2022-03-19 13:41:51',NULL,NULL,NULL,1,'2021-03-19 13:41:52',0,NULL,NULL,NULL,192,NULL,(select uuid()),'ROUTINE','ORD-4',NULL,'NEW',NULL,1,NULL,NULL,NULL);
INSERT INTO `drug_order` (`order_id`, `drug_inventory_id`, `dose`, `as_needed`, `dosing_type`, `quantity`, `as_needed_condition`, `num_refills`, `dosing_instructions`, `duration`, `duration_units`, `quantity_units`, `route`, `dose_units`, `frequency`, `brand_name`, `dispense_as_written`, `drug_non_coded`) VALUES 
(30076,133,5,0,'org.openmrs.SimpleDosingInstructions',90,NULL,0,NULL,1,1734,1513,160240,161553,16,NULL,0,NULL),
(30077,159,50,0,'org.openmrs.SimpleDosingInstructions',260,'pain',0,'zo nodig tot 3dd 50mg bij pijn',1,1734,1513,160240,161553,20,NULL,0,NULL),
(30078,139,40,0,'org.openmrs.SimpleDosingInstructions',90,NULL,0,NULL,1,1734,1513,160240,161553,16,NULL,0,NULL);

/* add allergy */
INSERT INTO `allergy` VALUES (1,191,1498,5622,'Bruine pleister','OTHER','',1,'2021-03-19 13:45:14',NULL,NULL,0,NULL,NULL,NULL,'9f8a3ece-dbbf-4903-a382-20d7a26c93d2');
UPDATE patient SET allergy_status = 'See list' where patient_id = 191;

INSERT INTO `allergy` (`patient_id`, `severity_concept_id`, `coded_allergen`, `non_coded_allergen`, `allergen_type`, `comment`, `creator`, `date_created`, `changed_by`, `date_changed`, `voided`, `voided_by`, `date_voided`, `void_reason`, `uuid`) VALUES  (192,1498,5622,'Bruine pleister','OTHER','',1,'2021-03-19 13:45:14',NULL,NULL,0,NULL,NULL,NULL,(select uuid()));
UPDATE patient SET allergy_status = 'See list' where patient_id = 192;

/* add visit note */
INSERT INTO `obs` VALUES (7160,191,162169,4973,NULL,'2021-03-19 13:27:14',6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Afgelopen week gemerkt dat er een rode plek op het linker onderbeen ontstond. Deed geen pijn, geen koorts. Op vrijdag wel duidelijk pijnlijk en koorts gehad. Dit heeft zij niet gemeten, maar zij weet het altijd zeker als zij koorts heeft. Geen koude rillingen. Door huisarts is antibiotica voorgeschreven, zij weet niet goed welke, maar neemt het vier keer per dag.\r\n\r\nOp zondag (vandaag) was de roodheid weer erger geworden en had zij nog steeds het gevoel koorts te hebben en is zij via HAP naar SEH gekomen.\r\n-- Dr. A',NULL,NULL,1,'2021-03-19 13:47:59',1,1,'2021-03-19 13:49:39','REST web service','ad3854c6-f6e6-4618-aeee-7bc4c00f749f',NULL,NULL,'FINAL',NULL),(7161,191,162169,4973,NULL,'2021-03-19 13:49:39',6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Afgelopen week gemerkt dat er een rode plek op het linker onderbeen ontstond. Deed geen pijn, geen koorts. Op vrijdag wel duidelijk pijnlijk en koorts gehad. Dit heeft zij niet gemeten, maar zij weet het altijd zeker als zij koorts heeft. Geen koude rillingen. Door huisarts is antibiotica voorgeschreven, zij weet niet goed welke, maar neemt het vier keer per dag.\n\nOp zondag (vandaag) was de roodheid weer erger geworden en had zij nog steeds het gevoel koorts te hebben en is zij via HAP naar SEH gekomen.\n\nTractus anamnese: behoudens braken na maaltijd sinds vandaag geen bijzonderheden.\n-- Dr. A',NULL,NULL,1,'2021-03-19 13:49:39',0,NULL,NULL,NULL,'bd1d1839-15c0-4b1f-988c-9c663e83a76e',7160,NULL,'AMENDED',NULL);

-- I edited the visit note for IrmaMaandag; we can merge those changes for IrmaDinsdag
-- uses encounter_id from the encounter where diagnoses were added (encounter_type = 3)
INSERT INTO `obs` (`person_id`, `concept_id`, `encounter_id`, `order_id`, `obs_datetime`, `location_id`, `obs_group_id`,`accession_number`, `value_group_id`, `value_coded`, `value_coded_name_id`, `value_drug`, `value_datetime`, `value_numeric`, `value_modifier`, `value_text`, `value_complex`, `comments`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `uuid`, `previous_version`, `form_namespace_and_path`, `status`, `interpretation`) VALUES 
(192,162169,4981,NULL,'2021-03-19 13:27:14',6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Afgelopen week gemerkt dat er een rode plek op het linker onderbeen ontstond. Deed geen pijn, geen koorts. Op vrijdag wel duidelijk pijnlijk en koorts gehad. Dit heeft zij niet gemeten, maar zij weet het altijd zeker als zij koorts heeft. Geen koude rillingen. Door huisarts is antibiotica voorgeschreven, zij weet niet goed welke, maar neemt het vier keer per dag.\n\nOp zondag (vandaag) was de roodheid weer erger geworden en had zij nog steeds het gevoel koorts te hebben en is zij via HAP naar SEH gekomen.\n\nTractus anamnese: behoudens braken na maaltijd sinds vandaag geen bijzonderheden.\n-- Dr. A',NULL,NULL,1,'2021-03-19 13:47:59',1,1,'2021-03-19 13:49:39','REST web service',(select uuid()),NULL,NULL,'FINAL',NULL);

/* admit patient as inpatient */
INSERT INTO `encounter` VALUES (4977,2,191,6,3,'2021-03-19 14:00:05',1,'2021-03-19 14:00:05',0,NULL,NULL,NULL,NULL,NULL,369,'853a09f8-909b-4fd2-b92d-e0a86eac5aa7');
INSERT INTO `encounter_provider` VALUES (370,4977,1,1,1,'2021-03-19 14:00:05',NULL,NULL,0,NULL,NULL,NULL,'0d689f52-f01f-4cbe-a5d2-c762f8b3bceb');

-- uses visit_id
INSERT INTO `encounter` (`encounter_type`, `patient_id`, `location_id`, `form_id`, `encounter_datetime`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `changed_by`, `date_changed`, `visit_id`, `uuid`) VALUES
(2,192,6,3,'2021-03-19 14:00:05',1,'2021-03-19 14:00:05',0,NULL,NULL,NULL,NULL,NULL,370,(select uuid()));
-- uses encounter_id from above
INSERT INTO `encounter_provider` (`encounter_id`, `provider_id`, `encounter_role_id`, `creator`, `date_created`, `changed_by`, `date_changed`, `voided`, `date_voided`, `voided_by`, `void_reason`, `uuid`) VALUES 
(4985,1,1,1,'2021-03-19 14:00:05',NULL,NULL,0,NULL,NULL,NULL,(select uuid()));

/* add vitals */
INSERT INTO `encounter` VALUES (4978,7,191,6,1,'2021-03-19 14:21:31',1,'2021-03-19 14:21:31',0,NULL,NULL,NULL,NULL,NULL,369,'fe024124-62ef-4d10-b4ec-59f815caa08f');
INSERT INTO `encounter_provider` VALUES (371,4978,1,2,1,'2021-03-19 14:21:31',NULL,NULL,0,NULL,NULL,NULL,'e9acbc9c-9345-41b0-809e-1dc7ec156c9a');
INSERT INTO `obs` VALUES (7162,191,5088,4978,NULL,'2021-03-19 14:21:31',6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,37.9,NULL,NULL,NULL,NULL,1,'2021-03-19 14:21:31',0,NULL,NULL,NULL,'92ad75e1-6e99-4dfe-9e36-b6013a459435',NULL,NULL,'FINAL',NULL),(7163,191,5087,4978,NULL,'2021-03-19 14:21:31',6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,90,NULL,NULL,NULL,NULL,1,'2021-03-19 14:21:31',0,NULL,NULL,NULL,'1e745ce5-dd23-44b6-a39f-c6af3c6ec282',NULL,NULL,'FINAL',NULL),(7164,191,5242,4978,NULL,'2021-03-19 14:21:31',6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,9,NULL,NULL,NULL,NULL,1,'2021-03-19 14:21:31',0,NULL,NULL,NULL,'9f6add94-482d-4a42-b8e6-0e6e8644d113',NULL,NULL,'FINAL',NULL),(7165,191,5085,4978,NULL,'2021-03-19 14:21:31',6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,125,NULL,NULL,NULL,NULL,1,'2021-03-19 14:21:31',0,NULL,NULL,NULL,'ef98e32e-168c-48a0-b96d-94ba8b8d2163',NULL,NULL,'FINAL',NULL),(7166,191,5086,4978,NULL,'2021-03-19 14:21:31',6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,85,NULL,NULL,NULL,NULL,1,'2021-03-19 14:21:31',0,NULL,NULL,NULL,'05cc8ada-5a2c-41dd-9335-d7cbbfd245df',NULL,NULL,'FINAL',NULL),(7167,191,5092,4978,NULL,'2021-03-19 14:21:31',6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,98,NULL,NULL,NULL,NULL,1,'2021-03-19 14:21:31',0,NULL,NULL,NULL,'bc9eceb6-174a-49a0-8afa-c550ba823669',NULL,NULL,'FINAL',NULL);

--uses visit_id
INSERT INTO `encounter` (`encounter_type`, `patient_id`, `location_id`, `form_id`, `encounter_datetime`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `changed_by`, `date_changed`, `visit_id`, `uuid`) VALUES
(7,192,6,1,'2021-03-19 14:21:31',1,'2021-03-19 14:21:31',0,NULL,NULL,NULL,NULL,NULL,370,(select uuid()));
-- uses encounter_id from above
INSERT INTO `encounter_provider` (`encounter_id`, `provider_id`, `encounter_role_id`, `creator`, `date_created`, `changed_by`, `date_changed`, `voided`, `date_voided`, `voided_by`, `void_reason`, `uuid`) VALUES 
(4986,1,2,1,'2021-03-19 14:21:31',NULL,NULL,0,NULL,NULL,NULL,(select uuid()));
-- uses encounter_id from above. each vital meas gets an obs entry
INSERT INTO `obs` (`person_id`, `concept_id`, `encounter_id`, `order_id`, `obs_datetime`, `location_id`, `obs_group_id`,`accession_number`, `value_group_id`, `value_coded`, `value_coded_name_id`, `value_drug`, `value_datetime`, `value_numeric`, `value_modifier`, `value_text`, `value_complex`, `comments`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `uuid`, `previous_version`, `form_namespace_and_path`, `status`, `interpretation`) VALUES 
(192,5088,4986,NULL,'2021-03-19 14:21:31',6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,37.9,NULL,NULL,NULL,NULL,1,'2021-03-19 14:21:31',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(192,5087,4986,NULL,'2021-03-19 14:21:31',6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,90,NULL,NULL,NULL,NULL,1,'2021-03-19 14:21:31',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(192,5242,4986,NULL,'2021-03-19 14:21:31',6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,9,NULL,NULL,NULL,NULL,1,'2021-03-19 14:21:31',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(192,5085,4986,NULL,'2021-03-19 14:21:31',6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,125,NULL,NULL,NULL,NULL,1,'2021-03-19 14:21:31',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(192,5086,4986,NULL,'2021-03-19 14:21:31',6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,85,NULL,NULL,NULL,NULL,1,'2021-03-19 14:21:31',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(192,5092,4986,NULL,'2021-03-19 14:21:31',6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,98,NULL,NULL,NULL,NULL,1,'2021-03-19 14:21:31',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL);

/* add 2nd visit note */
INSERT INTO `encounter` VALUES (4979,3,191,6,2,'2021-03-19 14:38:15',1,'2021-03-19 14:38:15',0,NULL,NULL,NULL,NULL,NULL,369,'aba4e443-2a35-4b4b-a8df-2a602b7b377b');
INSERT INTO `encounter_provider` VALUES (372,4979,1,1,1,'2021-03-19 14:38:15',NULL,NULL,0,NULL,NULL,NULL,'4a96d78d-2e3b-42d1-850a-fa27d7fa071a');
INSERT INTO `obs` VALUES (7168,191,159947,4979,NULL,'2021-03-19 14:38:15',6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'2021-03-19 14:38:15',0,NULL,NULL,NULL,'2915645d-85e3-404b-bfa2-c20a83b5c854',NULL,NULL,'FINAL',NULL),(7169,191,159946,4979,NULL,'2021-03-19 14:38:15',6,7168,NULL,NULL,159943,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'2021-03-19 14:38:15',0,NULL,NULL,NULL,'6407dc98-9a7c-4cab-a7c8-1688d98b8985',NULL,NULL,'FINAL',NULL),(7170,191,161602,4979,NULL,'2021-03-19 14:38:15',6,7168,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'cellulitis',NULL,NULL,1,'2021-03-19 14:38:15',0,NULL,NULL,NULL,'01a33bb8-9890-4fc5-a03b-750507d46192',NULL,NULL,'FINAL',NULL),(7171,191,159394,4979,NULL,'2021-03-19 14:38:15',6,7168,NULL,NULL,159393,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'2021-03-19 14:38:15',0,NULL,NULL,NULL,'6bac03cf-fbcb-49f2-b5c8-55f1618b9626',NULL,NULL,'FINAL',NULL),(7172,191,162169,4979,NULL,'2021-03-19 14:38:15',6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Algemene indruk: helder, niet acuut zieke patiënt\r\n\r\nH/H: geen lymfadenopathie, in de mond geen afwijkingen\r\n\r\nCor: normale harttonen, geen souffle\r\n\r\nPulm: normaal doorkomend ademgeruis, geen bijgeluiden\r\n\r\nAbd: normale peristaltiek, wisselende tympani, soepel, geen drukpijn, geen weerstanden\r\n\r\nExtr: rechts normaal warm, met pitting oedeem rondom de enkel, links mediaal van enkel tot knie duidelijke roodheid met induratie, warm, pijnlijk, kuit nog wel soepel\r\n- Dr. A',NULL,NULL,1,'2021-03-19 14:38:15',0,NULL,NULL,NULL,'367277da-a402-4fc2-81f3-b18faaca3e12',NULL,NULL,'FINAL',NULL);

--uses visit_id
INSERT INTO `encounter` (`encounter_type`, `patient_id`, `location_id`, `form_id`, `encounter_datetime`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `changed_by`, `date_changed`, `visit_id`, `uuid`) VALUES
(3,192,6,2,'2021-03-19 14:38:15',1,'2021-03-19 14:38:15',0,NULL,NULL,NULL,NULL,NULL,370,(select uuid()));
-- uses encounter_id from above
INSERT INTO `encounter_provider` (`encounter_id`, `provider_id`, `encounter_role_id`, `creator`, `date_created`, `changed_by`, `date_changed`, `voided`, `date_voided`, `voided_by`, `void_reason`, `uuid`) VALUES 
(4987,1,1,1,'2021-03-19 14:38:15',NULL,NULL,0,NULL,NULL,NULL,(select uuid()));
-- uses encounter_id from above
-- the visit note requires that a diagnosis be entered to associate with the note, hence the extra obs
INSERT INTO `obs` (`person_id`, `concept_id`, `encounter_id`, `order_id`, `obs_datetime`, `location_id`, `obs_group_id`,`accession_number`, `value_group_id`, `value_coded`, `value_coded_name_id`, `value_drug`, `value_datetime`, `value_numeric`, `value_modifier`, `value_text`, `value_complex`, `comments`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `uuid`, `previous_version`, `form_namespace_and_path`, `status`, `interpretation`) VALUES 
(192,159947,4987,NULL,'2021-03-19 14:38:15',6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'2021-03-19 14:38:15',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(192,159946,4987,NULL,'2021-03-19 14:38:15',6,7168,NULL,NULL,159943,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'2021-03-19 14:38:15',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(192,161602,4987,NULL,'2021-03-19 14:38:15',6,7168,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'cellulitis',NULL,NULL,1,'2021-03-19 14:38:15',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(192,159394,4987,NULL,'2021-03-19 14:38:15',6,7168,NULL,NULL,159393,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'2021-03-19 14:38:15',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(192,162169,4987,NULL,'2021-03-19 14:38:15',6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Algemene indruk: helder, niet acuut zieke patiënt\r\n\r\nH/H: geen lymfadenopathie, in de mond geen afwijkingen\r\n\r\nCor: normale harttonen, geen souffle\r\n\r\nPulm: normaal doorkomend ademgeruis, geen bijgeluiden\r\n\r\nAbd: normale peristaltiek, wisselende tympani, soepel, geen drukpijn, geen weerstanden\r\n\r\nExtr: rechts normaal warm, met pitting oedeem rondom de enkel, links mediaal van enkel tot knie duidelijke roodheid met induratie, warm, pijnlijk, kuit nog wel soepel\r\n- Dr. A',NULL,NULL,1,'2021-03-19 14:38:15',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL);

