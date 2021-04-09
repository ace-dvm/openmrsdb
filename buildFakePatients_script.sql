-- IMPORTANT: After inserting new patients, rebuild the search index: Legacy page. Administration>Advance Adminstration. Check for Search Index under Maintenance item
-- probably want to set this externally with a script
SET @STUDENT_ID := 1;
SET @CLASS_DATE := '2021-03-19';
SET @CLASS_DATE2 := '2021-03-20';
SET @CLASS_DATE3 := '2021-03-21';
SET @CLASS_DATE1Y := '2022-03-19'; -- These are strings. Could convert them to dates and do math, but this seems easier.

/* TODO add attachments */

/* IRMA ANDRIESSEN
This will build one complete instance of Irma.
The script assumes you're running the whole thing at once. Variables might not be set correctly if it's not executed as a whole.

/************************ MAANDAG *************************/
SET @DAY_OF_WEEK := 'Maandag';
SET @CURRENT_PATIENT_IDENTIFIER := 77777700001; -- Arbitrary prefix of six 7's.
SET @ORDCOUNT := 0; -- first order is always ORD-1, second is ORD-2, etc.

SELECT max(person_id)+1 INTO @CURRENT_PATIENT_ID from person;

/* add patient */
INSERT INTO `person` VALUES(@CURRENT_PATIENT_ID,'F','1950-03-07',0,0,NULL,NULL,1,'2021-03-19 10:36:22',NULL,NULL,0,NULL,NULL,NULL,(select UUID()),0,NULL);
INSERT INTO `patient` VALUES (@CURRENT_PATIENT_ID,1,'2021-03-19 10:36:22',NULL,NULL,0,NULL,NULL,NULL,'Unknown');
INSERT INTO `patient_identifier` (`patient_id`, `identifier`, `identifier_type`, `preferred`, `location_id`, `creator`, `date_created`, `date_changed`, `changed_by`, `voided`, `voided_by`, `date_voided`, `void_reason`, `uuid`) VALUES 
(@CURRENT_PATIENT_ID,@CURRENT_PATIENT_IDENTIFIER,3,1,6,1,'2021-03-19 10:36:23',NULL,NULL,0,NULL,NULL,NULL,(select UUID()));

INSERT INTO `person_address` (`person_id`, `preferred`, `address1`, `address2`, `city_village`, `state_province`, `postal_code`, `country`, `latitude`, `longitude`, `start_date`, `end_date`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `county_district`, `address3`, `address4`, `address5`, `address6`, `date_changed`, `changed_by`, `uuid`, `address7`, `address8`, `address9`, `address10`, `address11`, `address12`, `address13`, `address14`, `address15`) VALUES  
(@CURRENT_PATIENT_ID,1,'Nieuwezijds Voorburgwal 147',NULL,'Amsterdam',NULL,'1012 RJ',NULL,NULL,NULL,NULL,NULL,1,'2021-03-19 10:36:23',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,(select UUID()),NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `person_attribute` (`person_id`, `value`, `person_attribute_type_id`, `creator`, `date_created`, `changed_by`, `date_changed`, `voided`, `voided_by`, `date_voided`, `void_reason`, `uuid`) VALUES 
(@CURRENT_PATIENT_ID,'0687654321',8,1,'2021-03-19 10:36:23',NULL,NULL,0,NULL,NULL,NULL,(select UUID()));
INSERT INTO `person_name` (`preferred`, `person_id`, `prefix`, `given_name`, `middle_name`, `family_name_prefix`, `family_name`, `family_name2`, `family_name_suffix`, `degree`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `changed_by`, `date_changed`, `uuid`) VALUES 
(1,@CURRENT_PATIENT_ID,NULL,CONCAT('Irma',@DAY_OF_WEEK),NULL,NULL,CONCAT('Andriessen',@STUDENT_ID),NULL,NULL,NULL,1,'2021-03-19 10:36:23',0,NULL,NULL,NULL,NULL,NULL,(select UUID()));

/* add visit */
SELECT max(visit_id)+1 INTO @CURRENT_VISIT_ID from visit;
INSERT INTO `visit` (`visit_id`,`patient_id`, `visit_type_id`, `date_started`, `date_stopped`, `indication_concept_id`, `location_id`, `creator`, `date_created`, `changed_by`, `date_changed`, `voided`, `voided_by`, `date_voided`, `void_reason`, `uuid`) VALUES 
(@CURRENT_VISIT_ID, @CURRENT_PATIENT_ID,1,CONCAT(@CLASS_DATE,' 13:12:39'),NULL,NULL,8,1,'2021-03-19 13:12:39',NULL,NULL,0,NULL,NULL,NULL, (select UUID()));

/* add visit diagnosis */
SELECT max(encounter_id)+1 INTO @CURRENT_ENC_ID from encounter;
INSERT INTO `encounter` (`encounter_id`, `encounter_type`, `patient_id`, `location_id`, `form_id`, `encounter_datetime`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `changed_by`, `date_changed`, `visit_id`, `uuid`) VALUES  
(@CURRENT_ENC_ID,8,@CURRENT_PATIENT_ID,NULL,NULL,CONCAT(@CLASS_DATE,' 13:27:14'),1,'2021-03-19 13:27:14',0,NULL,NULL,NULL,NULL,NULL,NULL,(select UUID()));
INSERT INTO `encounter_provider` (`encounter_id`, `provider_id`, `encounter_role_id`, `creator`, `date_created`, `changed_by`, `date_changed`, `voided`, `date_voided`, `voided_by`, `void_reason`, `uuid`) VALUES  
(@CURRENT_ENC_ID,1,2,1,'2021-03-19 13:27:14',NULL,NULL,0,NULL,NULL,NULL,(select uuid()));
-- note that each dx has 4 rows, and the obs_group_id for rows 2-4 are set to the obs_id of row 1.
-- encounter_id must match the encounter_id above
-- other values in these rows will depend on the IDs assigned to the diagnosis concepts.
SELECT max(obs_id)+1 INTO @CURRENT_OBS_ID from obs;
INSERT INTO `obs` (`person_id`, `concept_id`, `encounter_id`, `order_id`, `obs_datetime`, `location_id`, `obs_group_id`,
`accession_number`, `value_group_id`, `value_coded`, `value_coded_name_id`, `value_drug`, `value_datetime`, `value_numeric`, `value_modifier`, `value_text`, 
`value_complex`, `comments`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `uuid`, `previous_version`, `form_namespace_and_path`, `status`, `interpretation`) VALUES 
(@CURRENT_PATIENT_ID,159947,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE,' 13:27:14'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'2021-03-19 13:27:14',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_PATIENT_ID,159946,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE,' 13:27:14'),6,@CURRENT_OBS_ID,NULL,NULL,159943,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'2021-03-19 13:27:14',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_PATIENT_ID,159394,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE,' 13:27:14'),6,@CURRENT_OBS_ID,NULL,NULL,159393,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'2021-03-19 13:27:14',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_PATIENT_ID,1284,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE,' 13:27:14'),6,@CURRENT_OBS_ID,NULL,NULL,142473,42200,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'2021-03-19 13:27:14',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL);

/* add conditions */
INSERT INTO `conditions` (`previous_condition_id`, `patient_id`, `status`, `concept_id`, `condition_non_coded`, `onset_date`, `additional_detail`, `end_date`, `end_reason`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `uuid`) VALUES
(NULL,@CURRENT_PATIENT_ID,'ACTIVE',142473,'',NULL,'',NULL,NULL,1,'2021-03-26 17:00:21',0,NULL,NULL,NULL,(select uuid())),
(NULL,@CURRENT_PATIENT_ID,'ACTIVE',117399,'',NULL,'',NULL,NULL,1,'2021-03-26 17:02:04',0,NULL,NULL,NULL,(select uuid()));
/* TODO add
Chronische veneuze insufficiëntie 
Gonartrose 
*/

/* add meds: Each drug order creates an entry in encounter, encounter_provider, orders, and drug_order. */
-- drug order encounters don't have a visit_id
-- technically it is perfectly safe to reset CURRENT_ENC_ID rather than making a new variable, but since the two aren't equal I'm making different vars.
SELECT max(encounter_id)+1 INTO @CURRENT_ENC_ID2 from encounter;
INSERT INTO `encounter` (`encounter_id`, `encounter_type`, `patient_id`, `location_id`, `form_id`, `encounter_datetime`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `changed_by`, `date_changed`, `visit_id`, `uuid`) VALUES  
(@CURRENT_ENC_ID2,8,@CURRENT_PATIENT_ID,NULL,NULL,CONCAT(@CLASS_DATE,' 13:32:04'),1,'2021-03-19 13:32:04',0,NULL,NULL,NULL,NULL,NULL,NULL,(select UUID()));
INSERT INTO `encounter_provider` (`encounter_id`, `provider_id`, `encounter_role_id`, `creator`, `date_created`, `changed_by`, `date_changed`, `voided`, `date_voided`, `voided_by`, `void_reason`, `uuid`) VALUES  
(@CURRENT_ENC_ID2,1,2,1,'2021-03-19 13:32:04',NULL,NULL,0,NULL,NULL,NULL,(select uuid()));
-- Order uses encounter_id. Orders that share an encounter_id were signed together.
SELECT max(order_id)+1 INTO @CURRENT_ORD_ID from orders; -- We will count on the orders being inserted sequentially
INSERT INTO `orders` (`order_id`,`order_type_id`, `concept_id`, `orderer`, `encounter_id`, `instructions`, `date_activated`, `auto_expire_date`, `date_stopped`, `order_reason`, `order_reason_non_coded`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `patient_id`, `accession_number`, `uuid`, `urgency`, `order_number`, `previous_order_id`, `order_action`, `comment_to_fulfiller`, `care_setting`, `scheduled_date`, `order_group_id`, `sort_weight`) VALUES 
(@CURRENT_ORD_ID, 2,165483,1,@CURRENT_ENC_ID2,NULL,CONCAT(@CLASS_DATE,' 13:32:04'),CONCAT(@CLASS_DATE1Y,' 13:32:03'),NULL,NULL,NULL,1,'2021-03-19 13:32:04',0,NULL,NULL,NULL,@CURRENT_PATIENT_ID,NULL,(select uuid()),'ROUTINE',CONCAT('ORD-',@ORDCOUNT+1),NULL,'NEW',NULL,1,NULL,NULL,NULL),
(@CURRENT_ORD_ID +1, 2,166329,1,@CURRENT_ENC_ID2,NULL,CONCAT(@CLASS_DATE,' 13:38:25'),CONCAT(@CLASS_DATE1Y,' 13:38:24'),NULL,NULL,NULL,1,'2021-03-19 13:32:04',0,NULL,NULL,NULL,@CURRENT_PATIENT_ID,NULL,(select uuid()),'ROUTINE',CONCAT('ORD-',@ORDCOUNT +2),NULL,'NEW',NULL,1,NULL,NULL,NULL),
(@CURRENT_ORD_ID +2, 2,167867,1,@CURRENT_ENC_ID2,NULL,CONCAT(@CLASS_DATE,' 13:41:52'),CONCAT(@CLASS_DATE1Y,' 13:41:51'),NULL,NULL,NULL,1,'2021-03-19 13:32:04',0,NULL,NULL,NULL,@CURRENT_PATIENT_ID,NULL,(select uuid()),'ROUTINE',CONCAT('ORD-',@ORDCOUNT +3),NULL,'NEW',NULL,1,NULL,NULL,NULL),
(@CURRENT_ORD_ID +3, 2,166394,1,@CURRENT_ENC_ID2,NULL,CONCAT(@CLASS_DATE,' 13:41:52'),CONCAT(@CLASS_DATE1Y,' 13:41:51'),NULL,NULL,NULL,1,'2021-03-19 13:32:04',0,NULL,NULL,NULL,@CURRENT_PATIENT_ID,NULL,(select uuid()),'ROUTINE',CONCAT('ORD-',@ORDCOUNT +4),NULL,'NEW',NULL,1,NULL,NULL,NULL);
SET @ORDCOUNT := @ORDCOUNT +4;
-- uses the order_id from the above orders
INSERT INTO `drug_order` (`order_id`, `drug_inventory_id`, `dose`, `as_needed`, `dosing_type`, `quantity`, `as_needed_condition`, `num_refills`, `dosing_instructions`, `duration`, `duration_units`, `quantity_units`, `route`, `dose_units`, `frequency`, `brand_name`, `dispense_as_written`, `drug_non_coded`) VALUES 
(@CURRENT_ORD_ID,4,1000,0,'org.openmrs.SimpleDosingInstructions',180,NULL,0,NULL,1,1734,1513,160240,161553,11,NULL,0,NULL),
(@CURRENT_ORD_ID +1,133,5,0,'org.openmrs.SimpleDosingInstructions',90,NULL,0,NULL,1,1734,1513,160240,161553,16,NULL,0,NULL),
(@CURRENT_ORD_ID +2,159,50,0,'org.openmrs.SimpleDosingInstructions',260,'pain',0,'zo nodig tot 3dd 50mg bij pijn',1,1734,1513,160240,161553,20,NULL,0,NULL),
(@CURRENT_ORD_ID +3,139,40,0,'org.openmrs.SimpleDosingInstructions',90,NULL,0,NULL,1,1734,1513,160240,161553,16,NULL,0,NULL);
/* TODO add gliclazide */

/* add allergy */
INSERT INTO `allergy` (`patient_id`, `severity_concept_id`, `coded_allergen`, `non_coded_allergen`, `allergen_type`, `comment`, `creator`, `date_created`, `changed_by`, `date_changed`, `voided`, `voided_by`, `date_voided`, `void_reason`, `uuid`) VALUES  
(@CURRENT_PATIENT_ID,1498,5622,'Bruine pleister','OTHER','',1,'2021-03-19 13:45:14',NULL,NULL,0,NULL,NULL,NULL,(select uuid()));
UPDATE patient SET allergy_status = 'See list' where patient_id = @CURRENT_PATIENT_ID;

/* admit patient as inpatient */
SELECT max(encounter_id)+1 INTO @CURRENT_ENC_ID3 from encounter;
INSERT INTO `encounter` (`encounter_id`, `encounter_type`, `patient_id`, `location_id`, `form_id`, `encounter_datetime`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `changed_by`, `date_changed`, `visit_id`, `uuid`) VALUES
(@CURRENT_ENC_ID3,2,@CURRENT_PATIENT_ID,6,3,CONCAT(@CLASS_DATE,' 14:00:05'),1,'2021-03-19 14:00:05',0,NULL,NULL,NULL,NULL,NULL,@CURRENT_VISIT_ID,(select uuid()));

-- uses encounter_id from above
INSERT INTO `encounter_provider` (`encounter_id`, `provider_id`, `encounter_role_id`, `creator`, `date_created`, `changed_by`, `date_changed`, `voided`, `date_voided`, `voided_by`, `void_reason`, `uuid`) VALUES 
(@CURRENT_ENC_ID3,1,1,1,'2021-03-19 14:00:05',NULL,NULL,0,NULL,NULL,NULL,(select uuid()));

/* add vitals */
SELECT max(encounter_id)+1 INTO @CURRENT_ENC_ID4 from encounter;
INSERT INTO `encounter` (`encounter_id`,`encounter_type`, `patient_id`, `location_id`, `form_id`, `encounter_datetime`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `changed_by`, `date_changed`, `visit_id`, `uuid`) VALUES
(@CURRENT_ENC_ID4, 7,@CURRENT_PATIENT_ID,6,1,CONCAT(@CLASS_DATE,' 14:21:31'),1,'2021-03-19 14:21:31',0,NULL,NULL,NULL,NULL,NULL,@CURRENT_VISIT_ID,(select uuid()));
-- uses encounter_id from above
INSERT INTO `encounter_provider` (`encounter_id`, `provider_id`, `encounter_role_id`, `creator`, `date_created`, `changed_by`, `date_changed`, `voided`, `date_voided`, `voided_by`, `void_reason`, `uuid`) VALUES 
(@CURRENT_ENC_ID4,1,2,1,'2021-03-19 14:21:31',NULL,NULL,0,NULL,NULL,NULL,(select uuid()));
-- uses encounter_id from above. each vital meas gets an obs entry. Doesn't seem to use obs_group_id
INSERT INTO `obs` (`person_id`, `concept_id`, `encounter_id`, `order_id`, `obs_datetime`, `location_id`, `obs_group_id`,`accession_number`, `value_group_id`, `value_coded`, `value_coded_name_id`, `value_drug`, `value_datetime`, `value_numeric`, `value_modifier`, `value_text`, `value_complex`, `comments`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `uuid`, `previous_version`, `form_namespace_and_path`, `status`, `interpretation`) VALUES 
(@CURRENT_PATIENT_ID,5088,@CURRENT_ENC_ID4,NULL,CONCAT(@CLASS_DATE,' 14:21:31'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,37.9,NULL,NULL,NULL,NULL,1,'2021-03-19 14:21:31',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_PATIENT_ID,5087,@CURRENT_ENC_ID4,NULL,CONCAT(@CLASS_DATE,' 14:21:31'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,90,NULL,NULL,NULL,NULL,1,'2021-03-19 14:21:31',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_PATIENT_ID,5242,@CURRENT_ENC_ID4,NULL,CONCAT(@CLASS_DATE,' 14:21:31'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,9,NULL,NULL,NULL,NULL,1,'2021-03-19 14:21:31',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_PATIENT_ID,5085,@CURRENT_ENC_ID4,NULL,CONCAT(@CLASS_DATE,' 14:21:31'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,125,NULL,NULL,NULL,NULL,1,'2021-03-19 14:21:31',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_PATIENT_ID,5086,@CURRENT_ENC_ID4,NULL,CONCAT(@CLASS_DATE,' 14:21:31'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,85,NULL,NULL,NULL,NULL,1,'2021-03-19 14:21:31',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_PATIENT_ID,5092,@CURRENT_ENC_ID4,NULL,CONCAT(@CLASS_DATE,' 14:21:31'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,98,NULL,NULL,NULL,NULL,1,'2021-03-19 14:21:31',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL);

/* add lab results */
-- note that this obs doesn't have an encounter_id
INSERT INTO `obs` (`person_id`, `concept_id`, `encounter_id`, `order_id`, `obs_datetime`, `location_id`, `obs_group_id`,`accession_number`, `value_group_id`, `value_coded`, `value_coded_name_id`, `value_drug`, `value_datetime`, `value_numeric`, `value_modifier`, `value_text`, `value_complex`, `comments`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `uuid`, `previous_version`, `form_namespace_and_path`, `status`, `interpretation`) VALUES 
(@CURRENT_PATIENT_ID,169769,NULL,NULL,CONCAT(@CLASS_DATE,' 14:25:00'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,36,NULL,NULL,NULL,'U/I',1,'2021-03-19 14:54:21',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_PATIENT_ID,169770,NULL,NULL,CONCAT(@CLASS_DATE,' 14:25:00'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,29,NULL,NULL,NULL,'U/I',1,'2021-03-19 14:58:44',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_PATIENT_ID,169763,NULL,NULL,CONCAT(@CLASS_DATE,' 14:25:00'),NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,70,NULL,NULL,NULL,'umol/l',1,'2021-03-19 15:00:30',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_PATIENT_ID,169764,NULL,NULL,CONCAT(@CLASS_DATE,' 14:25:00'),NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,60,NULL,NULL,NULL,'> 60 ml/min/m2',1,'2021-03-19 15:01:46',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_PATIENT_ID,169771,NULL,NULL,CONCAT(@CLASS_DATE,' 14:25:00'),NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,60,NULL,NULL,NULL,'U/I',1,'2021-03-19 15:03:45',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_PATIENT_ID,169768,NULL,NULL,CONCAT(@CLASS_DATE,' 14:25:00'),NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,90,NULL,NULL,NULL,'U/I',1,'2021-03-19 15:04:46',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_PATIENT_ID,169743,NULL,NULL,CONCAT(@CLASS_DATE,' 14:25:00'),NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,11.5,NULL,NULL,NULL,'mmol/L',1,'2021-03-19 15:07:12',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL);
/* TODO add 
CRP 80 mg/l 
Hb 8,2 mmol/l 
Leukocyten 11 * 10^9/l 
Trombocyten 349 * 10^9/l 
Leukocyten differentiatie: neutrofielen 8,2 * 10^9/l, eosinofielen 0,1 * 10^9/l, basofielen 0,0 * 10^9/l, monocyten 0,2 * 10^9/l, lymfocyten 2,5 * 10^9/l 
Na 142 mmol/l 
K 3,9 mmol/l 
*/

/* add visit note and the associated visit diagnosis */
SELECT max(encounter_id)+1 INTO @CURRENT_ENC_ID5 from encounter;
INSERT INTO `encounter` (`encounter_id`,`encounter_type`, `patient_id`, `location_id`, `form_id`, `encounter_datetime`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `changed_by`, `date_changed`, `visit_id`, `uuid`) VALUES
(@CURRENT_ENC_ID5,3,@CURRENT_PATIENT_ID,6,2,CONCAT(@CLASS_DATE,' 16:17:21'),1,'2021-03-19 16:17:21',0,NULL,NULL,NULL,NULL,NULL,@CURRENT_VISIT_ID,(select uuid()));
-- uses encounter_id from the above encounter
INSERT INTO `encounter_provider` (`encounter_id`, `provider_id`, `encounter_role_id`, `creator`, `date_created`, `changed_by`, `date_changed`, `voided`, `date_voided`, `voided_by`, `void_reason`, `uuid`) VALUES 
(@CURRENT_ENC_ID5,1,1,1,'2021-03-19 16:17:21',NULL,NULL,0,NULL,NULL,NULL,(select uuid()));
-- uses encounter_id from above. Obs_group_id is the id of the first obs in this group
-- The last query above is a correction to the text - no need to replicate that for this patient.
SELECT max(obs_id)+1 INTO @CURRENT_OBS_ID2 from obs;
INSERT INTO `obs` (`person_id`, `concept_id`, `encounter_id`, `order_id`, `obs_datetime`, `location_id`, `obs_group_id`,`accession_number`, `value_group_id`, `value_coded`, `value_coded_name_id`, `value_drug`, `value_datetime`, `value_numeric`, `value_modifier`, `value_text`, `value_complex`, `comments`,`creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `uuid`, `previous_version`, `form_namespace_and_path`, `status`, `interpretation`) VALUES 
(@CURRENT_PATIENT_ID,159947,@CURRENT_ENC_ID5,NULL,CONCAT(@CLASS_DATE,' 16:17:21'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'2021-03-19 16:17:21',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_PATIENT_ID,159394,@CURRENT_ENC_ID5,NULL,CONCAT(@CLASS_DATE,' 16:17:21'),6,@CURRENT_OBS_ID2,NULL,NULL,159393,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'2021-03-19 16:17:21',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_PATIENT_ID,159946,@CURRENT_ENC_ID5,NULL,CONCAT(@CLASS_DATE,' 16:17:21'),6,@CURRENT_OBS_ID2,NULL,NULL,159943,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'2021-03-19 16:17:21',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_PATIENT_ID,161602,@CURRENT_ENC_ID5,NULL,CONCAT(@CLASS_DATE,' 16:17:21'),6,@CURRENT_OBS_ID2,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'cellulitis',NULL,NULL,1,'2021-03-19 16:17:21',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_PATIENT_ID,162169,@CURRENT_ENC_ID5,NULL,CONCAT(@CLASS_DATE,' 16:17:49'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Afgelopen week gemerkt dat er een rode plek op het linker onderbeen ontstond. Deed geen pijn, geen koorts. Op vrijdag wel duidelijk pijnlijk en koorts gehad. Dit heeft zij niet gemeten, maar zij weet het altijd zeker als zij koorts heeft. Geen koude rillingen. Door huisarts is antibiotica voorgeschreven, zij weet niet goed welke, maar neemt het vier keer per dag.\n\nOp zondag (vandaag) was de roodheid weer erger geworden en had zij nog steeds het gevoel koorts te hebben en is zij via HAP naar SEH gekomen.\n\nTractus anamnese: behoudens braken na maaltijd sinds vandaag geen bijzonderheden.\n\n Algemene indruk: helder, niet acuut zieke patiënt\r\n\r\nH/H: geen lymfadenopathie, in de mond geen afwijkingen\r\n\r\nCor: normale harttonen, geen souffle\r\n\r\nPulm: normaal doorkomend ademgeruis, geen bijgeluiden\r\n\r\nAbd: normale peristaltiek, wisselende tympani, soepel, geen drukpijn, geen weerstanden\r\n\r\nExtr: rechts normaal warm, met pitting oedeem rondom de enkel, links mediaal van enkel tot knie duidelijke roodheid met induratie, warm, pijnlijk, kuit nog wel soepel\r\n\nConclusie\n1. Cellulitis linkeronderbeen met onvoldoende respons op orale antibiotica, geen porte d\'entree\n2. Ontregelde diabetes mellitus type II bij infectie\n3. Braken bij ziek zijn met goede intake\n\nBeleid\nAlgemeen:\nOpname op Interne Geneeskunde, volledig beleid, vrij dieet\nInfuus 1,5L NaCl 0,9% / 24u\nTijdelijk staken lisinopril en diclofenac bij verminderde intake\nLab herhalen niet nodig\nIntercollegiaal consult dermatologie\n\nT.a.v. 1: Flucloxacilline 4dd 1000mg i.v.\nT.a.v. 2: Bijspuitschema (2-4-6) zo nodig\nT.a.v 3: Metoclopramide 3dd 10mg zo nodig',NULL,NULL,1,'2021-03-19 16:17:49',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL);


/************************ DINSDAG *************************/
SET @DAY_OF_WEEK := 'Dinsdag';
SET @CURRENT_PATIENT_IDENTIFIER := 77777700002;
/* ------------ start by repeating Monday ------------------- */
SET @ORDCOUNT := 0;

SELECT max(patient_id)+1 INTO @CURRENT_PATIENT_ID from patient;

/* add patient */
INSERT INTO `person` VALUES(@CURRENT_PATIENT_ID,'F','1950-03-07',0,0,NULL,NULL,1,'2021-03-19 10:36:22',NULL,NULL,0,NULL,NULL,NULL,(select UUID()),0,NULL);
INSERT INTO `patient` VALUES (@CURRENT_PATIENT_ID,1,'2021-03-19 10:36:22',NULL,NULL,0,NULL,NULL,NULL,'Unknown');
INSERT INTO `patient_identifier` (`patient_id`, `identifier`, `identifier_type`, `preferred`, `location_id`, `creator`, `date_created`, `date_changed`, `changed_by`, `voided`, `voided_by`, `date_voided`, `void_reason`, `uuid`) VALUES 
(@CURRENT_PATIENT_ID,@CURRENT_PATIENT_IDENTIFIER,3,1,6,1,'2021-03-19 10:36:23',NULL,NULL,0,NULL,NULL,NULL,(select UUID()));

INSERT INTO `person_address` (`person_id`, `preferred`, `address1`, `address2`, `city_village`, `state_province`, `postal_code`, `country`, `latitude`, `longitude`, `start_date`, `end_date`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `county_district`, `address3`, `address4`, `address5`, `address6`, `date_changed`, `changed_by`, `uuid`, `address7`, `address8`, `address9`, `address10`, `address11`, `address12`, `address13`, `address14`, `address15`) VALUES  
(@CURRENT_PATIENT_ID,1,'Nieuwezijds Voorburgwal 147',NULL,'Amsterdam',NULL,'1012 RJ',NULL,NULL,NULL,NULL,NULL,1,'2021-03-19 10:36:23',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,(select UUID()),NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `person_attribute` (`person_id`, `value`, `person_attribute_type_id`, `creator`, `date_created`, `changed_by`, `date_changed`, `voided`, `voided_by`, `date_voided`, `void_reason`, `uuid`) VALUES 
(@CURRENT_PATIENT_ID,'0687654321',8,1,'2021-03-19 10:36:23',NULL,NULL,0,NULL,NULL,NULL,(select UUID()));
INSERT INTO `person_name` (`preferred`, `person_id`, `prefix`, `given_name`, `middle_name`, `family_name_prefix`, `family_name`, `family_name2`, `family_name_suffix`, `degree`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `changed_by`, `date_changed`, `uuid`) VALUES 
(1,@CURRENT_PATIENT_ID,NULL,CONCAT('Irma',@DAY_OF_WEEK),NULL,NULL,CONCAT('Andriessen',@STUDENT_ID),NULL,NULL,NULL,1,'2021-03-19 10:36:23',0,NULL,NULL,NULL,NULL,NULL,(select UUID()));

/* add visit */
SELECT max(visit_id)+1 INTO @CURRENT_VISIT_ID from visit;
INSERT INTO `visit` (`visit_id`,`patient_id`, `visit_type_id`, `date_started`, `date_stopped`, `indication_concept_id`, `location_id`, `creator`, `date_created`, `changed_by`, `date_changed`, `voided`, `voided_by`, `date_voided`, `void_reason`, `uuid`) VALUES 
(@CURRENT_VISIT_ID, @CURRENT_PATIENT_ID,1,CONCAT(@CLASS_DATE,' 13:12:39'),NULL,NULL,8,1,'2021-03-19 13:12:39',NULL,NULL,0,NULL,NULL,NULL, (select UUID()));

/* add visit diagnosis */
SELECT max(encounter_id)+1 INTO @CURRENT_ENC_ID from encounter;
INSERT INTO `encounter` (`encounter_id`, `encounter_type`, `patient_id`, `location_id`, `form_id`, `encounter_datetime`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `changed_by`, `date_changed`, `visit_id`, `uuid`) VALUES  
(@CURRENT_ENC_ID,8,@CURRENT_PATIENT_ID,NULL,NULL,CONCAT(@CLASS_DATE,' 13:27:14'),1,'2021-03-19 13:27:14',0,NULL,NULL,NULL,NULL,NULL,NULL,(select UUID()));
INSERT INTO `encounter_provider` (`encounter_id`, `provider_id`, `encounter_role_id`, `creator`, `date_created`, `changed_by`, `date_changed`, `voided`, `date_voided`, `voided_by`, `void_reason`, `uuid`) VALUES  
(@CURRENT_ENC_ID,1,2,1,'2021-03-19 13:27:14',NULL,NULL,0,NULL,NULL,NULL,(select uuid()));
-- note that each dx has 4 rows, and the obs_group_id for rows 2-4 are set to the obs_id of row 1.
-- encounter_id must match the encounter_id above
-- other values in these rows will depend on the IDs assigned to the diagnosis concepts.
SELECT max(obs_id)+1 INTO @CURRENT_OBS_ID from obs;
INSERT INTO `obs` (`person_id`, `concept_id`, `encounter_id`, `order_id`, `obs_datetime`, `location_id`, `obs_group_id`,
`accession_number`, `value_group_id`, `value_coded`, `value_coded_name_id`, `value_drug`, `value_datetime`, `value_numeric`, `value_modifier`, `value_text`, 
`value_complex`, `comments`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `uuid`, `previous_version`, `form_namespace_and_path`, `status`, `interpretation`) VALUES 
(@CURRENT_PATIENT_ID,159947,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE,' 13:27:14'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'2021-03-19 13:27:14',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_PATIENT_ID,159946,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE,' 13:27:14'),6,@CURRENT_OBS_ID,NULL,NULL,159943,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'2021-03-19 13:27:14',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_PATIENT_ID,159394,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE,' 13:27:14'),6,@CURRENT_OBS_ID,NULL,NULL,159393,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'2021-03-19 13:27:14',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_PATIENT_ID,1284,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE,' 13:27:14'),6,@CURRENT_OBS_ID,NULL,NULL,142473,42200,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'2021-03-19 13:27:14',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL);

/* add conditions */
INSERT INTO `conditions` (`previous_condition_id`, `patient_id`, `status`, `concept_id`, `condition_non_coded`, `onset_date`, `additional_detail`, `end_date`, `end_reason`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `uuid`) VALUES
(NULL,@CURRENT_PATIENT_ID,'ACTIVE',142473,'',NULL,'',NULL,NULL,1,'2021-03-26 17:00:21',0,NULL,NULL,NULL,(select uuid())),
(NULL,@CURRENT_PATIENT_ID,'ACTIVE',117399,'',NULL,'',NULL,NULL,1,'2021-03-26 17:02:04',0,NULL,NULL,NULL,(select uuid()));
/* TODO add
Chronische veneuze insufficiëntie 
Gonartrose 
*/

/* add meds: Each drug order creates an entry in encounter, encounter_provider, orders, and drug_order. */
-- drug order encounters don't have a visit_id
-- technically it is perfectly safe to reset CURRENT_ENC_ID rather than making a new variable, but since the two aren't equal I'm making different vars.
SELECT max(encounter_id)+1 INTO @CURRENT_ENC_ID2 from encounter;
INSERT INTO `encounter` (`encounter_id`, `encounter_type`, `patient_id`, `location_id`, `form_id`, `encounter_datetime`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `changed_by`, `date_changed`, `visit_id`, `uuid`) VALUES  
(@CURRENT_ENC_ID2,8,@CURRENT_PATIENT_ID,NULL,NULL,CONCAT(@CLASS_DATE,' 13:32:04'),1,'2021-03-19 13:32:04',0,NULL,NULL,NULL,NULL,NULL,NULL,(select UUID()));
INSERT INTO `encounter_provider` (`encounter_id`, `provider_id`, `encounter_role_id`, `creator`, `date_created`, `changed_by`, `date_changed`, `voided`, `date_voided`, `voided_by`, `void_reason`, `uuid`) VALUES  
(@CURRENT_ENC_ID2,1,2,1,'2021-03-19 13:32:04',NULL,NULL,0,NULL,NULL,NULL,(select uuid()));
-- Order uses encounter_id. Orders that share an encounter_id were signed together.
SELECT max(order_id)+1 INTO @CURRENT_ORD_ID from orders; -- We will count on the orders being inserted sequentially
INSERT INTO `orders` (`order_id`,`order_type_id`, `concept_id`, `orderer`, `encounter_id`, `instructions`, `date_activated`, `auto_expire_date`, `date_stopped`, `order_reason`, `order_reason_non_coded`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `patient_id`, `accession_number`, `uuid`, `urgency`, `order_number`, `previous_order_id`, `order_action`, `comment_to_fulfiller`, `care_setting`, `scheduled_date`, `order_group_id`, `sort_weight`) VALUES 
(@CURRENT_ORD_ID, 2,165483,1,@CURRENT_ENC_ID2,NULL,CONCAT(@CLASS_DATE,' 13:32:04'),CONCAT(@CLASS_DATE1Y,' 13:32:03'),NULL,NULL,NULL,1,'2021-03-19 13:32:04',0,NULL,NULL,NULL,@CURRENT_PATIENT_ID,NULL,(select uuid()),'ROUTINE',CONCAT('ORD-',@ORDCOUNT+1),NULL,'NEW',NULL,1,NULL,NULL,NULL),
(@CURRENT_ORD_ID +1, 2,166329,1,@CURRENT_ENC_ID2,NULL,CONCAT(@CLASS_DATE,' 13:38:25'),CONCAT(@CLASS_DATE1Y,' 13:38:24'),NULL,NULL,NULL,1,'2021-03-19 13:32:04',0,NULL,NULL,NULL,@CURRENT_PATIENT_ID,NULL,(select uuid()),'ROUTINE',CONCAT('ORD-',@ORDCOUNT +2),NULL,'NEW',NULL,1,NULL,NULL,NULL),
(@CURRENT_ORD_ID +2, 2,167867,1,@CURRENT_ENC_ID2,NULL,CONCAT(@CLASS_DATE,' 13:41:52'),CONCAT(@CLASS_DATE1Y,' 13:41:51'),NULL,NULL,NULL,1,'2021-03-19 13:32:04',0,NULL,NULL,NULL,@CURRENT_PATIENT_ID,NULL,(select uuid()),'ROUTINE',CONCAT('ORD-',@ORDCOUNT +3),NULL,'NEW',NULL,1,NULL,NULL,NULL),
(@CURRENT_ORD_ID +3, 2,166394,1,@CURRENT_ENC_ID2,NULL,CONCAT(@CLASS_DATE,' 13:41:52'),CONCAT(@CLASS_DATE1Y,' 13:41:51'),NULL,NULL,NULL,1,'2021-03-19 13:32:04',0,NULL,NULL,NULL,@CURRENT_PATIENT_ID,NULL,(select uuid()),'ROUTINE',CONCAT('ORD-',@ORDCOUNT +4),NULL,'NEW',NULL,1,NULL,NULL,NULL);
SET @ORDCOUNT := @ORDCOUNT +4;
-- uses the order_id from the above orders
INSERT INTO `drug_order` (`order_id`, `drug_inventory_id`, `dose`, `as_needed`, `dosing_type`, `quantity`, `as_needed_condition`, `num_refills`, `dosing_instructions`, `duration`, `duration_units`, `quantity_units`, `route`, `dose_units`, `frequency`, `brand_name`, `dispense_as_written`, `drug_non_coded`) VALUES 
(@CURRENT_ORD_ID,4,1000,0,'org.openmrs.SimpleDosingInstructions',180,NULL,0,NULL,1,1734,1513,160240,161553,11,NULL,0,NULL),
(@CURRENT_ORD_ID +1,133,5,0,'org.openmrs.SimpleDosingInstructions',90,NULL,0,NULL,1,1734,1513,160240,161553,16,NULL,0,NULL),
(@CURRENT_ORD_ID +2,159,50,0,'org.openmrs.SimpleDosingInstructions',260,'pain',0,'zo nodig tot 3dd 50mg bij pijn',1,1734,1513,160240,161553,20,NULL,0,NULL),
(@CURRENT_ORD_ID +3,139,40,0,'org.openmrs.SimpleDosingInstructions',90,NULL,0,NULL,1,1734,1513,160240,161553,16,NULL,0,NULL);
/* TODO add gliclazide */

/* add allergy */
INSERT INTO `allergy` (`patient_id`, `severity_concept_id`, `coded_allergen`, `non_coded_allergen`, `allergen_type`, `comment`, `creator`, `date_created`, `changed_by`, `date_changed`, `voided`, `voided_by`, `date_voided`, `void_reason`, `uuid`) VALUES  
(@CURRENT_PATIENT_ID,1498,5622,'Bruine pleister','OTHER','',1,'2021-03-19 13:45:14',NULL,NULL,0,NULL,NULL,NULL,(select uuid()));
UPDATE patient SET allergy_status = 'See list' where patient_id = @CURRENT_PATIENT_ID;

/* admit patient as inpatient */
SELECT max(encounter_id)+1 INTO @CURRENT_ENC_ID3 from encounter;
INSERT INTO `encounter` (`encounter_id`, `encounter_type`, `patient_id`, `location_id`, `form_id`, `encounter_datetime`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `changed_by`, `date_changed`, `visit_id`, `uuid`) VALUES
(@CURRENT_ENC_ID3,2,@CURRENT_PATIENT_ID,6,3,CONCAT(@CLASS_DATE,' 14:00:05'),1,'2021-03-19 14:00:05',0,NULL,NULL,NULL,NULL,NULL,@CURRENT_VISIT_ID,(select uuid()));

-- uses encounter_id from above
INSERT INTO `encounter_provider` (`encounter_id`, `provider_id`, `encounter_role_id`, `creator`, `date_created`, `changed_by`, `date_changed`, `voided`, `date_voided`, `voided_by`, `void_reason`, `uuid`) VALUES 
(@CURRENT_ENC_ID3,1,1,1,'2021-03-19 14:00:05',NULL,NULL,0,NULL,NULL,NULL,(select uuid()));

/* add vitals */
SELECT max(encounter_id)+1 INTO @CURRENT_ENC_ID4 from encounter;
INSERT INTO `encounter` (`encounter_id`,`encounter_type`, `patient_id`, `location_id`, `form_id`, `encounter_datetime`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `changed_by`, `date_changed`, `visit_id`, `uuid`) VALUES
(@CURRENT_ENC_ID4, 7,@CURRENT_PATIENT_ID,6,1,CONCAT(@CLASS_DATE,' 14:21:31'),1,'2021-03-19 14:21:31',0,NULL,NULL,NULL,NULL,NULL,@CURRENT_VISIT_ID,(select uuid()));
-- uses encounter_id from above
INSERT INTO `encounter_provider` (`encounter_id`, `provider_id`, `encounter_role_id`, `creator`, `date_created`, `changed_by`, `date_changed`, `voided`, `date_voided`, `voided_by`, `void_reason`, `uuid`) VALUES 
(@CURRENT_ENC_ID4,1,2,1,'2021-03-19 14:21:31',NULL,NULL,0,NULL,NULL,NULL,(select uuid()));
-- uses encounter_id from above. each vital meas gets an obs entry. Doesn't seem to use obs_group_id
INSERT INTO `obs` (`person_id`, `concept_id`, `encounter_id`, `order_id`, `obs_datetime`, `location_id`, `obs_group_id`,`accession_number`, `value_group_id`, `value_coded`, `value_coded_name_id`, `value_drug`, `value_datetime`, `value_numeric`, `value_modifier`, `value_text`, `value_complex`, `comments`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `uuid`, `previous_version`, `form_namespace_and_path`, `status`, `interpretation`) VALUES 
(@CURRENT_PATIENT_ID,5088,@CURRENT_ENC_ID4,NULL,CONCAT(@CLASS_DATE,' 14:21:31'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,37.9,NULL,NULL,NULL,NULL,1,'2021-03-19 14:21:31',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_PATIENT_ID,5087,@CURRENT_ENC_ID4,NULL,CONCAT(@CLASS_DATE,' 14:21:31'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,90,NULL,NULL,NULL,NULL,1,'2021-03-19 14:21:31',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_PATIENT_ID,5242,@CURRENT_ENC_ID4,NULL,CONCAT(@CLASS_DATE,' 14:21:31'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,9,NULL,NULL,NULL,NULL,1,'2021-03-19 14:21:31',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_PATIENT_ID,5085,@CURRENT_ENC_ID4,NULL,CONCAT(@CLASS_DATE,' 14:21:31'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,125,NULL,NULL,NULL,NULL,1,'2021-03-19 14:21:31',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_PATIENT_ID,5086,@CURRENT_ENC_ID4,NULL,CONCAT(@CLASS_DATE,' 14:21:31'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,85,NULL,NULL,NULL,NULL,1,'2021-03-19 14:21:31',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_PATIENT_ID,5092,@CURRENT_ENC_ID4,NULL,CONCAT(@CLASS_DATE,' 14:21:31'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,98,NULL,NULL,NULL,NULL,1,'2021-03-19 14:21:31',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL);

/* add lab results */
-- note that this obs doesn't have an encounter_id
INSERT INTO `obs` (`person_id`, `concept_id`, `encounter_id`, `order_id`, `obs_datetime`, `location_id`, `obs_group_id`,`accession_number`, `value_group_id`, `value_coded`, `value_coded_name_id`, `value_drug`, `value_datetime`, `value_numeric`, `value_modifier`, `value_text`, `value_complex`, `comments`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `uuid`, `previous_version`, `form_namespace_and_path`, `status`, `interpretation`) VALUES 
(@CURRENT_PATIENT_ID,169769,NULL,NULL,CONCAT(@CLASS_DATE,' 14:25:00'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,36,NULL,NULL,NULL,'U/I',1,'2021-03-19 14:54:21',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_PATIENT_ID,169770,NULL,NULL,CONCAT(@CLASS_DATE,' 14:25:00'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,29,NULL,NULL,NULL,'U/I',1,'2021-03-19 14:58:44',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_PATIENT_ID,169763,NULL,NULL,CONCAT(@CLASS_DATE,' 14:25:00'),NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,70,NULL,NULL,NULL,'umol/l',1,'2021-03-19 15:00:30',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_PATIENT_ID,169764,NULL,NULL,CONCAT(@CLASS_DATE,' 14:25:00'),NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,60,NULL,NULL,NULL,'> 60 ml/min/m2',1,'2021-03-19 15:01:46',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_PATIENT_ID,169771,NULL,NULL,CONCAT(@CLASS_DATE,' 14:25:00'),NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,60,NULL,NULL,NULL,'U/I',1,'2021-03-19 15:03:45',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_PATIENT_ID,169768,NULL,NULL,CONCAT(@CLASS_DATE,' 14:25:00'),NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,90,NULL,NULL,NULL,'U/I',1,'2021-03-19 15:04:46',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_PATIENT_ID,169743,NULL,NULL,CONCAT(@CLASS_DATE,' 14:25:00'),NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,11.5,NULL,NULL,NULL,'mmol/L',1,'2021-03-19 15:07:12',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL);
/* TODO add 
CRP 80 mg/l 
Hb 8,2 mmol/l 
Leukocyten 11 * 10^9/l 
Trombocyten 349 * 10^9/l 
Leukocyten differentiatie: neutrofielen 8,2 * 10^9/l, eosinofielen 0,1 * 10^9/l, basofielen 0,0 * 10^9/l, monocyten 0,2 * 10^9/l, lymfocyten 2,5 * 10^9/l 
Na 142 mmol/l 
K 3,9 mmol/l 
*/

/* add visit note and the associated visit diagnosis */
SELECT max(encounter_id)+1 INTO @CURRENT_ENC_ID5 from encounter;
INSERT INTO `encounter` (`encounter_id`,`encounter_type`, `patient_id`, `location_id`, `form_id`, `encounter_datetime`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `changed_by`, `date_changed`, `visit_id`, `uuid`) VALUES
(@CURRENT_ENC_ID5,3,@CURRENT_PATIENT_ID,6,2,CONCAT(@CLASS_DATE,' 16:17:21'),1,'2021-03-19 16:17:21',0,NULL,NULL,NULL,NULL,NULL,@CURRENT_VISIT_ID,(select uuid()));
-- uses encounter_id from the above encounter
INSERT INTO `encounter_provider` (`encounter_id`, `provider_id`, `encounter_role_id`, `creator`, `date_created`, `changed_by`, `date_changed`, `voided`, `date_voided`, `voided_by`, `void_reason`, `uuid`) VALUES 
(@CURRENT_ENC_ID5,1,1,1,'2021-03-19 16:17:21',NULL,NULL,0,NULL,NULL,NULL,(select uuid()));
-- uses encounter_id from above. Obs_group_id is the id of the first obs in this group
-- The last query above is a correction to the text - no need to replicate that for this patient.
SELECT max(obs_id)+1 INTO @CURRENT_OBS_ID2 from obs;
INSERT INTO `obs` (`person_id`, `concept_id`, `encounter_id`, `order_id`, `obs_datetime`, `location_id`, `obs_group_id`,`accession_number`, `value_group_id`, `value_coded`, `value_coded_name_id`, `value_drug`, `value_datetime`, `value_numeric`, `value_modifier`, `value_text`, `value_complex`, `comments`,`creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `uuid`, `previous_version`, `form_namespace_and_path`, `status`, `interpretation`) VALUES 
(@CURRENT_PATIENT_ID,159947,@CURRENT_ENC_ID5,NULL,CONCAT(@CLASS_DATE,' 16:17:21'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'2021-03-19 16:17:21',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_PATIENT_ID,159394,@CURRENT_ENC_ID5,NULL,CONCAT(@CLASS_DATE,' 16:17:21'),6,@CURRENT_OBS_ID2,NULL,NULL,159393,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'2021-03-19 16:17:21',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_PATIENT_ID,159946,@CURRENT_ENC_ID5,NULL,CONCAT(@CLASS_DATE,' 16:17:21'),6,@CURRENT_OBS_ID2,NULL,NULL,159943,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'2021-03-19 16:17:21',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_PATIENT_ID,161602,@CURRENT_ENC_ID5,NULL,CONCAT(@CLASS_DATE,' 16:17:21'),6,@CURRENT_OBS_ID2,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'cellulitis',NULL,NULL,1,'2021-03-19 16:17:21',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_PATIENT_ID,162169,@CURRENT_ENC_ID5,NULL,CONCAT(@CLASS_DATE,' 16:17:49'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Afgelopen week gemerkt dat er een rode plek op het linker onderbeen ontstond. Deed geen pijn, geen koorts. Op vrijdag wel duidelijk pijnlijk en koorts gehad. Dit heeft zij niet gemeten, maar zij weet het altijd zeker als zij koorts heeft. Geen koude rillingen. Door huisarts is antibiotica voorgeschreven, zij weet niet goed welke, maar neemt het vier keer per dag.\n\nOp zondag (vandaag) was de roodheid weer erger geworden en had zij nog steeds het gevoel koorts te hebben en is zij via HAP naar SEH gekomen.\n\nTractus anamnese: behoudens braken na maaltijd sinds vandaag geen bijzonderheden.\n\n Algemene indruk: helder, niet acuut zieke patiënt\r\n\r\nH/H: geen lymfadenopathie, in de mond geen afwijkingen\r\n\r\nCor: normale harttonen, geen souffle\r\n\r\nPulm: normaal doorkomend ademgeruis, geen bijgeluiden\r\n\r\nAbd: normale peristaltiek, wisselende tympani, soepel, geen drukpijn, geen weerstanden\r\n\r\nExtr: rechts normaal warm, met pitting oedeem rondom de enkel, links mediaal van enkel tot knie duidelijke roodheid met induratie, warm, pijnlijk, kuit nog wel soepel\r\n\nConclusie\n1. Cellulitis linkeronderbeen met onvoldoende respons op orale antibiotica, geen porte d\'entree\n2. Ontregelde diabetes mellitus type II bij infectie\n3. Braken bij ziek zijn met goede intake\n\nBeleid\nAlgemeen:\nOpname op Interne Geneeskunde, volledig beleid, vrij dieet\nInfuus 1,5L NaCl 0,9% / 24u\nTijdelijk staken lisinopril en diclofenac bij verminderde intake\nLab herhalen niet nodig\nIntercollegiaal consult dermatologie\n\nT.a.v. 1: Flucloxacilline 4dd 1000mg i.v.\nT.a.v. 2: Bijspuitschema (2-4-6) zo nodig\nT.a.v 3: Metoclopramide 3dd 10mg zo nodig',NULL,NULL,1,'2021-03-19 16:17:49',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL);
/* ------------ end repeating Monday ------------------------ */

/* patient had a couple temp readings over night */
SELECT max(encounter_id)+1 INTO @CURRENT_ENC_ID6 from encounter;
INSERT INTO `encounter` (`encounter_id`,`encounter_type`, `patient_id`, `location_id`, `form_id`, `encounter_datetime`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `changed_by`, `date_changed`, `visit_id`, `uuid`) VALUES
(@CURRENT_ENC_ID6, 7,@CURRENT_PATIENT_ID,6,1,CONCAT(@CLASS_DATE2,' 00:15:31'),1,'2021-03-19 14:21:31',0,NULL,NULL,NULL,NULL,NULL,@CURRENT_VISIT_ID,(select uuid()));
-- uses encounter_id from above
INSERT INTO `encounter_provider` (`encounter_id`, `provider_id`, `encounter_role_id`, `creator`, `date_created`, `changed_by`, `date_changed`, `voided`, `date_voided`, `voided_by`, `void_reason`, `uuid`) VALUES 
(@CURRENT_ENC_ID6,1,2,1,'2021-03-19 14:21:31',NULL,NULL,0,NULL,NULL,NULL,(select uuid()));
-- uses encounter_id from above. each vital meas gets an obs entry. Doesn't seem to use obs_group_id
INSERT INTO `obs` (`person_id`, `concept_id`, `encounter_id`, `order_id`, `obs_datetime`, `location_id`, `obs_group_id`,`accession_number`, `value_group_id`, `value_coded`, `value_coded_name_id`, `value_drug`, `value_datetime`, `value_numeric`, `value_modifier`, `value_text`, `value_complex`, `comments`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `uuid`, `previous_version`, `form_namespace_and_path`, `status`, `interpretation`) VALUES 
(@CURRENT_PATIENT_ID,5088,@CURRENT_ENC_ID6,NULL,CONCAT(@CLASS_DATE2,' 00:15:31'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,37.0,NULL,NULL,NULL,NULL,1,'2021-03-19 14:21:31',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL);

SELECT max(encounter_id)+1 INTO @CURRENT_ENC_ID7 from encounter;
INSERT INTO `encounter` (`encounter_id`,`encounter_type`, `patient_id`, `location_id`, `form_id`, `encounter_datetime`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `changed_by`, `date_changed`, `visit_id`, `uuid`) VALUES
(@CURRENT_ENC_ID7, 7,@CURRENT_PATIENT_ID,6,1,CONCAT(@CLASS_DATE2,' 06:45'),1,'2021-03-19 14:21:31',0,NULL,NULL,NULL,NULL,NULL,@CURRENT_VISIT_ID,(select uuid()));
-- uses encounter_id from above
INSERT INTO `encounter_provider` (`encounter_id`, `provider_id`, `encounter_role_id`, `creator`, `date_created`, `changed_by`, `date_changed`, `voided`, `date_voided`, `voided_by`, `void_reason`, `uuid`) VALUES 
(@CURRENT_ENC_ID7,1,2,1,'2021-03-19 14:21:31',NULL,NULL,0,NULL,NULL,NULL,(select uuid()));
-- uses encounter_id from above. each vital meas gets an obs entry. Doesn't seem to use obs_group_id
INSERT INTO `obs` (`person_id`, `concept_id`, `encounter_id`, `order_id`, `obs_datetime`, `location_id`, `obs_group_id`,`accession_number`, `value_group_id`, `value_coded`, `value_coded_name_id`, `value_drug`, `value_datetime`, `value_numeric`, `value_modifier`, `value_text`, `value_complex`, `comments`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `uuid`, `previous_version`, `form_namespace_and_path`, `status`, `interpretation`) VALUES 
(@CURRENT_PATIENT_ID,5088,@CURRENT_ENC_ID7,NULL,CONCAT(@CLASS_DATE2,' 06:45:31'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,36.5,NULL,NULL,NULL,NULL,1,'2021-03-19 14:21:31',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL);

/* glucose was measured overnight */
INSERT INTO `obs` (`person_id`, `concept_id`, `encounter_id`, `order_id`, `obs_datetime`, `location_id`, `obs_group_id`,`accession_number`, `value_group_id`, `value_coded`, `value_coded_name_id`, `value_drug`, `value_datetime`, `value_numeric`, `value_modifier`, `value_text`, `value_complex`, `comments`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `uuid`, `previous_version`, `form_namespace_and_path`, `status`, `interpretation`) VALUES 
(@CURRENT_PATIENT_ID,169743,NULL,NULL,CONCAT(@CLASS_DATE2,' 06:33:00'),NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,12.0,NULL,NULL,NULL,'mmol/L',1,'2021-03-19 15:07:12',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL);

/* lisinopril 166329 and diclofenac were temporarily discontinued */
/* TODO does not work correctly in my instance, but probably it is one of these two actions */
UPDATE orders SET order_action = 'DISCONTINUE' WHERE patient_id = @CURRENT_PATIENT_ID and concept_id in(166329,167867);
-- UPDATE orders SET date_stopped = CONCAT(@CLASS_DATE,' 22:05:00') WHERE patient_id = @CURRENT_PATIENT_ID and concept_id in(166329,167867);

SELECT max(encounter_id)+1 INTO @CURRENT_ENC_ID8 from encounter;
INSERT INTO `encounter` (`encounter_id`,`encounter_type`, `patient_id`, `location_id`, `form_id`, `encounter_datetime`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `changed_by`, `date_changed`, `visit_id`, `uuid`) VALUES
(@CURRENT_ENC_ID8,3,@CURRENT_PATIENT_ID,6,2,CONCAT(@CLASS_DATE2,' 06:20:39'),1,'2021-03-20 15:20:39',0,NULL,NULL,NULL,NULL,NULL,@CURRENT_VISIT_ID,(select uuid()));

INSERT INTO `encounter_provider` (`encounter_id`, `provider_id`, `encounter_role_id`, `creator`, `date_created`, `changed_by`, `date_changed`, `voided`, `date_voided`, `voided_by`, `void_reason`, `uuid`) VALUES 
(@CURRENT_ENC_ID8,1,1,1,'2021-03-20 15:20:39',NULL,NULL,0,NULL,NULL,NULL,(select uuid()));

SELECT max(obs_id)+1 INTO @CURRENT_OBS_ID3 from obs;
INSERT INTO `obs` VALUES
(@CURRENT_OBS_ID3,192,159947,4990,NULL,'2021-03-20 15:20:39',6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'2021-03-20 15:20:39',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_OBS_ID3+1,@CURRENT_PATIENT_ID,159946,@CURRENT_ENC_ID8,NULL,CONCAT(@CLASS_DATE2,' 06:20:39'),6,@CURRENT_OBS_ID3,NULL,NULL,159943,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'2021-03-20 15:20:39',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_OBS_ID3+2,@CURRENT_PATIENT_ID,159394,@CURRENT_ENC_ID8,NULL,CONCAT(@CLASS_DATE2,' 06:20:39'),6,@CURRENT_OBS_ID3,NULL,NULL,159393,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'2021-03-20 15:20:39',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_OBS_ID3+3,@CURRENT_PATIENT_ID,161602,@CURRENT_ENC_ID8,NULL,CONCAT(@CLASS_DATE2,' 06:20:39'),6,@CURRENT_OBS_ID3,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'cellulitis',NULL,NULL,1,'2021-03-20 15:20:39',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_OBS_ID3+4,@CURRENT_PATIENT_ID,162169,@CURRENT_ENC_ID8,NULL,CONCAT(@CLASS_DATE2,' 06:20:39'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'RvO/ Cellulitis \r\n\r\nVPK/ Hoog glucose, infuus gesneuveld, nog koorts, verder geen bijzonderheden. \r\n\r\n A/ Patiënt meldde dat been nog wel rood en pijnlijk is; toe- of afname is onduidelijk. Ook misselijkheid nog niet volledig hersteld. Diabetes thuis waarschijnlijk slecht gereguleerd. \r\n\r\n LO/ T 38,4°C, P 88/min, RR 134/86mmHg, AH 8/min, sat 98%. Linkeronderbeen nog duidelijk rood en warm, binnen afgetekende gebied (maar net afgetekend). \r\n\r\nAO/ Niet verricht. \r\n\r\nC/ Cellulitis, ontregelde diabetes en braken \r\n\r\nB/ Infuus staken, verder zo door. Morgen lab. ',NULL,NULL,1,'2021-03-20 15:20:39',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL);

/* TODO
CRP 40 mg/l 
Leukocyten 9,1 * 10^9/l 
Na 143 mmol/l 
K 4,0 mmol/l 
*//*
Kreatinine 76 umol/l 
eGFR 59 ml/min/m2 
*/
INSERT INTO `obs` (`person_id`, `concept_id`, `encounter_id`, `order_id`, `obs_datetime`, `location_id`, `obs_group_id`,`accession_number`, `value_group_id`, `value_coded`, `value_coded_name_id`, `value_drug`, `value_datetime`, `value_numeric`, `value_modifier`, `value_text`, `value_complex`, `comments`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `uuid`, `previous_version`, `form_namespace_and_path`, `status`, `interpretation`) VALUES 
(@CURRENT_PATIENT_ID,169763,NULL,NULL,CONCAT(@CLASS_DATE2,' 06:25:00'),NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,76,NULL,NULL,NULL,'umol/l',1,'2021-03-19 15:00:30',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_PATIENT_ID,169764,NULL,NULL,CONCAT(@CLASS_DATE2,' 06:25:00'),NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,59,NULL,NULL,NULL,'ml/min/m2',1,'2021-03-19 15:01:46',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL);

/* TODO add appt with dermatology */

/************************ WOENSDAG *************************/
SET @DAY_OF_WEEK := 'Woensdag';
SET @CURRENT_PATIENT_IDENTIFIER := 77777700003;
/* ------------ start by repeating Monday and Tuesday ------------------- */
SET @ORDCOUNT := 0;

SELECT max(patient_id)+1 INTO @CURRENT_PATIENT_ID from patient;

/* add patient */
INSERT INTO `person` VALUES(@CURRENT_PATIENT_ID,'F','1950-03-07',0,0,NULL,NULL,1,'2021-03-19 10:36:22',NULL,NULL,0,NULL,NULL,NULL,(select UUID()),0,NULL);
INSERT INTO `patient` VALUES (@CURRENT_PATIENT_ID,1,'2021-03-19 10:36:22',NULL,NULL,0,NULL,NULL,NULL,'Unknown');
INSERT INTO `patient_identifier` (`patient_id`, `identifier`, `identifier_type`, `preferred`, `location_id`, `creator`, `date_created`, `date_changed`, `changed_by`, `voided`, `voided_by`, `date_voided`, `void_reason`, `uuid`) VALUES 
(@CURRENT_PATIENT_ID,@CURRENT_PATIENT_IDENTIFIER,3,1,6,1,'2021-03-19 10:36:23',NULL,NULL,0,NULL,NULL,NULL,(select UUID()));

INSERT INTO `person_address` (`person_id`, `preferred`, `address1`, `address2`, `city_village`, `state_province`, `postal_code`, `country`, `latitude`, `longitude`, `start_date`, `end_date`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `county_district`, `address3`, `address4`, `address5`, `address6`, `date_changed`, `changed_by`, `uuid`, `address7`, `address8`, `address9`, `address10`, `address11`, `address12`, `address13`, `address14`, `address15`) VALUES  
(@CURRENT_PATIENT_ID,1,'Nieuwezijds Voorburgwal 147',NULL,'Amsterdam',NULL,'1012 RJ',NULL,NULL,NULL,NULL,NULL,1,'2021-03-19 10:36:23',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,(select UUID()),NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `person_attribute` (`person_id`, `value`, `person_attribute_type_id`, `creator`, `date_created`, `changed_by`, `date_changed`, `voided`, `voided_by`, `date_voided`, `void_reason`, `uuid`) VALUES 
(@CURRENT_PATIENT_ID,'0687654321',8,1,'2021-03-19 10:36:23',NULL,NULL,0,NULL,NULL,NULL,(select UUID()));
INSERT INTO `person_name` (`preferred`, `person_id`, `prefix`, `given_name`, `middle_name`, `family_name_prefix`, `family_name`, `family_name2`, `family_name_suffix`, `degree`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `changed_by`, `date_changed`, `uuid`) VALUES 
(1,@CURRENT_PATIENT_ID,NULL,CONCAT('Irma',@DAY_OF_WEEK),NULL,NULL,CONCAT('Andriessen',@STUDENT_ID),NULL,NULL,NULL,1,'2021-03-19 10:36:23',0,NULL,NULL,NULL,NULL,NULL,(select UUID()));

/* add visit */
SELECT max(visit_id)+1 INTO @CURRENT_VISIT_ID from visit;
INSERT INTO `visit` (`visit_id`,`patient_id`, `visit_type_id`, `date_started`, `date_stopped`, `indication_concept_id`, `location_id`, `creator`, `date_created`, `changed_by`, `date_changed`, `voided`, `voided_by`, `date_voided`, `void_reason`, `uuid`) VALUES 
(@CURRENT_VISIT_ID, @CURRENT_PATIENT_ID,1,CONCAT(@CLASS_DATE,' 13:12:39'),NULL,NULL,8,1,'2021-03-19 13:12:39',NULL,NULL,0,NULL,NULL,NULL, (select UUID()));

/* add visit diagnosis */
SELECT max(encounter_id)+1 INTO @CURRENT_ENC_ID from encounter;
INSERT INTO `encounter` (`encounter_id`, `encounter_type`, `patient_id`, `location_id`, `form_id`, `encounter_datetime`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `changed_by`, `date_changed`, `visit_id`, `uuid`) VALUES  
(@CURRENT_ENC_ID,8,@CURRENT_PATIENT_ID,NULL,NULL,CONCAT(@CLASS_DATE,' 13:27:14'),1,'2021-03-19 13:27:14',0,NULL,NULL,NULL,NULL,NULL,NULL,(select UUID()));
INSERT INTO `encounter_provider` (`encounter_id`, `provider_id`, `encounter_role_id`, `creator`, `date_created`, `changed_by`, `date_changed`, `voided`, `date_voided`, `voided_by`, `void_reason`, `uuid`) VALUES  
(@CURRENT_ENC_ID,1,2,1,'2021-03-19 13:27:14',NULL,NULL,0,NULL,NULL,NULL,(select uuid()));
-- note that each dx has 4 rows, and the obs_group_id for rows 2-4 are set to the obs_id of row 1.
-- encounter_id must match the encounter_id above
-- other values in these rows will depend on the IDs assigned to the diagnosis concepts.
SELECT max(obs_id)+1 INTO @CURRENT_OBS_ID from obs;
INSERT INTO `obs` (`person_id`, `concept_id`, `encounter_id`, `order_id`, `obs_datetime`, `location_id`, `obs_group_id`,
`accession_number`, `value_group_id`, `value_coded`, `value_coded_name_id`, `value_drug`, `value_datetime`, `value_numeric`, `value_modifier`, `value_text`, 
`value_complex`, `comments`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `uuid`, `previous_version`, `form_namespace_and_path`, `status`, `interpretation`) VALUES 
(@CURRENT_PATIENT_ID,159947,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE,' 13:27:14'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'2021-03-19 13:27:14',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_PATIENT_ID,159946,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE,' 13:27:14'),6,@CURRENT_OBS_ID,NULL,NULL,159943,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'2021-03-19 13:27:14',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_PATIENT_ID,159394,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE,' 13:27:14'),6,@CURRENT_OBS_ID,NULL,NULL,159393,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'2021-03-19 13:27:14',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_PATIENT_ID,1284,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE,' 13:27:14'),6,@CURRENT_OBS_ID,NULL,NULL,142473,42200,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'2021-03-19 13:27:14',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL);

/* add conditions */
INSERT INTO `conditions` (`previous_condition_id`, `patient_id`, `status`, `concept_id`, `condition_non_coded`, `onset_date`, `additional_detail`, `end_date`, `end_reason`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `uuid`) VALUES
(NULL,@CURRENT_PATIENT_ID,'ACTIVE',142473,'',NULL,'',NULL,NULL,1,'2021-03-26 17:00:21',0,NULL,NULL,NULL,(select uuid())),
(NULL,@CURRENT_PATIENT_ID,'ACTIVE',117399,'',NULL,'',NULL,NULL,1,'2021-03-26 17:02:04',0,NULL,NULL,NULL,(select uuid()));
/* TODO add
Chronische veneuze insufficiëntie 
Gonartrose 
*/

/* add meds: Each drug order creates an entry in encounter, encounter_provider, orders, and drug_order. */
-- drug order encounters don't have a visit_id
-- technically it is perfectly safe to reset CURRENT_ENC_ID rather than making a new variable, but since the two aren't equal I'm making different vars.
SELECT max(encounter_id)+1 INTO @CURRENT_ENC_ID2 from encounter;
INSERT INTO `encounter` (`encounter_id`, `encounter_type`, `patient_id`, `location_id`, `form_id`, `encounter_datetime`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `changed_by`, `date_changed`, `visit_id`, `uuid`) VALUES  
(@CURRENT_ENC_ID2,8,@CURRENT_PATIENT_ID,NULL,NULL,CONCAT(@CLASS_DATE,' 13:32:04'),1,'2021-03-19 13:32:04',0,NULL,NULL,NULL,NULL,NULL,NULL,(select UUID()));
INSERT INTO `encounter_provider` (`encounter_id`, `provider_id`, `encounter_role_id`, `creator`, `date_created`, `changed_by`, `date_changed`, `voided`, `date_voided`, `voided_by`, `void_reason`, `uuid`) VALUES  
(@CURRENT_ENC_ID2,1,2,1,'2021-03-19 13:32:04',NULL,NULL,0,NULL,NULL,NULL,(select uuid()));
-- Order uses encounter_id. Orders that share an encounter_id were signed together.
SELECT max(order_id)+1 INTO @CURRENT_ORD_ID from orders; -- We will count on the orders being inserted sequentially
INSERT INTO `orders` (`order_id`,`order_type_id`, `concept_id`, `orderer`, `encounter_id`, `instructions`, `date_activated`, `auto_expire_date`, `date_stopped`, `order_reason`, `order_reason_non_coded`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `patient_id`, `accession_number`, `uuid`, `urgency`, `order_number`, `previous_order_id`, `order_action`, `comment_to_fulfiller`, `care_setting`, `scheduled_date`, `order_group_id`, `sort_weight`) VALUES 
(@CURRENT_ORD_ID, 2,165483,1,@CURRENT_ENC_ID2,NULL,CONCAT(@CLASS_DATE,' 13:32:04'),CONCAT(@CLASS_DATE1Y,' 13:32:03'),NULL,NULL,NULL,1,'2021-03-19 13:32:04',0,NULL,NULL,NULL,@CURRENT_PATIENT_ID,NULL,(select uuid()),'ROUTINE',CONCAT('ORD-',@ORDCOUNT+1),NULL,'NEW',NULL,1,NULL,NULL,NULL),
(@CURRENT_ORD_ID +1, 2,166329,1,@CURRENT_ENC_ID2,NULL,CONCAT(@CLASS_DATE,' 13:38:25'),CONCAT(@CLASS_DATE1Y,' 13:38:24'),NULL,NULL,NULL,1,'2021-03-19 13:32:04',0,NULL,NULL,NULL,@CURRENT_PATIENT_ID,NULL,(select uuid()),'ROUTINE',CONCAT('ORD-',@ORDCOUNT +2),NULL,'NEW',NULL,1,NULL,NULL,NULL),
(@CURRENT_ORD_ID +2, 2,167867,1,@CURRENT_ENC_ID2,NULL,CONCAT(@CLASS_DATE,' 13:41:52'),CONCAT(@CLASS_DATE1Y,' 13:41:51'),NULL,NULL,NULL,1,'2021-03-19 13:32:04',0,NULL,NULL,NULL,@CURRENT_PATIENT_ID,NULL,(select uuid()),'ROUTINE',CONCAT('ORD-',@ORDCOUNT +3),NULL,'NEW',NULL,1,NULL,NULL,NULL),
(@CURRENT_ORD_ID +3, 2,166394,1,@CURRENT_ENC_ID2,NULL,CONCAT(@CLASS_DATE,' 13:41:52'),CONCAT(@CLASS_DATE1Y,' 13:41:51'),NULL,NULL,NULL,1,'2021-03-19 13:32:04',0,NULL,NULL,NULL,@CURRENT_PATIENT_ID,NULL,(select uuid()),'ROUTINE',CONCAT('ORD-',@ORDCOUNT +4),NULL,'NEW',NULL,1,NULL,NULL,NULL);
SET @ORDCOUNT := @ORDCOUNT +4;
-- uses the order_id from the above orders
INSERT INTO `drug_order` (`order_id`, `drug_inventory_id`, `dose`, `as_needed`, `dosing_type`, `quantity`, `as_needed_condition`, `num_refills`, `dosing_instructions`, `duration`, `duration_units`, `quantity_units`, `route`, `dose_units`, `frequency`, `brand_name`, `dispense_as_written`, `drug_non_coded`) VALUES 
(@CURRENT_ORD_ID,4,1000,0,'org.openmrs.SimpleDosingInstructions',180,NULL,0,NULL,1,1734,1513,160240,161553,11,NULL,0,NULL),
(@CURRENT_ORD_ID +1,133,5,0,'org.openmrs.SimpleDosingInstructions',90,NULL,0,NULL,1,1734,1513,160240,161553,16,NULL,0,NULL),
(@CURRENT_ORD_ID +2,159,50,0,'org.openmrs.SimpleDosingInstructions',260,'pain',0,'zo nodig tot 3dd 50mg bij pijn',1,1734,1513,160240,161553,20,NULL,0,NULL),
(@CURRENT_ORD_ID +3,139,40,0,'org.openmrs.SimpleDosingInstructions',90,NULL,0,NULL,1,1734,1513,160240,161553,16,NULL,0,NULL);
/* TODO add gliclazide */

/* add allergy */
INSERT INTO `allergy` (`patient_id`, `severity_concept_id`, `coded_allergen`, `non_coded_allergen`, `allergen_type`, `comment`, `creator`, `date_created`, `changed_by`, `date_changed`, `voided`, `voided_by`, `date_voided`, `void_reason`, `uuid`) VALUES  
(@CURRENT_PATIENT_ID,1498,5622,'Bruine pleister','OTHER','',1,'2021-03-19 13:45:14',NULL,NULL,0,NULL,NULL,NULL,(select uuid()));
UPDATE patient SET allergy_status = 'See list' where patient_id = @CURRENT_PATIENT_ID;

/* admit patient as inpatient */
SELECT max(encounter_id)+1 INTO @CURRENT_ENC_ID3 from encounter;
INSERT INTO `encounter` (`encounter_id`, `encounter_type`, `patient_id`, `location_id`, `form_id`, `encounter_datetime`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `changed_by`, `date_changed`, `visit_id`, `uuid`) VALUES
(@CURRENT_ENC_ID3,2,@CURRENT_PATIENT_ID,6,3,CONCAT(@CLASS_DATE,' 14:00:05'),1,'2021-03-19 14:00:05',0,NULL,NULL,NULL,NULL,NULL,@CURRENT_VISIT_ID,(select uuid()));

-- uses encounter_id from above
INSERT INTO `encounter_provider` (`encounter_id`, `provider_id`, `encounter_role_id`, `creator`, `date_created`, `changed_by`, `date_changed`, `voided`, `date_voided`, `voided_by`, `void_reason`, `uuid`) VALUES 
(@CURRENT_ENC_ID3,1,1,1,'2021-03-19 14:00:05',NULL,NULL,0,NULL,NULL,NULL,(select uuid()));

/* add vitals */
SELECT max(encounter_id)+1 INTO @CURRENT_ENC_ID4 from encounter;
INSERT INTO `encounter` (`encounter_id`,`encounter_type`, `patient_id`, `location_id`, `form_id`, `encounter_datetime`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `changed_by`, `date_changed`, `visit_id`, `uuid`) VALUES
(@CURRENT_ENC_ID4, 7,@CURRENT_PATIENT_ID,6,1,CONCAT(@CLASS_DATE,' 14:21:31'),1,'2021-03-19 14:21:31',0,NULL,NULL,NULL,NULL,NULL,@CURRENT_VISIT_ID,(select uuid()));
-- uses encounter_id from above
INSERT INTO `encounter_provider` (`encounter_id`, `provider_id`, `encounter_role_id`, `creator`, `date_created`, `changed_by`, `date_changed`, `voided`, `date_voided`, `voided_by`, `void_reason`, `uuid`) VALUES 
(@CURRENT_ENC_ID4,1,2,1,'2021-03-19 14:21:31',NULL,NULL,0,NULL,NULL,NULL,(select uuid()));
-- uses encounter_id from above. each vital meas gets an obs entry. Doesn't seem to use obs_group_id
INSERT INTO `obs` (`person_id`, `concept_id`, `encounter_id`, `order_id`, `obs_datetime`, `location_id`, `obs_group_id`,`accession_number`, `value_group_id`, `value_coded`, `value_coded_name_id`, `value_drug`, `value_datetime`, `value_numeric`, `value_modifier`, `value_text`, `value_complex`, `comments`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `uuid`, `previous_version`, `form_namespace_and_path`, `status`, `interpretation`) VALUES 
(@CURRENT_PATIENT_ID,5088,@CURRENT_ENC_ID4,NULL,CONCAT(@CLASS_DATE,' 14:21:31'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,37.9,NULL,NULL,NULL,NULL,1,'2021-03-19 14:21:31',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_PATIENT_ID,5087,@CURRENT_ENC_ID4,NULL,CONCAT(@CLASS_DATE,' 14:21:31'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,90,NULL,NULL,NULL,NULL,1,'2021-03-19 14:21:31',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_PATIENT_ID,5242,@CURRENT_ENC_ID4,NULL,CONCAT(@CLASS_DATE,' 14:21:31'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,9,NULL,NULL,NULL,NULL,1,'2021-03-19 14:21:31',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_PATIENT_ID,5085,@CURRENT_ENC_ID4,NULL,CONCAT(@CLASS_DATE,' 14:21:31'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,125,NULL,NULL,NULL,NULL,1,'2021-03-19 14:21:31',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_PATIENT_ID,5086,@CURRENT_ENC_ID4,NULL,CONCAT(@CLASS_DATE,' 14:21:31'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,85,NULL,NULL,NULL,NULL,1,'2021-03-19 14:21:31',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_PATIENT_ID,5092,@CURRENT_ENC_ID4,NULL,CONCAT(@CLASS_DATE,' 14:21:31'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,98,NULL,NULL,NULL,NULL,1,'2021-03-19 14:21:31',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL);

/* add lab results */
-- note that this obs doesn't have an encounter_id
INSERT INTO `obs` (`person_id`, `concept_id`, `encounter_id`, `order_id`, `obs_datetime`, `location_id`, `obs_group_id`,`accession_number`, `value_group_id`, `value_coded`, `value_coded_name_id`, `value_drug`, `value_datetime`, `value_numeric`, `value_modifier`, `value_text`, `value_complex`, `comments`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `uuid`, `previous_version`, `form_namespace_and_path`, `status`, `interpretation`) VALUES 
(@CURRENT_PATIENT_ID,169769,NULL,NULL,CONCAT(@CLASS_DATE,' 14:25:00'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,36,NULL,NULL,NULL,'U/I',1,'2021-03-19 14:54:21',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_PATIENT_ID,169770,NULL,NULL,CONCAT(@CLASS_DATE,' 14:25:00'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,29,NULL,NULL,NULL,'U/I',1,'2021-03-19 14:58:44',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_PATIENT_ID,169763,NULL,NULL,CONCAT(@CLASS_DATE,' 14:25:00'),NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,70,NULL,NULL,NULL,'umol/l',1,'2021-03-19 15:00:30',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_PATIENT_ID,169764,NULL,NULL,CONCAT(@CLASS_DATE,' 14:25:00'),NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,60,NULL,NULL,NULL,'> 60 ml/min/m2',1,'2021-03-19 15:01:46',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_PATIENT_ID,169771,NULL,NULL,CONCAT(@CLASS_DATE,' 14:25:00'),NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,60,NULL,NULL,NULL,'U/I',1,'2021-03-19 15:03:45',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_PATIENT_ID,169768,NULL,NULL,CONCAT(@CLASS_DATE,' 14:25:00'),NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,90,NULL,NULL,NULL,'U/I',1,'2021-03-19 15:04:46',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_PATIENT_ID,169743,NULL,NULL,CONCAT(@CLASS_DATE,' 14:25:00'),NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,11.5,NULL,NULL,NULL,'mmol/L',1,'2021-03-19 15:07:12',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL);
/* TODO add 
CRP 80 mg/l 
Hb 8,2 mmol/l 
Leukocyten 11 * 10^9/l 
Trombocyten 349 * 10^9/l 
Leukocyten differentiatie: neutrofielen 8,2 * 10^9/l, eosinofielen 0,1 * 10^9/l, basofielen 0,0 * 10^9/l, monocyten 0,2 * 10^9/l, lymfocyten 2,5 * 10^9/l 
Na 142 mmol/l 
K 3,9 mmol/l 
*/

/* add visit note and the associated visit diagnosis */
SELECT max(encounter_id)+1 INTO @CURRENT_ENC_ID5 from encounter;
INSERT INTO `encounter` (`encounter_id`,`encounter_type`, `patient_id`, `location_id`, `form_id`, `encounter_datetime`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `changed_by`, `date_changed`, `visit_id`, `uuid`) VALUES
(@CURRENT_ENC_ID5,3,@CURRENT_PATIENT_ID,6,2,CONCAT(@CLASS_DATE,' 16:17:21'),1,'2021-03-19 16:17:21',0,NULL,NULL,NULL,NULL,NULL,@CURRENT_VISIT_ID,(select uuid()));
-- uses encounter_id from the above encounter
INSERT INTO `encounter_provider` (`encounter_id`, `provider_id`, `encounter_role_id`, `creator`, `date_created`, `changed_by`, `date_changed`, `voided`, `date_voided`, `voided_by`, `void_reason`, `uuid`) VALUES 
(@CURRENT_ENC_ID5,1,1,1,'2021-03-19 16:17:21',NULL,NULL,0,NULL,NULL,NULL,(select uuid()));
-- uses encounter_id from above. Obs_group_id is the id of the first obs in this group
-- The last query above is a correction to the text - no need to replicate that for this patient.
SELECT max(obs_id)+1 INTO @CURRENT_OBS_ID2 from obs;
INSERT INTO `obs` (`person_id`, `concept_id`, `encounter_id`, `order_id`, `obs_datetime`, `location_id`, `obs_group_id`,`accession_number`, `value_group_id`, `value_coded`, `value_coded_name_id`, `value_drug`, `value_datetime`, `value_numeric`, `value_modifier`, `value_text`, `value_complex`, `comments`,`creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `uuid`, `previous_version`, `form_namespace_and_path`, `status`, `interpretation`) VALUES 
(@CURRENT_PATIENT_ID,159947,@CURRENT_ENC_ID5,NULL,CONCAT(@CLASS_DATE,' 16:17:21'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'2021-03-19 16:17:21',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_PATIENT_ID,159394,@CURRENT_ENC_ID5,NULL,CONCAT(@CLASS_DATE,' 16:17:21'),6,@CURRENT_OBS_ID2,NULL,NULL,159393,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'2021-03-19 16:17:21',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_PATIENT_ID,159946,@CURRENT_ENC_ID5,NULL,CONCAT(@CLASS_DATE,' 16:17:21'),6,@CURRENT_OBS_ID2,NULL,NULL,159943,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'2021-03-19 16:17:21',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_PATIENT_ID,161602,@CURRENT_ENC_ID5,NULL,CONCAT(@CLASS_DATE,' 16:17:21'),6,@CURRENT_OBS_ID2,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'cellulitis',NULL,NULL,1,'2021-03-19 16:17:21',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_PATIENT_ID,162169,@CURRENT_ENC_ID5,NULL,CONCAT(@CLASS_DATE,' 16:17:49'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Afgelopen week gemerkt dat er een rode plek op het linker onderbeen ontstond. Deed geen pijn, geen koorts. Op vrijdag wel duidelijk pijnlijk en koorts gehad. Dit heeft zij niet gemeten, maar zij weet het altijd zeker als zij koorts heeft. Geen koude rillingen. Door huisarts is antibiotica voorgeschreven, zij weet niet goed welke, maar neemt het vier keer per dag.\n\nOp zondag (vandaag) was de roodheid weer erger geworden en had zij nog steeds het gevoel koorts te hebben en is zij via HAP naar SEH gekomen.\n\nTractus anamnese: behoudens braken na maaltijd sinds vandaag geen bijzonderheden.\n\n Algemene indruk: helder, niet acuut zieke patiënt\r\n\r\nH/H: geen lymfadenopathie, in de mond geen afwijkingen\r\n\r\nCor: normale harttonen, geen souffle\r\n\r\nPulm: normaal doorkomend ademgeruis, geen bijgeluiden\r\n\r\nAbd: normale peristaltiek, wisselende tympani, soepel, geen drukpijn, geen weerstanden\r\n\r\nExtr: rechts normaal warm, met pitting oedeem rondom de enkel, links mediaal van enkel tot knie duidelijke roodheid met induratie, warm, pijnlijk, kuit nog wel soepel\r\n\nConclusie\n1. Cellulitis linkeronderbeen met onvoldoende respons op orale antibiotica, geen porte d\'entree\n2. Ontregelde diabetes mellitus type II bij infectie\n3. Braken bij ziek zijn met goede intake\n\nBeleid\nAlgemeen:\nOpname op Interne Geneeskunde, volledig beleid, vrij dieet\nInfuus 1,5L NaCl 0,9% / 24u\nTijdelijk staken lisinopril en diclofenac bij verminderde intake\nLab herhalen niet nodig\nIntercollegiaal consult dermatologie\n\nT.a.v. 1: Flucloxacilline 4dd 1000mg i.v.\nT.a.v. 2: Bijspuitschema (2-4-6) zo nodig\nT.a.v 3: Metoclopramide 3dd 10mg zo nodig',NULL,NULL,1,'2021-03-19 16:17:49',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL);

/* patient had a couple temp readings over night */
SELECT max(encounter_id)+1 INTO @CURRENT_ENC_ID6 from encounter;
INSERT INTO `encounter` (`encounter_id`,`encounter_type`, `patient_id`, `location_id`, `form_id`, `encounter_datetime`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `changed_by`, `date_changed`, `visit_id`, `uuid`) VALUES
(@CURRENT_ENC_ID6, 7,@CURRENT_PATIENT_ID,6,1,CONCAT(@CLASS_DATE2,' 00:15:31'),1,'2021-03-19 14:21:31',0,NULL,NULL,NULL,NULL,NULL,@CURRENT_VISIT_ID,(select uuid()));
-- uses encounter_id from above
INSERT INTO `encounter_provider` (`encounter_id`, `provider_id`, `encounter_role_id`, `creator`, `date_created`, `changed_by`, `date_changed`, `voided`, `date_voided`, `voided_by`, `void_reason`, `uuid`) VALUES 
(@CURRENT_ENC_ID6,1,2,1,'2021-03-19 14:21:31',NULL,NULL,0,NULL,NULL,NULL,(select uuid()));
-- uses encounter_id from above. each vital meas gets an obs entry. Doesn't seem to use obs_group_id
INSERT INTO `obs` (`person_id`, `concept_id`, `encounter_id`, `order_id`, `obs_datetime`, `location_id`, `obs_group_id`,`accession_number`, `value_group_id`, `value_coded`, `value_coded_name_id`, `value_drug`, `value_datetime`, `value_numeric`, `value_modifier`, `value_text`, `value_complex`, `comments`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `uuid`, `previous_version`, `form_namespace_and_path`, `status`, `interpretation`) VALUES 
(@CURRENT_PATIENT_ID,5088,@CURRENT_ENC_ID6,NULL,CONCAT(@CLASS_DATE2,' 00:15:31'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,37.0,NULL,NULL,NULL,NULL,1,'2021-03-19 14:21:31',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL);

SELECT max(encounter_id)+1 INTO @CURRENT_ENC_ID7 from encounter;
INSERT INTO `encounter` (`encounter_id`,`encounter_type`, `patient_id`, `location_id`, `form_id`, `encounter_datetime`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `changed_by`, `date_changed`, `visit_id`, `uuid`) VALUES
(@CURRENT_ENC_ID7, 7,@CURRENT_PATIENT_ID,6,1,CONCAT(@CLASS_DATE2,' 06:45'),1,'2021-03-19 14:21:31',0,NULL,NULL,NULL,NULL,NULL,@CURRENT_VISIT_ID,(select uuid()));
-- uses encounter_id from above
INSERT INTO `encounter_provider` (`encounter_id`, `provider_id`, `encounter_role_id`, `creator`, `date_created`, `changed_by`, `date_changed`, `voided`, `date_voided`, `voided_by`, `void_reason`, `uuid`) VALUES 
(@CURRENT_ENC_ID7,1,2,1,'2021-03-19 14:21:31',NULL,NULL,0,NULL,NULL,NULL,(select uuid()));
-- uses encounter_id from above. each vital meas gets an obs entry. Doesn't seem to use obs_group_id
INSERT INTO `obs` (`person_id`, `concept_id`, `encounter_id`, `order_id`, `obs_datetime`, `location_id`, `obs_group_id`,`accession_number`, `value_group_id`, `value_coded`, `value_coded_name_id`, `value_drug`, `value_datetime`, `value_numeric`, `value_modifier`, `value_text`, `value_complex`, `comments`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `uuid`, `previous_version`, `form_namespace_and_path`, `status`, `interpretation`) VALUES 
(@CURRENT_PATIENT_ID,5088,@CURRENT_ENC_ID7,NULL,CONCAT(@CLASS_DATE2,' 06:45:31'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,36.5,NULL,NULL,NULL,NULL,1,'2021-03-19 14:21:31',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL);

/* glucose was measured overnight */
INSERT INTO `obs` (`person_id`, `concept_id`, `encounter_id`, `order_id`, `obs_datetime`, `location_id`, `obs_group_id`,`accession_number`, `value_group_id`, `value_coded`, `value_coded_name_id`, `value_drug`, `value_datetime`, `value_numeric`, `value_modifier`, `value_text`, `value_complex`, `comments`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `uuid`, `previous_version`, `form_namespace_and_path`, `status`, `interpretation`) VALUES 
(@CURRENT_PATIENT_ID,169743,NULL,NULL,CONCAT(@CLASS_DATE2,' 06:33:00'),NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,12.0,NULL,NULL,NULL,'mmol/L',1,'2021-03-19 15:07:12',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL);

/* lisinopril 166329 and diclofenac were temporarily discontinued */
/* TODO does not work correctly in my instance, but probably it is one of these two actions */
UPDATE orders SET order_action = 'DISCONTINUE' WHERE patient_id = @CURRENT_PATIENT_ID and concept_id in(166329,167867);
-- UPDATE orders SET date_stopped = CONCAT(@CLASS_DATE,' 22:05:00') WHERE patient_id = @CURRENT_PATIENT_ID and concept_id in(166329,167867);

SELECT max(encounter_id)+1 INTO @CURRENT_ENC_ID8 from encounter;
INSERT INTO `encounter` (`encounter_id`,`encounter_type`, `patient_id`, `location_id`, `form_id`, `encounter_datetime`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `changed_by`, `date_changed`, `visit_id`, `uuid`) VALUES
(@CURRENT_ENC_ID8,3,@CURRENT_PATIENT_ID,6,2,CONCAT(@CLASS_DATE2,' 06:20:39'),1,'2021-03-20 15:20:39',0,NULL,NULL,NULL,NULL,NULL,@CURRENT_VISIT_ID,(select uuid()));

INSERT INTO `encounter_provider` (`encounter_id`, `provider_id`, `encounter_role_id`, `creator`, `date_created`, `changed_by`, `date_changed`, `voided`, `date_voided`, `voided_by`, `void_reason`, `uuid`) VALUES 
(@CURRENT_ENC_ID8,1,1,1,'2021-03-20 15:20:39',NULL,NULL,0,NULL,NULL,NULL,(select uuid()));

SELECT max(obs_id)+1 INTO @CURRENT_OBS_ID3 from obs;
INSERT INTO `obs` VALUES
(@CURRENT_OBS_ID3,192,159947,4990,NULL,'2021-03-20 15:20:39',6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'2021-03-20 15:20:39',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_OBS_ID3+1,@CURRENT_PATIENT_ID,159946,@CURRENT_ENC_ID8,NULL,CONCAT(@CLASS_DATE2,' 06:20:39'),6,@CURRENT_OBS_ID3,NULL,NULL,159943,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'2021-03-20 15:20:39',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_OBS_ID3+2,@CURRENT_PATIENT_ID,159394,@CURRENT_ENC_ID8,NULL,CONCAT(@CLASS_DATE2,' 06:20:39'),6,@CURRENT_OBS_ID3,NULL,NULL,159393,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'2021-03-20 15:20:39',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_OBS_ID3+3,@CURRENT_PATIENT_ID,161602,@CURRENT_ENC_ID8,NULL,CONCAT(@CLASS_DATE2,' 06:20:39'),6,@CURRENT_OBS_ID3,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'cellulitis',NULL,NULL,1,'2021-03-20 15:20:39',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_OBS_ID3+4,@CURRENT_PATIENT_ID,162169,@CURRENT_ENC_ID8,NULL,CONCAT(@CLASS_DATE2,' 06:20:39'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'RvO/ Cellulitis \r\n\r\nVPK/ Hoog glucose, infuus gesneuveld, nog koorts, verder geen bijzonderheden. \r\n\r\n A/ Patiënt meldde dat been nog wel rood en pijnlijk is; toe- of afname is onduidelijk. Ook misselijkheid nog niet volledig hersteld. Diabetes thuis waarschijnlijk slecht gereguleerd. \r\n\r\n LO/ T 38,4°C, P 88/min, RR 134/86mmHg, AH 8/min, sat 98%. Linkeronderbeen nog duidelijk rood en warm, binnen afgetekende gebied (maar net afgetekend). \r\n\r\nAO/ Niet verricht. \r\n\r\nC/ Cellulitis, ontregelde diabetes en braken \r\n\r\nB/ Infuus staken, verder zo door. Morgen lab. ',NULL,NULL,1,'2021-03-20 15:20:39',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL);

/* TODO
CRP 40 mg/l 
Leukocyten 9,1 * 10^9/l 
Na 143 mmol/l 
K 4,0 mmol/l 
*//*
Kreatinine 76 umol/l 
eGFR 59 ml/min/m2 
*/
INSERT INTO `obs` (`person_id`, `concept_id`, `encounter_id`, `order_id`, `obs_datetime`, `location_id`, `obs_group_id`,`accession_number`, `value_group_id`, `value_coded`, `value_coded_name_id`, `value_drug`, `value_datetime`, `value_numeric`, `value_modifier`, `value_text`, `value_complex`, `comments`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `uuid`, `previous_version`, `form_namespace_and_path`, `status`, `interpretation`) VALUES 
(@CURRENT_PATIENT_ID,169763,NULL,NULL,CONCAT(@CLASS_DATE2,' 06:25:00'),NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,76,NULL,NULL,NULL,'umol/l',1,'2021-03-19 15:00:30',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_PATIENT_ID,169764,NULL,NULL,CONCAT(@CLASS_DATE2,' 06:25:00'),NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,59,NULL,NULL,NULL,'ml/min/m2',1,'2021-03-19 15:01:46',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL);

/* TODO add appt with dermatology */

/* ------------ end repeating Monday and Tuesday ------------------------ */

/* add vitals */
SELECT max(encounter_id)+1 INTO @CURRENT_ENC_ID9 from encounter;
INSERT INTO `encounter` (`encounter_id`,`encounter_type`, `patient_id`, `location_id`, `form_id`, `encounter_datetime`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `changed_by`, `date_changed`, `visit_id`, `uuid`) VALUES
(@CURRENT_ENC_ID9, 7,@CURRENT_PATIENT_ID,6,1,CONCAT(@CLASS_DATE3,' 05:50:31'),1,'2021-03-19 14:21:31',0,NULL,NULL,NULL,NULL,NULL,@CURRENT_VISIT_ID,(select uuid()));
-- uses encounter_id from above
INSERT INTO `encounter_provider` (`encounter_id`, `provider_id`, `encounter_role_id`, `creator`, `date_created`, `changed_by`, `date_changed`, `voided`, `date_voided`, `voided_by`, `void_reason`, `uuid`) VALUES 
(@CURRENT_ENC_ID9,1,2,1,'2021-03-19 14:21:31',NULL,NULL,0,NULL,NULL,NULL,(select uuid()));
-- uses encounter_id from above. each vital meas gets an obs entry. Doesn't seem to use obs_group_id
INSERT INTO `obs` (`person_id`, `concept_id`, `encounter_id`, `order_id`, `obs_datetime`, `location_id`, `obs_group_id`,`accession_number`, `value_group_id`, `value_coded`, `value_coded_name_id`, `value_drug`, `value_datetime`, `value_numeric`, `value_modifier`, `value_text`, `value_complex`, `comments`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `uuid`, `previous_version`, `form_namespace_and_path`, `status`, `interpretation`) VALUES 
(@CURRENT_PATIENT_ID,5088,@CURRENT_ENC_ID9,NULL,CONCAT(@CLASS_DATE3,' 05:50:31'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,37.5,NULL,NULL,NULL,NULL,1,'2021-03-19 14:21:31',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_PATIENT_ID,5087,@CURRENT_ENC_ID9,NULL,CONCAT(@CLASS_DATE3,' 05:50:31'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,82,NULL,NULL,NULL,NULL,1,'2021-03-19 14:21:31',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_PATIENT_ID,5242,@CURRENT_ENC_ID9,NULL,CONCAT(@CLASS_DATE3,' 05:50:31'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,10,NULL,NULL,NULL,NULL,1,'2021-03-19 14:21:31',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_PATIENT_ID,5085,@CURRENT_ENC_ID9,NULL,CONCAT(@CLASS_DATE3,' 05:50:31'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,138,NULL,NULL,NULL,NULL,1,'2021-03-19 14:21:31',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_PATIENT_ID,5086,@CURRENT_ENC_ID9,NULL,CONCAT(@CLASS_DATE3,' 05:50:31'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,88,NULL,NULL,NULL,NULL,1,'2021-03-19 14:21:31',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_PATIENT_ID,5092,@CURRENT_ENC_ID9,NULL,CONCAT(@CLASS_DATE3,' 05:50:31'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,98,NULL,NULL,NULL,NULL,1,'2021-03-19 14:21:31',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL);

/* add visit note and the associated visit diagnosis */
SELECT max(encounter_id)+1 INTO @CURRENT_ENC_ID10 from encounter;
INSERT INTO `encounter` (`encounter_id`,`encounter_type`, `patient_id`, `location_id`, `form_id`, `encounter_datetime`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `changed_by`, `date_changed`, `visit_id`, `uuid`) VALUES
(@CURRENT_ENC_ID10,3,@CURRENT_PATIENT_ID,6,2,CONCAT(@CLASS_DATE3,' 07:06:30'),1,'2021-03-19 16:17:21',0,NULL,NULL,NULL,NULL,NULL,@CURRENT_VISIT_ID,(select uuid()));
-- uses encounter_id from the above encounter
INSERT INTO `encounter_provider` (`encounter_id`, `provider_id`, `encounter_role_id`, `creator`, `date_created`, `changed_by`, `date_changed`, `voided`, `date_voided`, `voided_by`, `void_reason`, `uuid`) VALUES 
(@CURRENT_ENC_ID10,1,1,1,'2021-03-19 16:17:21',NULL,NULL,0,NULL,NULL,NULL,(select uuid()));
SELECT max(obs_id)+1 INTO @CURRENT_OBS_ID4 from obs;
INSERT INTO `obs` VALUES
(@CURRENT_OBS_ID4,192,159947,4990,NULL,'2021-03-20 15:20:39',6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'2021-03-20 15:20:39',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_OBS_ID4+1,@CURRENT_PATIENT_ID,159946,@CURRENT_ENC_ID10,NULL,CONCAT(@CLASS_DATE3,' 07:06:30'),6,@CURRENT_OBS_ID3,NULL,NULL,159943,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'2021-03-20 15:20:39',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_OBS_ID4+2,@CURRENT_PATIENT_ID,159394,@CURRENT_ENC_ID10,NULL,CONCAT(@CLASS_DATE3,' 07:06:30'),6,@CURRENT_OBS_ID3,NULL,NULL,159393,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'2021-03-20 15:20:39',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_OBS_ID4+3,@CURRENT_PATIENT_ID,161602,@CURRENT_ENC_ID10,NULL,CONCAT(@CLASS_DATE3,' 07:06:30'),6,@CURRENT_OBS_ID3,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'cellulitis',NULL,NULL,1,'2021-03-20 15:20:39',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_OBS_ID4+4,@CURRENT_PATIENT_ID,162169,@CURRENT_ENC_ID10,NULL,CONCAT(@CLASS_DATE3,' 07:06:30'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'RvO/ Cellulitis \r\n\r\n VPK/ Hoog glucose, koorts en braken verdwenen.  \r\n\r\n  A/ Patiënt meldde dat been misschien wel iets minder pijnlijk wordt. Voelt zich een stuk beter  \r\n\r\n  LO/ T 37,5°C, P 82/min, RR 138/88mmHg, AH 10/min, sat 98%. Linkeronderbeen nog duidelijk rood en warm, nu verder binnen afgetekende gebied dan eerder, dus afname. \r\n\r\n AO/ Inflammatieparameters dalen, kreatinine iets gestegen bij status na braken. \r\n\r\n C/ Herstellende cellulitis, regulatie diabetes verbetert.  \r\n\r\n B/ Nog een dag i.v.-antibiotica en dan inplannen ontslag.  ',NULL,NULL,1,'2021-03-20 15:20:39',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL);


/************************ DONDERDAG *************************/

-- in my system IrmaDonderdag will be identical to Woensdag; in the AMC system she'll need attachments.


/* cleaning up tests:
UPDATE person_name SET family_name = 'Andriessen', given_name = CONCAT('IrmaTest', person_id -191) WHERE family_name = 'Andriessen1';
UPDATE patient_identifier SET identifier = CONCAT('10000',patient_id) WHERE identifier LIKE '777777%'; 
*/