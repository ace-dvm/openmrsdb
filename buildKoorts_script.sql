-- IMPORTANT: After inserting new patients, rebuild the search index: Legacy page. Administration>Advance Adminstration. Check for Search Index under Maintenance item
-- probably want to set this externally with a script
SET @STUDENT_ID := 1;
SET @CLASS_DATE := '2021-03-30';
SET @CLASS_DATE2 := '2021-03-31';
SET @CLASS_DATE3 := '2021-04-01';
SET @CLASS_DATE4 := '2021-04-02';
SET @CLASS_DATE5 := '2021-04-03';
SET @CURRENT_PATIENT_IDENTIFIER := 77777700006; -- Arbitrary prefix of six 7's.

/* TODO add attachments */

/* A. de Vries
This will build one complete instance of A.
The script assumes you're running the whole thing at once. Variables might not be set correctly if it's not executed as a whole.

/************************ DINSDAG *************************/
SET @DAY_OF_WEEK := 'Dinsdag';
SET @ORDCOUNT := 0; -- first order is always ORD-1, second is ORD-2, etc.

SELECT max(person_id)+1 INTO @DAUGHTER_PID from person;
SET @DAUGHTER_PIDENTIFIER := 77777700005;
SELECT max(person_id)+2 INTO @CURRENT_PATIENT_ID from person;

/* add the daughter first */
INSERT INTO `person` VALUES(@DAUGHTER_PID,'F','2001-01-01',0,0,NULL,NULL,1,'2021-03-19 10:36:22',NULL,NULL,0,NULL,NULL,NULL,(select UUID()),0,NULL);
INSERT INTO `patient` VALUES (@DAUGHTER_PID,1,'2021-03-19 10:36:22',NULL,NULL,0,NULL,NULL,NULL,'Unknown');
INSERT INTO `patient_identifier` (`patient_id`, `identifier`, `identifier_type`, `preferred`, `location_id`, `creator`, `date_created`, `date_changed`, `changed_by`, `voided`, `voided_by`, `date_voided`, `void_reason`, `uuid`) VALUES 
(@DAUGHTER_PID,@DAUGHTER_PIDENTIFIER,3,1,6,1,'2021-03-19 10:36:23',NULL,NULL,0,NULL,NULL,NULL,(select UUID()));

INSERT INTO `person_address` (`person_id`, `preferred`, `address1`, `address2`, `city_village`, `state_province`, `postal_code`, `country`, `latitude`, `longitude`, `start_date`, `end_date`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `county_district`, `address3`, `address4`, `address5`, `address6`, `date_changed`, `changed_by`, `uuid`, `address7`, `address8`, `address9`, `address10`, `address11`, `address12`, `address13`, `address14`, `address15`) VALUES  
(@DAUGHTER_PID,1,NULL,NULL,'Loosdrecht',NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'2021-03-19 10:36:23',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,(select UUID()),NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `person_attribute` (`person_id`, `value`, `person_attribute_type_id`, `creator`, `date_created`, `changed_by`, `date_changed`, `voided`, `voided_by`, `date_voided`, `void_reason`, `uuid`) VALUES 
(@DAUGHTER_PID,'0687654321',8,1,'2021-03-19 10:36:23',NULL,NULL,0,NULL,NULL,NULL,(select UUID()));
INSERT INTO `person_name` (`preferred`, `person_id`, `prefix`, `given_name`, `middle_name`, `family_name_prefix`, `family_name`, `family_name2`, `family_name_suffix`, `degree`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `changed_by`, `date_changed`, `uuid`) VALUES 
(1,@DAUGHTER_PID,NULL,'S.',NULL,NULL,CONCAT('de Vries',@STUDENT_ID),NULL,NULL,NULL,1,'2021-03-19 10:36:23',0,NULL,NULL,NULL,NULL,NULL,(select UUID()));

/* add patient */
INSERT INTO `person` VALUES(@CURRENT_PATIENT_ID,'F','1977-10-01',0,0,NULL,NULL,1,'2021-03-19 10:36:22',NULL,NULL,0,NULL,NULL,NULL,(select UUID()),0,NULL);
INSERT INTO `patient` VALUES (@CURRENT_PATIENT_ID,1,'2021-03-19 10:36:22',NULL,NULL,0,NULL,NULL,NULL,'Unknown');
INSERT INTO `patient_identifier` (`patient_id`, `identifier`, `identifier_type`, `preferred`, `location_id`, `creator`, `date_created`, `date_changed`, `changed_by`, `voided`, `voided_by`, `date_voided`, `void_reason`, `uuid`) VALUES 
(@CURRENT_PATIENT_ID,@CURRENT_PATIENT_IDENTIFIER,3,1,6,1,'2021-03-19 10:36:23',NULL,NULL,0,NULL,NULL,NULL,(select UUID()));

INSERT INTO `person_address` (`person_id`, `preferred`, `address1`, `address2`, `city_village`, `state_province`, `postal_code`, `country`, `latitude`, `longitude`, `start_date`, `end_date`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `county_district`, `address3`, `address4`, `address5`, `address6`, `date_changed`, `changed_by`, `uuid`, `address7`, `address8`, `address9`, `address10`, `address11`, `address12`, `address13`, `address14`, `address15`) VALUES  
(@CURRENT_PATIENT_ID,1,'Oud Loosdrecht Dijk 1',NULL,'Loosdrecht',NULL,'1234 AA',NULL,NULL,NULL,NULL,NULL,1,'2021-03-19 10:36:23',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,(select UUID()),NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `person_attribute` (`person_id`, `value`, `person_attribute_type_id`, `creator`, `date_created`, `changed_by`, `date_changed`, `voided`, `voided_by`, `date_voided`, `void_reason`, `uuid`) VALUES 
(@CURRENT_PATIENT_ID,'0612345678',8,1,'2021-03-19 10:36:23',NULL,NULL,0,NULL,NULL,NULL,(select UUID()));
INSERT INTO `person_name` (`preferred`, `person_id`, `prefix`, `given_name`, `middle_name`, `family_name_prefix`, `family_name`, `family_name2`, `family_name_suffix`, `degree`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `changed_by`, `date_changed`, `uuid`) VALUES 
(1,@CURRENT_PATIENT_ID,NULL,CONCAT('A.',@DAY_OF_WEEK),NULL,NULL,CONCAT('de Vries',@STUDENT_ID),NULL,NULL,NULL,1,'2021-03-19 10:36:23',0,NULL,NULL,NULL,NULL,NULL,(select UUID()));

/* add patient relations */
INSERT INTO `relationship` (`person_a`, `relationship`, `person_b`, `start_date`, `end_date`, `creator`, `date_created`, `date_changed`, `changed_by`, `voided`, `voided_by`, `date_voided`, `void_reason`, `uuid`) VALUES
(@CURRENT_PATIENT_ID,3,@DAUGHTER_PID,NULL,NULL,1,'2021-03-19 10:36:23',NULL,NULL,0,NULL,NULL,NULL,(select uuid()));

/* add meds: Each drug order creates an entry in encounter, encounter_provider, orders, and drug_order. */
-- drug order encounters don't have a visit_id
-- technically it is perfectly safe to reset CURRENT_ENC_ID rather than making a new variable, but since the two aren't equal I'm making different vars.
SELECT max(encounter_id)+1 INTO @CURRENT_ENC_ID from encounter;
INSERT INTO `encounter` (`encounter_id`, `encounter_type`, `patient_id`, `location_id`, `form_id`, `encounter_datetime`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `changed_by`, `date_changed`, `visit_id`, `uuid`) VALUES  
(@CURRENT_ENC_ID,8,@CURRENT_PATIENT_ID,NULL,NULL,CONCAT(@CLASS_DATE,' 13:32:04'),1,'2021-03-19 13:32:04',0,NULL,NULL,NULL,NULL,NULL,NULL,(select UUID()));
INSERT INTO `encounter_provider` (`encounter_id`, `provider_id`, `encounter_role_id`, `creator`, `date_created`, `changed_by`, `date_changed`, `voided`, `date_voided`, `voided_by`, `void_reason`, `uuid`) VALUES  
(@CURRENT_ENC_ID,1,2,1,'2021-03-19 13:32:04',NULL,NULL,0,NULL,NULL,NULL,(select uuid()));
-- Order uses encounter_id. Orders that share an encounter_id were signed together.
SELECT max(order_id)+1 INTO @CURRENT_ORD_ID from orders; -- We will count on the orders being inserted sequentially
INSERT INTO `orders` (`order_id`,`order_type_id`, `concept_id`, `orderer`, `encounter_id`, `instructions`, `date_activated`, `auto_expire_date`, `date_stopped`, `order_reason`, `order_reason_non_coded`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `patient_id`, `accession_number`, `uuid`, `urgency`, `order_number`, `previous_order_id`, `order_action`, `comment_to_fulfiller`, `care_setting`, `scheduled_date`, `order_group_id`, `sort_weight`) VALUES 
(@CURRENT_ORD_ID, 2,166299,1,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE,' 13:32:04'),NULL,NULL,NULL,NULL,1,'2021-03-19 13:32:04',0,NULL,NULL,NULL,@CURRENT_PATIENT_ID,NULL,(select uuid()),'ROUTINE',CONCAT('ORD-',@ORDCOUNT+1),NULL,'NEW',NULL,1,NULL,NULL,NULL),
(@CURRENT_ORD_ID +1, 2,165680,1,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE,' 12:58:25'),NULL,NULL,NULL,NULL,1,'2021-03-19 13:32:04',0,NULL,NULL,NULL,@CURRENT_PATIENT_ID,NULL,(select uuid()),'ROUTINE',CONCAT('ORD-',@ORDCOUNT +2),NULL,'NEW',NULL,1,NULL,NULL,NULL);

SET @ORDCOUNT := @ORDCOUNT +2;
-- uses the order_id from the above orders
-- dose is just the literal number entered for the dose (100 mg and 10 mg respectively, in this case)
-- dosing_instructions free text shows up in the summary, structured info does not
-- quantity_units 1513 = tablet; 1514 = packet
-- route 160240 = oral
-- dose_units 161553 = mg
-- frequency 16 = once daily, 11 = twice daily
INSERT INTO `drug_order` (`order_id`, `drug_inventory_id`, `dose`, `as_needed`, `dosing_type`, `quantity`, 
`as_needed_condition`, `num_refills`, `dosing_instructions`, `duration`, `duration_units`, `quantity_units`, 
`route`, `dose_units`, `frequency`, `brand_name`, `dispense_as_written`, `drug_non_coded`) VALUES 
(@CURRENT_ORD_ID,23,100,0,'org.openmrs.SimpleDosingInstructions',90,NULL,0,'1 dd 100 mg',NULL,NULL,1514,160240,161553,16,NULL,0,NULL),
(@CURRENT_ORD_ID +1,67,10,0,'org.openmrs.SimpleDosingInstructions',90,NULL,0,'1 dd 10 mg',NULL,NULL,1513,160240,161553,16,NULL,0,NULL);


/* TODO add
Ciclosporine 2 dd 300 mg 
Cotrimoxazol 1 dd 480 mg 
Hypromellose 3 mg/ml oogdruppels 4 dd zn 
Macrogol/zouten sachet 1 dd 1 zn 
Metoclopramide 3 dd 10 mg zn 
Magnesiumgluconaat 2 dd 1 gr 
Omeprazol 1 dd 40 mg 
Valaciclovir 2 dd 500 mg 
*/

/* start visit */
SELECT max(visit_id)+1 INTO @CURRENT_VISIT_ID from visit;
INSERT INTO `visit` (`visit_id`,`patient_id`, `visit_type_id`, `date_started`, `date_stopped`, `indication_concept_id`, `location_id`, `creator`, `date_created`, `changed_by`, `date_changed`, `voided`, `voided_by`, `date_voided`, `void_reason`, `uuid`) VALUES 
(@CURRENT_VISIT_ID, @CURRENT_PATIENT_ID,1,CONCAT(@CLASS_DATE,' 13:12:39'),NULL,NULL,8,1,'2021-03-19 13:12:39',NULL,NULL,0,NULL,NULL,NULL, (select UUID()));

/* add visit diagnosis and note*/
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
(@CURRENT_PATIENT_ID,1284,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE,' 13:27:14'),6,@CURRENT_OBS_ID,NULL,NULL,121629,127494,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'2021-03-19 13:27:14',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_PATIENT_ID,162169,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE,' 13:27:14'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Opnamestatus op dinsdag \nVoorgeschiedenis: \nRefractair Hodgkin lymfoom (HL) wv allogene stamceltransplantatie (nov-2020) 01-04-2019 Prioriteit: Hoog \nIntentietremor zonder sensibiliteits- of motorische uitval DD bijwerking bij ciclosporine (>10%) 15-12-2020 \nstent in RCA 01-01-2017 \ninspanningsgerelateerde astma 01-01-1995 \n\nMedicatie bij opname: \nAmlodipine 1 dd 10 mg \nCarbasalaatcalcium poeder 1 dd 100 mg \nCiclosporine 2 dd 300 mg \nCotrimoxazol 1 dd 480 mg \nHypromellose 3 mg/ml oogdruppels 4 dd zn \nMacrogol/zouten sachet 1 dd 1 zn \nMetoclopramide 3 dd 10 mg zn \nMagnesiumgluconaat 2 dd 1 gr \nOmeprazol 1 dd 40 mg \nValaciclovir 2 dd 500 mg \n\nIntoxicaties: Geen \nAllergieën: Niet voor zover bekend \n\nRvO/ anemie bij status na refractair Hodgkin lymfoom waarvoor allogene stamceltransplantatie (+3 maanden) \n\nAnamnese: \nWas vorige week nog op policontrole geweest, ging toen wel goed. Echter sinds 2 dagen toenemend vermoeid, geen energie meer. Hierop belde zij naar de SEH en is derhalve gekomen. Eetlust is nog matig, maar onveranderd sinds de stamceltransplantatie. Niet misselijk of braken, ook geen diarree. Mictie iets branderig, maar niet hele tijd. Niet ziek geweest, klein hoestje, soms wat kortademig gevoel, wisselend aanwezig. Geen koorts bemerkt. Geen huidafwijkingen gezien. \n\nTractus anamnese: behoudens iets vocht vasthouden in de benen, geen bijzonderheden. \n\nLichamelijk onderzoek: \nT 36.8°C, P 85/min, RR 126/86mmHg, AH 16/min, O2-sat 98% zonder O2-suppletie  \nAlgemene indruk: helder, niet acuut zieke, maar wel zwak ogende patiënte \nH/H: in de mond geen afwijkingen, geen lymfadenopathie \nCor: normale harttonen, geen souffles \nPulm: normaal ademgeruis zonder bijgeluiden \nAbd: normale peristaltiek, wisselende tympanie, soepel, geen drukpijn, geen weerstanden \nExtr: iets pitting oedeem rondom de enkels, goed voelbare pulsaties  \n\nAO/ laag Hb, iets verhoogd CRP\n \nC/ \n1. Symptomatisch anemie  \n2. Ruim 3 maanden na stamceltransplantatie in verband met HL\n\nB/ \nAd 1 \nOpname op acute opname afdeling voor 2 erytrocyten transfusies (bestraald/parvo-B19 veilig) \nVolledig beleid, normaal dieet \nDoor met thuismedicatie \nIn principe morgenochtend naar huis',NULL,NULL,1,'2021-03-19 16:17:49',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL);

/* add vitals */
SELECT max(encounter_id)+1 INTO @CURRENT_ENC_ID from encounter;
INSERT INTO `encounter` (`encounter_id`,`encounter_type`, `patient_id`, `location_id`, `form_id`, `encounter_datetime`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `changed_by`, `date_changed`, `visit_id`, `uuid`) VALUES
(@CURRENT_ENC_ID, 7,@CURRENT_PATIENT_ID,6,1,CONCAT(@CLASS_DATE,' 14:21:31'),1,'2021-03-19 14:21:31',0,NULL,NULL,NULL,NULL,NULL,@CURRENT_VISIT_ID,(select uuid()));
-- uses encounter_id from above
INSERT INTO `encounter_provider` (`encounter_id`, `provider_id`, `encounter_role_id`, `creator`, `date_created`, `changed_by`, `date_changed`, `voided`, `date_voided`, `voided_by`, `void_reason`, `uuid`) VALUES 
(@CURRENT_ENC_ID,1,2,1,'2021-03-19 14:21:31',NULL,NULL,0,NULL,NULL,NULL,(select uuid()));
-- uses encounter_id from above. each vital meas gets an obs entry. Doesn't seem to use obs_group_id 
INSERT INTO `obs` (`person_id`, `concept_id`, `encounter_id`, `order_id`, `obs_datetime`, `location_id`, `obs_group_id`,`accession_number`, `value_group_id`, `value_coded`, `value_coded_name_id`, `value_drug`, `value_datetime`, `value_numeric`, `value_modifier`, `value_text`, `value_complex`, `comments`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `uuid`, `previous_version`, `form_namespace_and_path`, `status`, `interpretation`) VALUES 
(@CURRENT_PATIENT_ID,5088,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE,' 14:21:31'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,36.8,NULL,NULL,NULL,NULL,1,'2021-03-19 14:21:31',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_PATIENT_ID,5087,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE,' 14:21:31'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,85,NULL,NULL,NULL,NULL,1,'2021-03-19 14:21:31',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_PATIENT_ID,5242,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE,' 14:21:31'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16,NULL,NULL,NULL,NULL,1,'2021-03-19 14:21:31',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_PATIENT_ID,5085,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE,' 14:21:31'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,126,NULL,NULL,NULL,NULL,1,'2021-03-19 14:21:31',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_PATIENT_ID,5086,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE,' 14:21:31'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,86,NULL,NULL,NULL,NULL,1,'2021-03-19 14:21:31',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_PATIENT_ID,5092,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE,' 14:21:31'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,98,NULL,NULL,NULL,NULL,1,'2021-03-19 14:21:31',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL);

/* admit patient */
SELECT max(encounter_id)+1 INTO @CURRENT_ENC_ID from encounter;
INSERT INTO `encounter` (`encounter_id`, `encounter_type`, `patient_id`, `location_id`, `form_id`, `encounter_datetime`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `changed_by`, `date_changed`, `visit_id`, `uuid`) VALUES
(@CURRENT_ENC_ID,2,@CURRENT_PATIENT_ID,9,3,CONCAT(@CLASS_DATE,' 14:38:05'),1,'2021-03-19 14:38:05',0,NULL,NULL,NULL,NULL,NULL,@CURRENT_VISIT_ID,(select uuid()));

-- uses encounter_id from above
INSERT INTO `encounter_provider` (`encounter_id`, `provider_id`, `encounter_role_id`, `creator`, `date_created`, `changed_by`, `date_changed`, `voided`, `date_voided`, `voided_by`, `void_reason`, `uuid`) VALUES 
(@CURRENT_ENC_ID,1,1,1,'2021-03-19 14:38:05',NULL,NULL,0,NULL,NULL,NULL,(select uuid()));

/*TODO add 2 erytrocyten transfusies */

/* labs */
INSERT INTO `obs` (`person_id`, `concept_id`, `encounter_id`, `order_id`, `obs_datetime`, `location_id`, `obs_group_id`,`accession_number`, `value_group_id`, `value_coded`, `value_coded_name_id`, `value_drug`, `value_datetime`, `value_numeric`, `value_modifier`, `value_text`, `value_complex`, `comments`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `uuid`, `previous_version`, `form_namespace_and_path`, `status`, `interpretation`) VALUES 
(@CURRENT_PATIENT_ID,169763,NULL,NULL,@CLASS_DATE,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,78,NULL,NULL,NULL,'',1,'2021-04-09 17:35:51',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL), -- Kreatinine	umol/l	65-95		78
(@CURRENT_PATIENT_ID,169764,NULL,NULL,@CLASS_DATE,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,90,NULL,NULL,NULL,'> 90',1,'2021-04-09 17:37:15',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL), -- eGFR (CKD-EPI)	ml/min/1,73m^2		>90
(@CURRENT_PATIENT_ID,169743,NULL,NULL,@CLASS_DATE,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,5.6,NULL,NULL,NULL,'',1,'2021-04-09 17:43:52',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL), -- Glucose	mmol/l	4,1-5,6			5,9
(@CURRENT_PATIENT_ID,169775,NULL,NULL,@CLASS_DATE,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,19,NULL,NULL,NULL,'',1,'2021-04-09 17:44:29',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL), -- Bilirubine (totaal)	umol/l	0-17	19
(@CURRENT_PATIENT_ID,169770,NULL,NULL,@CLASS_DATE,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16,NULL,NULL,NULL,'',1,'2021-04-09 17:48:02',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL), -- aspartate aminotransferase (AST)	16
(@CURRENT_PATIENT_ID,169769,NULL,NULL,@CLASS_DATE,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,51,NULL,NULL,NULL,'',1,'2021-04-09 17:49:07',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL), -- alanine aminotransferase (ALT)		51
(@CURRENT_PATIENT_ID,169771,NULL,NULL,@CLASS_DATE,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,127,NULL,NULL,NULL,'',1,'2021-04-09 17:50:21',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL), -- Gamma-glutamyl transferase (GGT)	127
(@CURRENT_PATIENT_ID,169768,NULL,NULL,@CLASS_DATE,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,71,NULL,NULL,NULL,'',1,'2021-04-09 17:51:11',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL); -- Alkaline phosphatase (ALKP)		71


/************************ WOENSDAG *************************/
SET @DAY_OF_WEEK := 'Woensdag';
SET @CURRENT_PATIENT_IDENTIFIER := @CURRENT_PATIENT_IDENTIFIER +1;
SET @ORDCOUNT := 0; -- first order is always ORD-1, second is ORD-2, etc.

SELECT max(person_id)+1 INTO @CURRENT_PATIENT_ID from person;

/* add patient */
INSERT INTO `person` VALUES(@CURRENT_PATIENT_ID,'F','1977-10-01',0,0,NULL,NULL,1,'2021-03-19 10:36:22',NULL,NULL,0,NULL,NULL,NULL,(select UUID()),0,NULL);
INSERT INTO `patient` VALUES (@CURRENT_PATIENT_ID,1,'2021-03-19 10:36:22',NULL,NULL,0,NULL,NULL,NULL,'Unknown');
INSERT INTO `patient_identifier` (`patient_id`, `identifier`, `identifier_type`, `preferred`, `location_id`, `creator`, `date_created`, `date_changed`, `changed_by`, `voided`, `voided_by`, `date_voided`, `void_reason`, `uuid`) VALUES 
(@CURRENT_PATIENT_ID,@CURRENT_PATIENT_IDENTIFIER,3,1,6,1,'2021-03-19 10:36:23',NULL,NULL,0,NULL,NULL,NULL,(select UUID()));

INSERT INTO `person_address` (`person_id`, `preferred`, `address1`, `address2`, `city_village`, `state_province`, `postal_code`, `country`, `latitude`, `longitude`, `start_date`, `end_date`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `county_district`, `address3`, `address4`, `address5`, `address6`, `date_changed`, `changed_by`, `uuid`, `address7`, `address8`, `address9`, `address10`, `address11`, `address12`, `address13`, `address14`, `address15`) VALUES  
(@CURRENT_PATIENT_ID,1,'Oud Loosdrecht Dijk 1',NULL,'Loosdrecht',NULL,'1234 AA',NULL,NULL,NULL,NULL,NULL,1,'2021-03-19 10:36:23',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,(select UUID()),NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `person_attribute` (`person_id`, `value`, `person_attribute_type_id`, `creator`, `date_created`, `changed_by`, `date_changed`, `voided`, `voided_by`, `date_voided`, `void_reason`, `uuid`) VALUES 
(@CURRENT_PATIENT_ID,'0612345678',8,1,'2021-03-19 10:36:23',NULL,NULL,0,NULL,NULL,NULL,(select UUID()));
INSERT INTO `person_name` (`preferred`, `person_id`, `prefix`, `given_name`, `middle_name`, `family_name_prefix`, `family_name`, `family_name2`, `family_name_suffix`, `degree`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `changed_by`, `date_changed`, `uuid`) VALUES 
(1,@CURRENT_PATIENT_ID,NULL,CONCAT('A.',@DAY_OF_WEEK),NULL,NULL,CONCAT('de Vries',@STUDENT_ID),NULL,NULL,NULL,1,'2021-03-19 10:36:23',0,NULL,NULL,NULL,NULL,NULL,(select UUID()));

/* add patient relations */
INSERT INTO `relationship` (`person_a`, `relationship`, `person_b`, `start_date`, `end_date`, `creator`, `date_created`, `date_changed`, `changed_by`, `voided`, `voided_by`, `date_voided`, `void_reason`, `uuid`) VALUES
(@CURRENT_PATIENT_ID,3,@DAUGHTER_PID,NULL,NULL,1,'2021-03-19 10:36:23',NULL,NULL,0,NULL,NULL,NULL,(select uuid()));

/* copy tuesday*

/* add meds: Each drug order creates an entry in encounter, encounter_provider, orders, and drug_order. */
-- drug order encounters don't have a visit_id
-- technically it is perfectly safe to reset CURRENT_ENC_ID rather than making a new variable, but since the two aren't equal I'm making different vars.
SELECT max(encounter_id)+1 INTO @CURRENT_ENC_ID from encounter;
INSERT INTO `encounter` (`encounter_id`, `encounter_type`, `patient_id`, `location_id`, `form_id`, `encounter_datetime`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `changed_by`, `date_changed`, `visit_id`, `uuid`) VALUES  
(@CURRENT_ENC_ID,8,@CURRENT_PATIENT_ID,NULL,NULL,CONCAT(@CLASS_DATE,' 13:32:04'),1,'2021-03-19 13:32:04',0,NULL,NULL,NULL,NULL,NULL,NULL,(select UUID()));
INSERT INTO `encounter_provider` (`encounter_id`, `provider_id`, `encounter_role_id`, `creator`, `date_created`, `changed_by`, `date_changed`, `voided`, `date_voided`, `voided_by`, `void_reason`, `uuid`) VALUES  
(@CURRENT_ENC_ID,1,2,1,'2021-03-19 13:32:04',NULL,NULL,0,NULL,NULL,NULL,(select uuid()));
-- Order uses encounter_id. Orders that share an encounter_id were signed together.
SELECT max(order_id)+1 INTO @CURRENT_ORD_ID from orders; -- We will count on the orders being inserted sequentially
INSERT INTO `orders` (`order_id`,`order_type_id`, `concept_id`, `orderer`, `encounter_id`, `instructions`, `date_activated`, `auto_expire_date`, `date_stopped`, `order_reason`, `order_reason_non_coded`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `patient_id`, `accession_number`, `uuid`, `urgency`, `order_number`, `previous_order_id`, `order_action`, `comment_to_fulfiller`, `care_setting`, `scheduled_date`, `order_group_id`, `sort_weight`) VALUES 
(@CURRENT_ORD_ID, 2,166299,1,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE,' 13:32:04'),NULL,NULL,NULL,NULL,1,'2021-03-19 13:32:04',0,NULL,NULL,NULL,@CURRENT_PATIENT_ID,NULL,(select uuid()),'ROUTINE',CONCAT('ORD-',@ORDCOUNT+1),NULL,'NEW',NULL,1,NULL,NULL,NULL),
(@CURRENT_ORD_ID +1, 2,165680,1,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE,' 12:58:25'),NULL,NULL,NULL,NULL,1,'2021-03-19 13:32:04',0,NULL,NULL,NULL,@CURRENT_PATIENT_ID,NULL,(select uuid()),'ROUTINE',CONCAT('ORD-',@ORDCOUNT +2),NULL,'NEW',NULL,1,NULL,NULL,NULL);

SET @ORDCOUNT := @ORDCOUNT +2;
-- uses the order_id from the above orders
-- dose is just the literal number entered for the dose (100 mg and 10 mg respectively, in this case)
-- dosing_instructions free text shows up in the summary, structured info does not
-- quantity_units 1513 = tablet; 1514 = packet
-- route 160240 = oral
-- dose_units 161553 = mg
-- frequency 16 = once daily, 11 = twice daily
INSERT INTO `drug_order` (`order_id`, `drug_inventory_id`, `dose`, `as_needed`, `dosing_type`, `quantity`, 
`as_needed_condition`, `num_refills`, `dosing_instructions`, `duration`, `duration_units`, `quantity_units`, 
`route`, `dose_units`, `frequency`, `brand_name`, `dispense_as_written`, `drug_non_coded`) VALUES 
(@CURRENT_ORD_ID,23,100,0,'org.openmrs.SimpleDosingInstructions',90,NULL,0,'1 dd 100 mg',NULL,NULL,1514,160240,161553,16,NULL,0,NULL),
(@CURRENT_ORD_ID +1,67,10,0,'org.openmrs.SimpleDosingInstructions',90,NULL,0,'1 dd 10 mg',NULL,NULL,1513,160240,161553,16,NULL,0,NULL);


/* TODO add
Ciclosporine 2 dd 300 mg 
Cotrimoxazol 1 dd 480 mg 
Hypromellose 3 mg/ml oogdruppels 4 dd zn 
Macrogol/zouten sachet 1 dd 1 zn 
Metoclopramide 3 dd 10 mg zn 
Magnesiumgluconaat 2 dd 1 gr 
Omeprazol 1 dd 40 mg 
Valaciclovir 2 dd 500 mg 
*/

/* start visit */
SELECT max(visit_id)+1 INTO @CURRENT_VISIT_ID from visit;
INSERT INTO `visit` (`visit_id`,`patient_id`, `visit_type_id`, `date_started`, `date_stopped`, `indication_concept_id`, `location_id`, `creator`, `date_created`, `changed_by`, `date_changed`, `voided`, `voided_by`, `date_voided`, `void_reason`, `uuid`) VALUES 
(@CURRENT_VISIT_ID, @CURRENT_PATIENT_ID,1,CONCAT(@CLASS_DATE,' 13:12:39'),NULL,NULL,8,1,'2021-03-19 13:12:39',NULL,NULL,0,NULL,NULL,NULL, (select UUID()));

/* add visit diagnosis and note*/
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
(@CURRENT_PATIENT_ID,1284,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE,' 13:27:14'),6,@CURRENT_OBS_ID,NULL,NULL,121629,127494,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'2021-03-19 13:27:14',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_PATIENT_ID,162169,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE,' 13:27:14'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Opnamestatus op dinsdag \nVoorgeschiedenis: \nRefractair Hodgkin lymfoom (HL) wv allogene stamceltransplantatie (nov-2020) 01-04-2019 Prioriteit: Hoog \nIntentietremor zonder sensibiliteits- of motorische uitval DD bijwerking bij ciclosporine (>10%) 15-12-2020 \nstent in RCA 01-01-2017 \ninspanningsgerelateerde astma 01-01-1995 \n\nMedicatie bij opname: \nAmlodipine 1 dd 10 mg \nCarbasalaatcalcium poeder 1 dd 100 mg \nCiclosporine 2 dd 300 mg \nCotrimoxazol 1 dd 480 mg \nHypromellose 3 mg/ml oogdruppels 4 dd zn \nMacrogol/zouten sachet 1 dd 1 zn \nMetoclopramide 3 dd 10 mg zn \nMagnesiumgluconaat 2 dd 1 gr \nOmeprazol 1 dd 40 mg \nValaciclovir 2 dd 500 mg \n\nIntoxicaties: Geen \nAllergieën: Niet voor zover bekend \n\nRvO/ anemie bij status na refractair Hodgkin lymfoom waarvoor allogene stamceltransplantatie (+3 maanden) \n\nAnamnese: \nWas vorige week nog op policontrole geweest, ging toen wel goed. Echter sinds 2 dagen toenemend vermoeid, geen energie meer. Hierop belde zij naar de SEH en is derhalve gekomen. Eetlust is nog matig, maar onveranderd sinds de stamceltransplantatie. Niet misselijk of braken, ook geen diarree. Mictie iets branderig, maar niet hele tijd. Niet ziek geweest, klein hoestje, soms wat kortademig gevoel, wisselend aanwezig. Geen koorts bemerkt. Geen huidafwijkingen gezien. \n\nTractus anamnese: behoudens iets vocht vasthouden in de benen, geen bijzonderheden. \n\nLichamelijk onderzoek: \nT 36.8°C, P 85/min, RR 126/86mmHg, AH 16/min, O2-sat 98% zonder O2-suppletie  \nAlgemene indruk: helder, niet acuut zieke, maar wel zwak ogende patiënte \nH/H: in de mond geen afwijkingen, geen lymfadenopathie \nCor: normale harttonen, geen souffles \nPulm: normaal ademgeruis zonder bijgeluiden \nAbd: normale peristaltiek, wisselende tympanie, soepel, geen drukpijn, geen weerstanden \nExtr: iets pitting oedeem rondom de enkels, goed voelbare pulsaties  \n\nAO/ laag Hb, iets verhoogd CRP\n \nC/ \n1. Symptomatisch anemie  \n2. Ruim 3 maanden na stamceltransplantatie in verband met HL\n\nB/ \nAd 1 \nOpname op acute opname afdeling voor 2 erytrocyten transfusies (bestraald/parvo-B19 veilig) \nVolledig beleid, normaal dieet \nDoor met thuismedicatie \nIn principe morgenochtend naar huis',NULL,NULL,1,'2021-03-19 16:17:49',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL);

/* add vitals */
SELECT max(encounter_id)+1 INTO @CURRENT_ENC_ID from encounter;
INSERT INTO `encounter` (`encounter_id`,`encounter_type`, `patient_id`, `location_id`, `form_id`, `encounter_datetime`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `changed_by`, `date_changed`, `visit_id`, `uuid`) VALUES
(@CURRENT_ENC_ID, 7,@CURRENT_PATIENT_ID,6,1,CONCAT(@CLASS_DATE,' 14:21:31'),1,'2021-03-19 14:21:31',0,NULL,NULL,NULL,NULL,NULL,@CURRENT_VISIT_ID,(select uuid()));
-- uses encounter_id from above
INSERT INTO `encounter_provider` (`encounter_id`, `provider_id`, `encounter_role_id`, `creator`, `date_created`, `changed_by`, `date_changed`, `voided`, `date_voided`, `voided_by`, `void_reason`, `uuid`) VALUES 
(@CURRENT_ENC_ID,1,2,1,'2021-03-19 14:21:31',NULL,NULL,0,NULL,NULL,NULL,(select uuid()));
-- uses encounter_id from above. each vital meas gets an obs entry. Doesn't seem to use obs_group_id 
INSERT INTO `obs` (`person_id`, `concept_id`, `encounter_id`, `order_id`, `obs_datetime`, `location_id`, `obs_group_id`,`accession_number`, `value_group_id`, `value_coded`, `value_coded_name_id`, `value_drug`, `value_datetime`, `value_numeric`, `value_modifier`, `value_text`, `value_complex`, `comments`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `uuid`, `previous_version`, `form_namespace_and_path`, `status`, `interpretation`) VALUES 
(@CURRENT_PATIENT_ID,5088,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE,' 14:21:31'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,36.8,NULL,NULL,NULL,NULL,1,'2021-03-19 14:21:31',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_PATIENT_ID,5087,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE,' 14:21:31'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,85,NULL,NULL,NULL,NULL,1,'2021-03-19 14:21:31',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_PATIENT_ID,5242,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE,' 14:21:31'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16,NULL,NULL,NULL,NULL,1,'2021-03-19 14:21:31',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_PATIENT_ID,5085,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE,' 14:21:31'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,126,NULL,NULL,NULL,NULL,1,'2021-03-19 14:21:31',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_PATIENT_ID,5086,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE,' 14:21:31'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,86,NULL,NULL,NULL,NULL,1,'2021-03-19 14:21:31',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_PATIENT_ID,5092,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE,' 14:21:31'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,98,NULL,NULL,NULL,NULL,1,'2021-03-19 14:21:31',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL);

/* admit patient */
SELECT max(encounter_id)+1 INTO @CURRENT_ENC_ID from encounter;
INSERT INTO `encounter` (`encounter_id`, `encounter_type`, `patient_id`, `location_id`, `form_id`, `encounter_datetime`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `changed_by`, `date_changed`, `visit_id`, `uuid`) VALUES
(@CURRENT_ENC_ID,2,@CURRENT_PATIENT_ID,9,3,CONCAT(@CLASS_DATE,' 14:38:05'),1,'2021-03-19 14:38:05',0,NULL,NULL,NULL,NULL,NULL,@CURRENT_VISIT_ID,(select uuid()));

-- uses encounter_id from above
INSERT INTO `encounter_provider` (`encounter_id`, `provider_id`, `encounter_role_id`, `creator`, `date_created`, `changed_by`, `date_changed`, `voided`, `date_voided`, `voided_by`, `void_reason`, `uuid`) VALUES 
(@CURRENT_ENC_ID,1,1,1,'2021-03-19 14:38:05',NULL,NULL,0,NULL,NULL,NULL,(select uuid()));

/*TODO add 2 erytrocyten transfusies */

/* labs */
INSERT INTO `obs` (`person_id`, `concept_id`, `encounter_id`, `order_id`, `obs_datetime`, `location_id`, `obs_group_id`,`accession_number`, `value_group_id`, `value_coded`, `value_coded_name_id`, `value_drug`, `value_datetime`, `value_numeric`, `value_modifier`, `value_text`, `value_complex`, `comments`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `uuid`, `previous_version`, `form_namespace_and_path`, `status`, `interpretation`) VALUES 
(@CURRENT_PATIENT_ID,169763,NULL,NULL,@CLASS_DATE,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,78,NULL,NULL,NULL,'',1,'2021-04-09 17:35:51',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL), -- Kreatinine	umol/l	65-95		78
(@CURRENT_PATIENT_ID,169764,NULL,NULL,@CLASS_DATE,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,90,NULL,NULL,NULL,'> 90',1,'2021-04-09 17:37:15',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL), -- eGFR (CKD-EPI)	ml/min/1,73m^2		>90
(@CURRENT_PATIENT_ID,169743,NULL,NULL,@CLASS_DATE,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,5.6,NULL,NULL,NULL,'',1,'2021-04-09 17:43:52',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL), -- Glucose	mmol/l	4,1-5,6			5,9
(@CURRENT_PATIENT_ID,169775,NULL,NULL,@CLASS_DATE,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,19,NULL,NULL,NULL,'',1,'2021-04-09 17:44:29',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL), -- Bilirubine (totaal)	umol/l	0-17	19
(@CURRENT_PATIENT_ID,169770,NULL,NULL,@CLASS_DATE,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16,NULL,NULL,NULL,'',1,'2021-04-09 17:48:02',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL), -- aspartate aminotransferase (AST)	16
(@CURRENT_PATIENT_ID,169769,NULL,NULL,@CLASS_DATE,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,51,NULL,NULL,NULL,'',1,'2021-04-09 17:49:07',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL), -- alanine aminotransferase (ALT)		51
(@CURRENT_PATIENT_ID,169771,NULL,NULL,@CLASS_DATE,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,127,NULL,NULL,NULL,'',1,'2021-04-09 17:50:21',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL), -- Gamma-glutamyl transferase (GGT)	127
(@CURRENT_PATIENT_ID,169768,NULL,NULL,@CLASS_DATE,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,71,NULL,NULL,NULL,'',1,'2021-04-09 17:51:11',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL); -- Alkaline phosphatase (ALKP)		71

/* end copying tuesday */

/* add the note */
SELECT max(encounter_id)+1 INTO @CURRENT_ENC_ID from encounter;
INSERT INTO `encounter` (`encounter_id`,`encounter_type`, `patient_id`, `location_id`, `form_id`, `encounter_datetime`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `changed_by`, `date_changed`, `visit_id`, `uuid`) VALUES
(@CURRENT_ENC_ID,3,@CURRENT_PATIENT_ID,6,2,CONCAT(@CLASS_DATE2,' 07:06:30'),1,'2021-03-19 16:17:21',0,NULL,NULL,NULL,NULL,NULL,@CURRENT_VISIT_ID,(select uuid()));
-- uses encounter_id from the above encounter
INSERT INTO `encounter_provider` (`encounter_id`, `provider_id`, `encounter_role_id`, `creator`, `date_created`, `changed_by`, `date_changed`, `voided`, `date_voided`, `voided_by`, `void_reason`, `uuid`) VALUES 
(@CURRENT_ENC_ID,1,1,1,'2021-03-19 16:17:21',NULL,NULL,0,NULL,NULL,NULL,(select uuid()));
SELECT max(obs_id)+1 INTO @CURRENT_OBS_ID from obs;
INSERT INTO `obs` VALUES
(@CURRENT_OBS_ID,192,159947,4990,NULL,'2021-03-20 15:20:39',6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'2021-03-20 15:20:39',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_OBS_ID+1,@CURRENT_PATIENT_ID,159946,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE2,' 07:06:30'),6,@CURRENT_OBS_ID,NULL,NULL,159943,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'2021-03-20 15:20:39',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_OBS_ID+2,@CURRENT_PATIENT_ID,159394,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE2,' 07:06:30'),6,@CURRENT_OBS_ID,NULL,NULL,159393,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'2021-03-20 15:20:39',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_OBS_ID+3,@CURRENT_PATIENT_ID,1284,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE,' 07:06:30'),6,@CURRENT_OBS_ID,NULL,NULL,121629,127494,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'2021-03-20 15:20:39',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_OBS_ID+4,@CURRENT_PATIENT_ID,162169,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE2,' 07:06:30'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'RvO: symptomatische anemie \n \nVPK: vannacht transfusies ingelopen zonder problemen, verder rustige nacht, maar in ochtend koorts gemeten \n \nA/ \nZij voelt zich wat beter na de transfusies, wel nog steeds last van dysurie. Heeft ook gevoel van kleine beetjes te plassen. Zij hoest niet echt, geen keelpijn, maar soms iets kortademig gevoel, trekt nu ook weer weg. Niet echt snotterig. Iets licht in het hoofd. Werd vanochtend wel zweterig wakker, voelt zich niet koortsig. Niet misselijk. Ontlasting lijkt vanochtend ook iets dunner. Geen huidafwijkingen.  \n \nLichamelijk onderzoek: \nT 38,6°C, P 110/min, RR 110/70mmHg, AH 14/min, O2-sat 96% zonder O2-suppletie \nAlgemene indruk: helder, niet acuut ziek \nH/H: geen lymfadenopathie, in de mond mogelijk iets roodheid in de keel, overig geen afwijkingen \nCor: normale harttonen, geen souffles \nPulm: vesiculair ademgeruis zonder bijgeluiden \nAbd: normale peristaltiek, wisselende tympanie, soepel, geen druk- of loslaatpijn, geen weerstanden \nExtr: normale pulsaties, geen oedeem  \n \nAO/ geen \n \nConclusie \n    Koorts, tachycardie, dysurie, tevens iets dyspneu DD UWI, toch pneumonie, virale bovenste luchtweginfectie  \n    Ruim 3 maanden na stamceltransplantatie in verband met HL \n \nBeleid \nAd 1 \nBloedkweken afnemen, tevens CRP \nSediment plus urinekweek  \nIndien diarree dan ook feceskweek (SSYC, clostridium en virussen) \nRespiratoir virus pakket, incl COVID \nX-thorax \nStart cefriaxon 1 dd 2000 mg + gentamicine 5 mg/kg \nAdvies minimaal 1,5 liter drinken (indien dat niet lukt infuus starten) \n \nAddendum om 16 uur: \nAO/ CRP verder gestegen, Hb wel mooi gestegen, COVID negatief \nX-thorax: ongewijzigd thoraxbeeld met postradiatieveranderingen rechts apicaal. Geen nieuwe voor pneumonie verdachte verdichtingen.  \nC/ \nKoorts, tachycardie, dysurie en leukocyturie passend bij urineweginfectie \nB/ \nZo door ',NULL,NULL,1,'2021-03-20 15:20:39',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL);

/* add some more vitals */
SELECT max(encounter_id)+1 INTO @CURRENT_ENC_ID from encounter;
INSERT INTO `encounter` (`encounter_id`,`encounter_type`, `patient_id`, `location_id`, `form_id`, `encounter_datetime`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `changed_by`, `date_changed`, `visit_id`, `uuid`) VALUES
(@CURRENT_ENC_ID, 7,@CURRENT_PATIENT_ID,6,1,CONCAT(@CLASS_DATE2,' 07:21:31'),1,'2021-03-19 07:21:31',0,NULL,NULL,NULL,NULL,NULL,@CURRENT_VISIT_ID,(select uuid()));
-- uses encounter_id from above
INSERT INTO `encounter_provider` (`encounter_id`, `provider_id`, `encounter_role_id`, `creator`, `date_created`, `changed_by`, `date_changed`, `voided`, `date_voided`, `voided_by`, `void_reason`, `uuid`) VALUES 
(@CURRENT_ENC_ID,1,2,1,'2021-03-19 07:21:31',NULL,NULL,0,NULL,NULL,NULL,(select uuid()));
-- uses encounter_id from above. each vital meas gets an obs entry. Doesn't seem to use obs_group_id 
INSERT INTO `obs` (`person_id`, `concept_id`, `encounter_id`, `order_id`, `obs_datetime`, `location_id`, `obs_group_id`,`accession_number`, `value_group_id`, `value_coded`, `value_coded_name_id`, `value_drug`, `value_datetime`, `value_numeric`, `value_modifier`, `value_text`, `value_complex`, `comments`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `uuid`, `previous_version`, `form_namespace_and_path`, `status`, `interpretation`) VALUES 
(@CURRENT_PATIENT_ID,5088,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE2,' 07:21:31'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,38.6,NULL,NULL,NULL,NULL,1,'2021-03-19 07:21:31',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_PATIENT_ID,5087,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE2,' 07:21:31'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,110,NULL,NULL,NULL,NULL,1,'2021-03-19 07:21:31',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_PATIENT_ID,5242,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE2,' 07:21:31'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,14,NULL,NULL,NULL,NULL,1,'2021-03-19 07:21:31',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_PATIENT_ID,5085,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE2,' 07:21:31'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,110,NULL,NULL,NULL,NULL,1,'2021-03-19 07:21:31',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_PATIENT_ID,5086,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE2,' 07:21:31'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,70,NULL,NULL,NULL,NULL,1,'2021-03-19 07:21:31',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_PATIENT_ID,5092,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE2,' 07:21:31'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,96,NULL,NULL,NULL,NULL,1,'2021-03-19 07:21:31',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL);

/* TODO probably need to add diagnoses/problem list items:
    Koorts, tachycardie, dysurie, tevens iets dyspneu DD UWI, toch pneumonie, virale bovenste luchtweginfectie  
Also orders: 
Bloedkweken afnemen, tevens CRP 
Sediment plus urinekweek  
Indien diarree dan ook feceskweek (SSYC, clostridium en virussen) 
Respiratoir virus pakket, incl COVID 
X-thorax 
Start cefriaxon 1 dd 2000 mg + gentamicine 5 mg/kg 

At 16:00 adjust diagnoses/problem list:
Koorts, tachycardie, dysurie en leukocyturie passend bij urineweginfectie
*/

/************************ DONDERDAG *************************/
SET @DAY_OF_WEEK := 'Donderdag';
SET @CURRENT_PATIENT_IDENTIFIER := @CURRENT_PATIENT_IDENTIFIER +2;
SET @ORDCOUNT := 0; -- first order is always ORD-1, second is ORD-2, etc.

SELECT max(person_id)+1 INTO @CURRENT_PATIENT_ID from person;

/* add patient */
INSERT INTO `person` VALUES(@CURRENT_PATIENT_ID,'F','1977-10-01',0,0,NULL,NULL,1,'2021-03-19 10:36:22',NULL,NULL,0,NULL,NULL,NULL,(select UUID()),0,NULL);
INSERT INTO `patient` VALUES (@CURRENT_PATIENT_ID,1,'2021-03-19 10:36:22',NULL,NULL,0,NULL,NULL,NULL,'Unknown');
INSERT INTO `patient_identifier` (`patient_id`, `identifier`, `identifier_type`, `preferred`, `location_id`, `creator`, `date_created`, `date_changed`, `changed_by`, `voided`, `voided_by`, `date_voided`, `void_reason`, `uuid`) VALUES 
(@CURRENT_PATIENT_ID,@CURRENT_PATIENT_IDENTIFIER,3,1,6,1,'2021-03-19 10:36:23',NULL,NULL,0,NULL,NULL,NULL,(select UUID()));

INSERT INTO `person_address` (`person_id`, `preferred`, `address1`, `address2`, `city_village`, `state_province`, `postal_code`, `country`, `latitude`, `longitude`, `start_date`, `end_date`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `county_district`, `address3`, `address4`, `address5`, `address6`, `date_changed`, `changed_by`, `uuid`, `address7`, `address8`, `address9`, `address10`, `address11`, `address12`, `address13`, `address14`, `address15`) VALUES  
(@CURRENT_PATIENT_ID,1,'Oud Loosdrecht Dijk 1',NULL,'Loosdrecht',NULL,'1234 AA',NULL,NULL,NULL,NULL,NULL,1,'2021-03-19 10:36:23',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,(select UUID()),NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `person_attribute` (`person_id`, `value`, `person_attribute_type_id`, `creator`, `date_created`, `changed_by`, `date_changed`, `voided`, `voided_by`, `date_voided`, `void_reason`, `uuid`) VALUES 
(@CURRENT_PATIENT_ID,'0612345678',8,1,'2021-03-19 10:36:23',NULL,NULL,0,NULL,NULL,NULL,(select UUID()));
INSERT INTO `person_name` (`preferred`, `person_id`, `prefix`, `given_name`, `middle_name`, `family_name_prefix`, `family_name`, `family_name2`, `family_name_suffix`, `degree`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `changed_by`, `date_changed`, `uuid`) VALUES 
(1,@CURRENT_PATIENT_ID,NULL,CONCAT('A.',@DAY_OF_WEEK),NULL,NULL,CONCAT('de Vries',@STUDENT_ID),NULL,NULL,NULL,1,'2021-03-19 10:36:23',0,NULL,NULL,NULL,NULL,NULL,(select UUID()));

/* add patient relations */
INSERT INTO `relationship` (`person_a`, `relationship`, `person_b`, `start_date`, `end_date`, `creator`, `date_created`, `date_changed`, `changed_by`, `voided`, `voided_by`, `date_voided`, `void_reason`, `uuid`) VALUES
(@CURRENT_PATIENT_ID,3,@DAUGHTER_PID,NULL,NULL,1,'2021-03-19 10:36:23',NULL,NULL,0,NULL,NULL,NULL,(select uuid()));

/* copy tuesday*

/* add meds: Each drug order creates an entry in encounter, encounter_provider, orders, and drug_order. */
-- drug order encounters don't have a visit_id
-- technically it is perfectly safe to reset CURRENT_ENC_ID rather than making a new variable, but since the two aren't equal I'm making different vars.
SELECT max(encounter_id)+1 INTO @CURRENT_ENC_ID from encounter;
INSERT INTO `encounter` (`encounter_id`, `encounter_type`, `patient_id`, `location_id`, `form_id`, `encounter_datetime`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `changed_by`, `date_changed`, `visit_id`, `uuid`) VALUES  
(@CURRENT_ENC_ID,8,@CURRENT_PATIENT_ID,NULL,NULL,CONCAT(@CLASS_DATE,' 13:32:04'),1,'2021-03-19 13:32:04',0,NULL,NULL,NULL,NULL,NULL,NULL,(select UUID()));
INSERT INTO `encounter_provider` (`encounter_id`, `provider_id`, `encounter_role_id`, `creator`, `date_created`, `changed_by`, `date_changed`, `voided`, `date_voided`, `voided_by`, `void_reason`, `uuid`) VALUES  
(@CURRENT_ENC_ID,1,2,1,'2021-03-19 13:32:04',NULL,NULL,0,NULL,NULL,NULL,(select uuid()));
-- Order uses encounter_id. Orders that share an encounter_id were signed together.
SELECT max(order_id)+1 INTO @CURRENT_ORD_ID from orders; -- We will count on the orders being inserted sequentially
INSERT INTO `orders` (`order_id`,`order_type_id`, `concept_id`, `orderer`, `encounter_id`, `instructions`, `date_activated`, `auto_expire_date`, `date_stopped`, `order_reason`, `order_reason_non_coded`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `patient_id`, `accession_number`, `uuid`, `urgency`, `order_number`, `previous_order_id`, `order_action`, `comment_to_fulfiller`, `care_setting`, `scheduled_date`, `order_group_id`, `sort_weight`) VALUES 
(@CURRENT_ORD_ID, 2,166299,1,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE,' 13:32:04'),NULL,NULL,NULL,NULL,1,'2021-03-19 13:32:04',0,NULL,NULL,NULL,@CURRENT_PATIENT_ID,NULL,(select uuid()),'ROUTINE',CONCAT('ORD-',@ORDCOUNT+1),NULL,'NEW',NULL,1,NULL,NULL,NULL),
(@CURRENT_ORD_ID +1, 2,165680,1,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE,' 12:58:25'),NULL,NULL,NULL,NULL,1,'2021-03-19 13:32:04',0,NULL,NULL,NULL,@CURRENT_PATIENT_ID,NULL,(select uuid()),'ROUTINE',CONCAT('ORD-',@ORDCOUNT +2),NULL,'NEW',NULL,1,NULL,NULL,NULL);

SET @ORDCOUNT := @ORDCOUNT +2;
-- uses the order_id from the above orders
-- dose is just the literal number entered for the dose (100 mg and 10 mg respectively, in this case)
-- dosing_instructions free text shows up in the summary, structured info does not
-- quantity_units 1513 = tablet; 1514 = packet
-- route 160240 = oral
-- dose_units 161553 = mg
-- frequency 16 = once daily, 11 = twice daily
INSERT INTO `drug_order` (`order_id`, `drug_inventory_id`, `dose`, `as_needed`, `dosing_type`, `quantity`, 
`as_needed_condition`, `num_refills`, `dosing_instructions`, `duration`, `duration_units`, `quantity_units`, 
`route`, `dose_units`, `frequency`, `brand_name`, `dispense_as_written`, `drug_non_coded`) VALUES 
(@CURRENT_ORD_ID,23,100,0,'org.openmrs.SimpleDosingInstructions',90,NULL,0,'1 dd 100 mg',NULL,NULL,1514,160240,161553,16,NULL,0,NULL),
(@CURRENT_ORD_ID +1,67,10,0,'org.openmrs.SimpleDosingInstructions',90,NULL,0,'1 dd 10 mg',NULL,NULL,1513,160240,161553,16,NULL,0,NULL);


/* TODO add
Ciclosporine 2 dd 300 mg 
Cotrimoxazol 1 dd 480 mg 
Hypromellose 3 mg/ml oogdruppels 4 dd zn 
Macrogol/zouten sachet 1 dd 1 zn 
Metoclopramide 3 dd 10 mg zn 
Magnesiumgluconaat 2 dd 1 gr 
Omeprazol 1 dd 40 mg 
Valaciclovir 2 dd 500 mg 
*/

/* start visit */
SELECT max(visit_id)+1 INTO @CURRENT_VISIT_ID from visit;
INSERT INTO `visit` (`visit_id`,`patient_id`, `visit_type_id`, `date_started`, `date_stopped`, `indication_concept_id`, `location_id`, `creator`, `date_created`, `changed_by`, `date_changed`, `voided`, `voided_by`, `date_voided`, `void_reason`, `uuid`) VALUES 
(@CURRENT_VISIT_ID, @CURRENT_PATIENT_ID,1,CONCAT(@CLASS_DATE,' 13:12:39'),NULL,NULL,8,1,'2021-03-19 13:12:39',NULL,NULL,0,NULL,NULL,NULL, (select UUID()));

/* add visit diagnosis and note*/
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
(@CURRENT_PATIENT_ID,1284,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE,' 13:27:14'),6,@CURRENT_OBS_ID,NULL,NULL,121629,127494,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'2021-03-19 13:27:14',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_PATIENT_ID,162169,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE,' 13:27:14'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Opnamestatus op dinsdag \nVoorgeschiedenis: \nRefractair Hodgkin lymfoom (HL) wv allogene stamceltransplantatie (nov-2020) 01-04-2019 Prioriteit: Hoog \nIntentietremor zonder sensibiliteits- of motorische uitval DD bijwerking bij ciclosporine (>10%) 15-12-2020 \nstent in RCA 01-01-2017 \ninspanningsgerelateerde astma 01-01-1995 \n\nMedicatie bij opname: \nAmlodipine 1 dd 10 mg \nCarbasalaatcalcium poeder 1 dd 100 mg \nCiclosporine 2 dd 300 mg \nCotrimoxazol 1 dd 480 mg \nHypromellose 3 mg/ml oogdruppels 4 dd zn \nMacrogol/zouten sachet 1 dd 1 zn \nMetoclopramide 3 dd 10 mg zn \nMagnesiumgluconaat 2 dd 1 gr \nOmeprazol 1 dd 40 mg \nValaciclovir 2 dd 500 mg \n\nIntoxicaties: Geen \nAllergieën: Niet voor zover bekend \n\nRvO/ anemie bij status na refractair Hodgkin lymfoom waarvoor allogene stamceltransplantatie (+3 maanden) \n\nAnamnese: \nWas vorige week nog op policontrole geweest, ging toen wel goed. Echter sinds 2 dagen toenemend vermoeid, geen energie meer. Hierop belde zij naar de SEH en is derhalve gekomen. Eetlust is nog matig, maar onveranderd sinds de stamceltransplantatie. Niet misselijk of braken, ook geen diarree. Mictie iets branderig, maar niet hele tijd. Niet ziek geweest, klein hoestje, soms wat kortademig gevoel, wisselend aanwezig. Geen koorts bemerkt. Geen huidafwijkingen gezien. \n\nTractus anamnese: behoudens iets vocht vasthouden in de benen, geen bijzonderheden. \n\nLichamelijk onderzoek: \nT 36.8°C, P 85/min, RR 126/86mmHg, AH 16/min, O2-sat 98% zonder O2-suppletie  \nAlgemene indruk: helder, niet acuut zieke, maar wel zwak ogende patiënte \nH/H: in de mond geen afwijkingen, geen lymfadenopathie \nCor: normale harttonen, geen souffles \nPulm: normaal ademgeruis zonder bijgeluiden \nAbd: normale peristaltiek, wisselende tympanie, soepel, geen drukpijn, geen weerstanden \nExtr: iets pitting oedeem rondom de enkels, goed voelbare pulsaties  \n\nAO/ laag Hb, iets verhoogd CRP\n \nC/ \n1. Symptomatisch anemie  \n2. Ruim 3 maanden na stamceltransplantatie in verband met HL\n\nB/ \nAd 1 \nOpname op acute opname afdeling voor 2 erytrocyten transfusies (bestraald/parvo-B19 veilig) \nVolledig beleid, normaal dieet \nDoor met thuismedicatie \nIn principe morgenochtend naar huis',NULL,NULL,1,'2021-03-19 16:17:49',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL);

/* add vitals */
SELECT max(encounter_id)+1 INTO @CURRENT_ENC_ID from encounter;
INSERT INTO `encounter` (`encounter_id`,`encounter_type`, `patient_id`, `location_id`, `form_id`, `encounter_datetime`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `changed_by`, `date_changed`, `visit_id`, `uuid`) VALUES
(@CURRENT_ENC_ID, 7,@CURRENT_PATIENT_ID,6,1,CONCAT(@CLASS_DATE,' 14:21:31'),1,'2021-03-19 14:21:31',0,NULL,NULL,NULL,NULL,NULL,@CURRENT_VISIT_ID,(select uuid()));
-- uses encounter_id from above
INSERT INTO `encounter_provider` (`encounter_id`, `provider_id`, `encounter_role_id`, `creator`, `date_created`, `changed_by`, `date_changed`, `voided`, `date_voided`, `voided_by`, `void_reason`, `uuid`) VALUES 
(@CURRENT_ENC_ID,1,2,1,'2021-03-19 14:21:31',NULL,NULL,0,NULL,NULL,NULL,(select uuid()));
-- uses encounter_id from above. each vital meas gets an obs entry. Doesn't seem to use obs_group_id 
INSERT INTO `obs` (`person_id`, `concept_id`, `encounter_id`, `order_id`, `obs_datetime`, `location_id`, `obs_group_id`,`accession_number`, `value_group_id`, `value_coded`, `value_coded_name_id`, `value_drug`, `value_datetime`, `value_numeric`, `value_modifier`, `value_text`, `value_complex`, `comments`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `uuid`, `previous_version`, `form_namespace_and_path`, `status`, `interpretation`) VALUES 
(@CURRENT_PATIENT_ID,5088,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE,' 14:21:31'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,36.8,NULL,NULL,NULL,NULL,1,'2021-03-19 14:21:31',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_PATIENT_ID,5087,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE,' 14:21:31'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,85,NULL,NULL,NULL,NULL,1,'2021-03-19 14:21:31',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_PATIENT_ID,5242,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE,' 14:21:31'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16,NULL,NULL,NULL,NULL,1,'2021-03-19 14:21:31',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_PATIENT_ID,5085,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE,' 14:21:31'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,126,NULL,NULL,NULL,NULL,1,'2021-03-19 14:21:31',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_PATIENT_ID,5086,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE,' 14:21:31'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,86,NULL,NULL,NULL,NULL,1,'2021-03-19 14:21:31',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_PATIENT_ID,5092,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE,' 14:21:31'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,98,NULL,NULL,NULL,NULL,1,'2021-03-19 14:21:31',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL);

/* admit patient */
SELECT max(encounter_id)+1 INTO @CURRENT_ENC_ID from encounter;
INSERT INTO `encounter` (`encounter_id`, `encounter_type`, `patient_id`, `location_id`, `form_id`, `encounter_datetime`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `changed_by`, `date_changed`, `visit_id`, `uuid`) VALUES
(@CURRENT_ENC_ID,2,@CURRENT_PATIENT_ID,9,3,CONCAT(@CLASS_DATE,' 14:38:05'),1,'2021-03-19 14:38:05',0,NULL,NULL,NULL,NULL,NULL,@CURRENT_VISIT_ID,(select uuid()));

-- uses encounter_id from above
INSERT INTO `encounter_provider` (`encounter_id`, `provider_id`, `encounter_role_id`, `creator`, `date_created`, `changed_by`, `date_changed`, `voided`, `date_voided`, `voided_by`, `void_reason`, `uuid`) VALUES 
(@CURRENT_ENC_ID,1,1,1,'2021-03-19 14:38:05',NULL,NULL,0,NULL,NULL,NULL,(select uuid()));

/*TODO add 2 erytrocyten transfusies */

/* labs */
INSERT INTO `obs` (`person_id`, `concept_id`, `encounter_id`, `order_id`, `obs_datetime`, `location_id`, `obs_group_id`,`accession_number`, `value_group_id`, `value_coded`, `value_coded_name_id`, `value_drug`, `value_datetime`, `value_numeric`, `value_modifier`, `value_text`, `value_complex`, `comments`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `uuid`, `previous_version`, `form_namespace_and_path`, `status`, `interpretation`) VALUES 
(@CURRENT_PATIENT_ID,169763,NULL,NULL,@CLASS_DATE,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,78,NULL,NULL,NULL,'',1,'2021-04-09 17:35:51',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL), -- Kreatinine	umol/l	65-95		78
(@CURRENT_PATIENT_ID,169764,NULL,NULL,@CLASS_DATE,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,90,NULL,NULL,NULL,'> 90',1,'2021-04-09 17:37:15',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL), -- eGFR (CKD-EPI)	ml/min/1,73m^2		>90
(@CURRENT_PATIENT_ID,169743,NULL,NULL,@CLASS_DATE,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,5.6,NULL,NULL,NULL,'',1,'2021-04-09 17:43:52',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL), -- Glucose	mmol/l	4,1-5,6			5,9
(@CURRENT_PATIENT_ID,169775,NULL,NULL,@CLASS_DATE,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,19,NULL,NULL,NULL,'',1,'2021-04-09 17:44:29',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL), -- Bilirubine (totaal)	umol/l	0-17	19
(@CURRENT_PATIENT_ID,169770,NULL,NULL,@CLASS_DATE,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16,NULL,NULL,NULL,'',1,'2021-04-09 17:48:02',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL), -- aspartate aminotransferase (AST)	16
(@CURRENT_PATIENT_ID,169769,NULL,NULL,@CLASS_DATE,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,51,NULL,NULL,NULL,'',1,'2021-04-09 17:49:07',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL), -- alanine aminotransferase (ALT)		51
(@CURRENT_PATIENT_ID,169771,NULL,NULL,@CLASS_DATE,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,127,NULL,NULL,NULL,'',1,'2021-04-09 17:50:21',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL), -- Gamma-glutamyl transferase (GGT)	127
(@CURRENT_PATIENT_ID,169768,NULL,NULL,@CLASS_DATE,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,71,NULL,NULL,NULL,'',1,'2021-04-09 17:51:11',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL); -- Alkaline phosphatase (ALKP)		71

/* end copying tuesday / start copy wed */

/* add the note */
SELECT max(encounter_id)+1 INTO @CURRENT_ENC_ID from encounter;
INSERT INTO `encounter` (`encounter_id`,`encounter_type`, `patient_id`, `location_id`, `form_id`, `encounter_datetime`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `changed_by`, `date_changed`, `visit_id`, `uuid`) VALUES
(@CURRENT_ENC_ID,3,@CURRENT_PATIENT_ID,6,2,CONCAT(@CLASS_DATE2,' 07:06:30'),1,'2021-03-19 16:17:21',0,NULL,NULL,NULL,NULL,NULL,@CURRENT_VISIT_ID,(select uuid()));
-- uses encounter_id from the above encounter
INSERT INTO `encounter_provider` (`encounter_id`, `provider_id`, `encounter_role_id`, `creator`, `date_created`, `changed_by`, `date_changed`, `voided`, `date_voided`, `voided_by`, `void_reason`, `uuid`) VALUES 
(@CURRENT_ENC_ID,1,1,1,'2021-03-19 16:17:21',NULL,NULL,0,NULL,NULL,NULL,(select uuid()));
SELECT max(obs_id)+1 INTO @CURRENT_OBS_ID from obs;
INSERT INTO `obs` VALUES
(@CURRENT_OBS_ID,@CURRENT_PATIENT_ID,159947,@CURRENT_ENC_ID,NULL,'2021-03-20 15:20:39',6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'2021-03-20 15:20:39',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_OBS_ID+1,@CURRENT_PATIENT_ID,159946,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE2,' 07:06:30'),6,@CURRENT_OBS_ID,NULL,NULL,159943,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'2021-03-20 15:20:39',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_OBS_ID+2,@CURRENT_PATIENT_ID,159394,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE2,' 07:06:30'),6,@CURRENT_OBS_ID,NULL,NULL,159393,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'2021-03-20 15:20:39',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_OBS_ID+3,@CURRENT_PATIENT_ID,1284,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE,' 07:06:30'),6,@CURRENT_OBS_ID,NULL,NULL,121629,127494,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'2021-03-20 15:20:39',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_OBS_ID+4,@CURRENT_PATIENT_ID,162169,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE2,' 07:06:30'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'RvO: symptomatische anemie \n \nVPK: vannacht transfusies ingelopen zonder problemen, verder rustige nacht, maar in ochtend koorts gemeten \n \nA/ \nZij voelt zich wat beter na de transfusies, wel nog steeds last van dysurie. Heeft ook gevoel van kleine beetjes te plassen. Zij hoest niet echt, geen keelpijn, maar soms iets kortademig gevoel, trekt nu ook weer weg. Niet echt snotterig. Iets licht in het hoofd. Werd vanochtend wel zweterig wakker, voelt zich niet koortsig. Niet misselijk. Ontlasting lijkt vanochtend ook iets dunner. Geen huidafwijkingen.  \n \nLichamelijk onderzoek: \nT 38,6°C, P 110/min, RR 110/70mmHg, AH 14/min, O2-sat 96% zonder O2-suppletie \nAlgemene indruk: helder, niet acuut ziek \nH/H: geen lymfadenopathie, in de mond mogelijk iets roodheid in de keel, overig geen afwijkingen \nCor: normale harttonen, geen souffles \nPulm: vesiculair ademgeruis zonder bijgeluiden \nAbd: normale peristaltiek, wisselende tympanie, soepel, geen druk- of loslaatpijn, geen weerstanden \nExtr: normale pulsaties, geen oedeem  \n \nAO/ geen \n \nConclusie \n    Koorts, tachycardie, dysurie, tevens iets dyspneu DD UWI, toch pneumonie, virale bovenste luchtweginfectie  \n    Ruim 3 maanden na stamceltransplantatie in verband met HL \n \nBeleid \nAd 1 \nBloedkweken afnemen, tevens CRP \nSediment plus urinekweek  \nIndien diarree dan ook feceskweek (SSYC, clostridium en virussen) \nRespiratoir virus pakket, incl COVID \nX-thorax \nStart cefriaxon 1 dd 2000 mg + gentamicine 5 mg/kg \nAdvies minimaal 1,5 liter drinken (indien dat niet lukt infuus starten) \n \nAddendum om 16 uur: \nAO/ CRP verder gestegen, Hb wel mooi gestegen, COVID negatief \nX-thorax: ongewijzigd thoraxbeeld met postradiatieveranderingen rechts apicaal. Geen nieuwe voor pneumonie verdachte verdichtingen.  \nC/ \nKoorts, tachycardie, dysurie en leukocyturie passend bij urineweginfectie \nB/ \nZo door ',NULL,NULL,1,'2021-03-20 15:20:39',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL);

/* add some more vitals */
SELECT max(encounter_id)+1 INTO @CURRENT_ENC_ID from encounter;
INSERT INTO `encounter` (`encounter_id`,`encounter_type`, `patient_id`, `location_id`, `form_id`, `encounter_datetime`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `changed_by`, `date_changed`, `visit_id`, `uuid`) VALUES
(@CURRENT_ENC_ID, 7,@CURRENT_PATIENT_ID,6,1,CONCAT(@CLASS_DATE2,' 07:21:31'),1,'2021-03-19 07:21:31',0,NULL,NULL,NULL,NULL,NULL,@CURRENT_VISIT_ID,(select uuid()));
-- uses encounter_id from above
INSERT INTO `encounter_provider` (`encounter_id`, `provider_id`, `encounter_role_id`, `creator`, `date_created`, `changed_by`, `date_changed`, `voided`, `date_voided`, `voided_by`, `void_reason`, `uuid`) VALUES 
(@CURRENT_ENC_ID,1,2,1,'2021-03-19 07:21:31',NULL,NULL,0,NULL,NULL,NULL,(select uuid()));
-- uses encounter_id from above. each vital meas gets an obs entry. Doesn't seem to use obs_group_id 
INSERT INTO `obs` (`person_id`, `concept_id`, `encounter_id`, `order_id`, `obs_datetime`, `location_id`, `obs_group_id`,`accession_number`, `value_group_id`, `value_coded`, `value_coded_name_id`, `value_drug`, `value_datetime`, `value_numeric`, `value_modifier`, `value_text`, `value_complex`, `comments`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `uuid`, `previous_version`, `form_namespace_and_path`, `status`, `interpretation`) VALUES 
(@CURRENT_PATIENT_ID,5088,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE2,' 07:21:31'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,38.6,NULL,NULL,NULL,NULL,1,'2021-03-19 07:21:31',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_PATIENT_ID,5087,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE2,' 07:21:31'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,110,NULL,NULL,NULL,NULL,1,'2021-03-19 07:21:31',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_PATIENT_ID,5242,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE2,' 07:21:31'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,14,NULL,NULL,NULL,NULL,1,'2021-03-19 07:21:31',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_PATIENT_ID,5085,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE2,' 07:21:31'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,110,NULL,NULL,NULL,NULL,1,'2021-03-19 07:21:31',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_PATIENT_ID,5086,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE2,' 07:21:31'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,70,NULL,NULL,NULL,NULL,1,'2021-03-19 07:21:31',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_PATIENT_ID,5092,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE2,' 07:21:31'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,96,NULL,NULL,NULL,NULL,1,'2021-03-19 07:21:31',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL);

/* TODO probably need to add diagnoses/problem list items:
    Koorts, tachycardie, dysurie, tevens iets dyspneu DD UWI, toch pneumonie, virale bovenste luchtweginfectie  
Also orders: 
Bloedkweken afnemen, tevens CRP 
Sediment plus urinekweek  
Indien diarree dan ook feceskweek (SSYC, clostridium en virussen) 
Respiratoir virus pakket, incl COVID 
X-thorax 
Start cefriaxon 1 dd 2000 mg + gentamicine 5 mg/kg 

At 16:00 adjust diagnoses/problem list:
Koorts, tachycardie, dysurie en leukocyturie passend bij urineweginfectie
*/

/* end copy wed */

/* add thursday's note */
SELECT max(encounter_id)+1 INTO @CURRENT_ENC_ID from encounter;
INSERT INTO `encounter` (`encounter_id`,`encounter_type`, `patient_id`, `location_id`, `form_id`, `encounter_datetime`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `changed_by`, `date_changed`, `visit_id`, `uuid`) VALUES
(@CURRENT_ENC_ID,3,@CURRENT_PATIENT_ID,6,2,CONCAT(@CLASS_DATE3,' 07:06:30'),1,'2021-03-19 16:17:21',0,NULL,NULL,NULL,NULL,NULL,@CURRENT_VISIT_ID,(select uuid()));
-- uses encounter_id from the above encounter
INSERT INTO `encounter_provider` (`encounter_id`, `provider_id`, `encounter_role_id`, `creator`, `date_created`, `changed_by`, `date_changed`, `voided`, `date_voided`, `voided_by`, `void_reason`, `uuid`) VALUES 
(@CURRENT_ENC_ID,1,1,1,'2021-03-19 16:17:21',NULL,NULL,0,NULL,NULL,NULL,(select uuid()));
SELECT max(obs_id)+1 INTO @CURRENT_OBS_ID from obs;
INSERT INTO `obs` VALUES
(@CURRENT_OBS_ID,@CURRENT_PATIENT_ID,159947,@CURRENT_ENC_ID,NULL,'2021-03-20 15:20:39',6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'2021-03-20 15:20:39',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_OBS_ID+1,@CURRENT_PATIENT_ID,159946,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE3,' 07:06:30'),6,@CURRENT_OBS_ID,NULL,NULL,159943,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'2021-03-20 15:20:39',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_OBS_ID+2,@CURRENT_PATIENT_ID,159394,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE3,' 07:06:30'),6,@CURRENT_OBS_ID,NULL,NULL,159393,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'2021-03-20 15:20:39',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_OBS_ID+3,@CURRENT_PATIENT_ID,1284,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE,' 07:06:30'),6,@CURRENT_OBS_ID,NULL,NULL,121629,127494,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'2021-03-20 15:20:39',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_OBS_ID+4,@CURRENT_PATIENT_ID,162169,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE3,' 07:06:30'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'RvO/ verdenking urineweginfectie \n \nVPK/ Nog wel zwak, koorts afgezakt, branderig pijn tijdens mictie nog wel aanwezig, heeft sinds vannacht jeuk en roodheid op de benen, ook beetje op de buik.  \n \nA/ Voelt zich nog iets vermoeid, wel nog dysurie, hoesten/kortademigheid niet meer. \n \nLO/ T 37,8°C, P 96/min, RR 137/96mmHg, AH 12/min, O2-sat 98% zonder O2-suppletie  \nMaculopapuleuze afwijkingen op bovenbenen, ook in mindere mate op de onderbenen, aantal vlekken op buik.  \n \nAO/  \nGram- staven uit urinekweek, determinatie volgt, bloedkweek vooralsnog negatief \n \nC/  \n    Urineweginfectie met gram- staven \n    Maculopapuleus exantheem benen/buik tgv allergische reactie op antibiotica DD bij infectie of beginnende graft versus host disease (GvHD) agv 3  \n    Ruim 3 mnd na stamceltransplantatie \n \nB/  \n \nAd 1/2  \n    Roodheid aftekenen \n    Gezien huidreactie dermatoloog in consult vragen, passend bij geneesmiddelallergie of toch beginnende GvHD \n    Determinatie urinekweek afwachten en bloedkweek, switch naar meropenem (gezien mgl kruisreactiviteit met andere antibiotica) \n',NULL,NULL,1,'2021-03-20 15:20:39',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL);

/* add some more vitals */
SELECT max(encounter_id)+1 INTO @CURRENT_ENC_ID from encounter;
INSERT INTO `encounter` (`encounter_id`,`encounter_type`, `patient_id`, `location_id`, `form_id`, `encounter_datetime`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `changed_by`, `date_changed`, `visit_id`, `uuid`) VALUES
(@CURRENT_ENC_ID, 7,@CURRENT_PATIENT_ID,6,1,CONCAT(@CLASS_DATE3,' 06:40:31'),1,'2021-03-19 06:40:31',0,NULL,NULL,NULL,NULL,NULL,@CURRENT_VISIT_ID,(select uuid()));
-- uses encounter_id from above
INSERT INTO `encounter_provider` (`encounter_id`, `provider_id`, `encounter_role_id`, `creator`, `date_created`, `changed_by`, `date_changed`, `voided`, `date_voided`, `voided_by`, `void_reason`, `uuid`) VALUES 
(@CURRENT_ENC_ID,1,2,1,'2021-03-19 06:40:31',NULL,NULL,0,NULL,NULL,NULL,(select uuid()));
-- uses encounter_id from above. each vital meas gets an obs entry. Doesn't seem to use obs_group_id 
INSERT INTO `obs` (`person_id`, `concept_id`, `encounter_id`, `order_id`, `obs_datetime`, `location_id`, `obs_group_id`,`accession_number`, `value_group_id`, `value_coded`, `value_coded_name_id`, `value_drug`, `value_datetime`, `value_numeric`, `value_modifier`, `value_text`, `value_complex`, `comments`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `uuid`, `previous_version`, `form_namespace_and_path`, `status`, `interpretation`) VALUES 
(@CURRENT_PATIENT_ID,5088,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE3,' 06:40:31'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,37.8,NULL,NULL,NULL,NULL,1,'2021-03-19 06:40:31',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_PATIENT_ID,5087,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE3,' 06:40:31'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,96,NULL,NULL,NULL,NULL,1,'2021-03-19 06:40:31',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_PATIENT_ID,5242,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE3,' 06:40:31'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,12,NULL,NULL,NULL,NULL,1,'2021-03-19 06:40:31',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_PATIENT_ID,5085,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE3,' 06:40:31'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,137,NULL,NULL,NULL,NULL,1,'2021-03-19 06:40:31',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_PATIENT_ID,5086,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE3,' 06:40:31'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,96,NULL,NULL,NULL,NULL,1,'2021-03-19 06:40:31',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_PATIENT_ID,5092,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE3,' 06:40:31'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,98,NULL,NULL,NULL,NULL,1,'2021-03-19 06:40:31',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL);

/* TODO
Probably update the problem list?
    Urineweginfectie met gram- staven 
    Maculopapuleus exantheem benen/buik tgv allergische reactie op antibiotica DD bij infectie of beginnende graft versus host disease (GvHD) agv 3  
    Ruim 3 mnd na stamceltransplantatie 
dermatoloog in consult vragen
switch naar meropenem
*/


/************************ ZATERDAG *************************/
SET @DAY_OF_WEEK := 'Zaterdag';
SET @CURRENT_PATIENT_IDENTIFIER := @CURRENT_PATIENT_IDENTIFIER +3;
SET @ORDCOUNT := 0; -- first order is always ORD-1, second is ORD-2, etc.

SELECT max(person_id)+1 INTO @CURRENT_PATIENT_ID from person;

/* add patient */
INSERT INTO `person` VALUES(@CURRENT_PATIENT_ID,'F','1977-10-01',0,0,NULL,NULL,1,'2021-03-19 10:36:22',NULL,NULL,0,NULL,NULL,NULL,(select UUID()),0,NULL);
INSERT INTO `patient` VALUES (@CURRENT_PATIENT_ID,1,'2021-03-19 10:36:22',NULL,NULL,0,NULL,NULL,NULL,'Unknown');
INSERT INTO `patient_identifier` (`patient_id`, `identifier`, `identifier_type`, `preferred`, `location_id`, `creator`, `date_created`, `date_changed`, `changed_by`, `voided`, `voided_by`, `date_voided`, `void_reason`, `uuid`) VALUES 
(@CURRENT_PATIENT_ID,@CURRENT_PATIENT_IDENTIFIER,3,1,6,1,'2021-03-19 10:36:23',NULL,NULL,0,NULL,NULL,NULL,(select UUID()));

INSERT INTO `person_address` (`person_id`, `preferred`, `address1`, `address2`, `city_village`, `state_province`, `postal_code`, `country`, `latitude`, `longitude`, `start_date`, `end_date`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `county_district`, `address3`, `address4`, `address5`, `address6`, `date_changed`, `changed_by`, `uuid`, `address7`, `address8`, `address9`, `address10`, `address11`, `address12`, `address13`, `address14`, `address15`) VALUES  
(@CURRENT_PATIENT_ID,1,'Oud Loosdrecht Dijk 1',NULL,'Loosdrecht',NULL,'1234 AA',NULL,NULL,NULL,NULL,NULL,1,'2021-03-19 10:36:23',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,(select UUID()),NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `person_attribute` (`person_id`, `value`, `person_attribute_type_id`, `creator`, `date_created`, `changed_by`, `date_changed`, `voided`, `voided_by`, `date_voided`, `void_reason`, `uuid`) VALUES 
(@CURRENT_PATIENT_ID,'0612345678',8,1,'2021-03-19 10:36:23',NULL,NULL,0,NULL,NULL,NULL,(select UUID()));
INSERT INTO `person_name` (`preferred`, `person_id`, `prefix`, `given_name`, `middle_name`, `family_name_prefix`, `family_name`, `family_name2`, `family_name_suffix`, `degree`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `changed_by`, `date_changed`, `uuid`) VALUES 
(1,@CURRENT_PATIENT_ID,NULL,CONCAT('A.',@DAY_OF_WEEK),NULL,NULL,CONCAT('de Vries',@STUDENT_ID),NULL,NULL,NULL,1,'2021-03-19 10:36:23',0,NULL,NULL,NULL,NULL,NULL,(select UUID()));

/* add patient relations */
INSERT INTO `relationship` (`person_a`, `relationship`, `person_b`, `start_date`, `end_date`, `creator`, `date_created`, `date_changed`, `changed_by`, `voided`, `voided_by`, `date_voided`, `void_reason`, `uuid`) VALUES
(@CURRENT_PATIENT_ID,3,@DAUGHTER_PID,NULL,NULL,1,'2021-03-19 10:36:23',NULL,NULL,0,NULL,NULL,NULL,(select uuid()));

/* copy tuesday*

/* add meds: Each drug order creates an entry in encounter, encounter_provider, orders, and drug_order. */
-- drug order encounters don't have a visit_id
-- technically it is perfectly safe to reset CURRENT_ENC_ID rather than making a new variable, but since the two aren't equal I'm making different vars.
SELECT max(encounter_id)+1 INTO @CURRENT_ENC_ID from encounter;
INSERT INTO `encounter` (`encounter_id`, `encounter_type`, `patient_id`, `location_id`, `form_id`, `encounter_datetime`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `changed_by`, `date_changed`, `visit_id`, `uuid`) VALUES  
(@CURRENT_ENC_ID,8,@CURRENT_PATIENT_ID,NULL,NULL,CONCAT(@CLASS_DATE,' 13:32:04'),1,'2021-03-19 13:32:04',0,NULL,NULL,NULL,NULL,NULL,NULL,(select UUID()));
INSERT INTO `encounter_provider` (`encounter_id`, `provider_id`, `encounter_role_id`, `creator`, `date_created`, `changed_by`, `date_changed`, `voided`, `date_voided`, `voided_by`, `void_reason`, `uuid`) VALUES  
(@CURRENT_ENC_ID,1,2,1,'2021-03-19 13:32:04',NULL,NULL,0,NULL,NULL,NULL,(select uuid()));
-- Order uses encounter_id. Orders that share an encounter_id were signed together.
SELECT max(order_id)+1 INTO @CURRENT_ORD_ID from orders; -- We will count on the orders being inserted sequentially
INSERT INTO `orders` (`order_id`,`order_type_id`, `concept_id`, `orderer`, `encounter_id`, `instructions`, `date_activated`, `auto_expire_date`, `date_stopped`, `order_reason`, `order_reason_non_coded`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `patient_id`, `accession_number`, `uuid`, `urgency`, `order_number`, `previous_order_id`, `order_action`, `comment_to_fulfiller`, `care_setting`, `scheduled_date`, `order_group_id`, `sort_weight`) VALUES 
(@CURRENT_ORD_ID, 2,166299,1,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE,' 13:32:04'),NULL,NULL,NULL,NULL,1,'2021-03-19 13:32:04',0,NULL,NULL,NULL,@CURRENT_PATIENT_ID,NULL,(select uuid()),'ROUTINE',CONCAT('ORD-',@ORDCOUNT+1),NULL,'NEW',NULL,1,NULL,NULL,NULL),
(@CURRENT_ORD_ID +1, 2,165680,1,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE,' 12:58:25'),NULL,NULL,NULL,NULL,1,'2021-03-19 13:32:04',0,NULL,NULL,NULL,@CURRENT_PATIENT_ID,NULL,(select uuid()),'ROUTINE',CONCAT('ORD-',@ORDCOUNT +2),NULL,'NEW',NULL,1,NULL,NULL,NULL);

SET @ORDCOUNT := @ORDCOUNT +2;
-- uses the order_id from the above orders
-- dose is just the literal number entered for the dose (100 mg and 10 mg respectively, in this case)
-- dosing_instructions free text shows up in the summary, structured info does not
-- quantity_units 1513 = tablet; 1514 = packet
-- route 160240 = oral
-- dose_units 161553 = mg
-- frequency 16 = once daily, 11 = twice daily
INSERT INTO `drug_order` (`order_id`, `drug_inventory_id`, `dose`, `as_needed`, `dosing_type`, `quantity`, 
`as_needed_condition`, `num_refills`, `dosing_instructions`, `duration`, `duration_units`, `quantity_units`, 
`route`, `dose_units`, `frequency`, `brand_name`, `dispense_as_written`, `drug_non_coded`) VALUES 
(@CURRENT_ORD_ID,23,100,0,'org.openmrs.SimpleDosingInstructions',90,NULL,0,'1 dd 100 mg',NULL,NULL,1514,160240,161553,16,NULL,0,NULL),
(@CURRENT_ORD_ID +1,67,10,0,'org.openmrs.SimpleDosingInstructions',90,NULL,0,'1 dd 10 mg',NULL,NULL,1513,160240,161553,16,NULL,0,NULL);


/* TODO add
Ciclosporine 2 dd 300 mg 
Cotrimoxazol 1 dd 480 mg 
Hypromellose 3 mg/ml oogdruppels 4 dd zn 
Macrogol/zouten sachet 1 dd 1 zn 
Metoclopramide 3 dd 10 mg zn 
Magnesiumgluconaat 2 dd 1 gr 
Omeprazol 1 dd 40 mg 
Valaciclovir 2 dd 500 mg 
*/

/* start visit */
SELECT max(visit_id)+1 INTO @CURRENT_VISIT_ID from visit;
INSERT INTO `visit` (`visit_id`,`patient_id`, `visit_type_id`, `date_started`, `date_stopped`, `indication_concept_id`, `location_id`, `creator`, `date_created`, `changed_by`, `date_changed`, `voided`, `voided_by`, `date_voided`, `void_reason`, `uuid`) VALUES 
(@CURRENT_VISIT_ID, @CURRENT_PATIENT_ID,1,CONCAT(@CLASS_DATE,' 13:12:39'),NULL,NULL,8,1,'2021-03-19 13:12:39',NULL,NULL,0,NULL,NULL,NULL, (select UUID()));

/* add visit diagnosis and note*/
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
(@CURRENT_PATIENT_ID,1284,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE,' 13:27:14'),6,@CURRENT_OBS_ID,NULL,NULL,121629,127494,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'2021-03-19 13:27:14',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_PATIENT_ID,162169,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE,' 13:27:14'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Opnamestatus op dinsdag \nVoorgeschiedenis: \nRefractair Hodgkin lymfoom (HL) wv allogene stamceltransplantatie (nov-2020) 01-04-2019 Prioriteit: Hoog \nIntentietremor zonder sensibiliteits- of motorische uitval DD bijwerking bij ciclosporine (>10%) 15-12-2020 \nstent in RCA 01-01-2017 \ninspanningsgerelateerde astma 01-01-1995 \n\nMedicatie bij opname: \nAmlodipine 1 dd 10 mg \nCarbasalaatcalcium poeder 1 dd 100 mg \nCiclosporine 2 dd 300 mg \nCotrimoxazol 1 dd 480 mg \nHypromellose 3 mg/ml oogdruppels 4 dd zn \nMacrogol/zouten sachet 1 dd 1 zn \nMetoclopramide 3 dd 10 mg zn \nMagnesiumgluconaat 2 dd 1 gr \nOmeprazol 1 dd 40 mg \nValaciclovir 2 dd 500 mg \n\nIntoxicaties: Geen \nAllergieën: Niet voor zover bekend \n\nRvO/ anemie bij status na refractair Hodgkin lymfoom waarvoor allogene stamceltransplantatie (+3 maanden) \n\nAnamnese: \nWas vorige week nog op policontrole geweest, ging toen wel goed. Echter sinds 2 dagen toenemend vermoeid, geen energie meer. Hierop belde zij naar de SEH en is derhalve gekomen. Eetlust is nog matig, maar onveranderd sinds de stamceltransplantatie. Niet misselijk of braken, ook geen diarree. Mictie iets branderig, maar niet hele tijd. Niet ziek geweest, klein hoestje, soms wat kortademig gevoel, wisselend aanwezig. Geen koorts bemerkt. Geen huidafwijkingen gezien. \n\nTractus anamnese: behoudens iets vocht vasthouden in de benen, geen bijzonderheden. \n\nLichamelijk onderzoek: \nT 36.8°C, P 85/min, RR 126/86mmHg, AH 16/min, O2-sat 98% zonder O2-suppletie  \nAlgemene indruk: helder, niet acuut zieke, maar wel zwak ogende patiënte \nH/H: in de mond geen afwijkingen, geen lymfadenopathie \nCor: normale harttonen, geen souffles \nPulm: normaal ademgeruis zonder bijgeluiden \nAbd: normale peristaltiek, wisselende tympanie, soepel, geen drukpijn, geen weerstanden \nExtr: iets pitting oedeem rondom de enkels, goed voelbare pulsaties  \n\nAO/ laag Hb, iets verhoogd CRP\n \nC/ \n1. Symptomatisch anemie  \n2. Ruim 3 maanden na stamceltransplantatie in verband met HL\n\nB/ \nAd 1 \nOpname op acute opname afdeling voor 2 erytrocyten transfusies (bestraald/parvo-B19 veilig) \nVolledig beleid, normaal dieet \nDoor met thuismedicatie \nIn principe morgenochtend naar huis',NULL,NULL,1,'2021-03-19 16:17:49',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL);

/* add vitals */
SELECT max(encounter_id)+1 INTO @CURRENT_ENC_ID from encounter;
INSERT INTO `encounter` (`encounter_id`,`encounter_type`, `patient_id`, `location_id`, `form_id`, `encounter_datetime`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `changed_by`, `date_changed`, `visit_id`, `uuid`) VALUES
(@CURRENT_ENC_ID, 7,@CURRENT_PATIENT_ID,6,1,CONCAT(@CLASS_DATE,' 14:21:31'),1,'2021-03-19 14:21:31',0,NULL,NULL,NULL,NULL,NULL,@CURRENT_VISIT_ID,(select uuid()));
-- uses encounter_id from above
INSERT INTO `encounter_provider` (`encounter_id`, `provider_id`, `encounter_role_id`, `creator`, `date_created`, `changed_by`, `date_changed`, `voided`, `date_voided`, `voided_by`, `void_reason`, `uuid`) VALUES 
(@CURRENT_ENC_ID,1,2,1,'2021-03-19 14:21:31',NULL,NULL,0,NULL,NULL,NULL,(select uuid()));
-- uses encounter_id from above. each vital meas gets an obs entry. Doesn't seem to use obs_group_id 
INSERT INTO `obs` (`person_id`, `concept_id`, `encounter_id`, `order_id`, `obs_datetime`, `location_id`, `obs_group_id`,`accession_number`, `value_group_id`, `value_coded`, `value_coded_name_id`, `value_drug`, `value_datetime`, `value_numeric`, `value_modifier`, `value_text`, `value_complex`, `comments`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `uuid`, `previous_version`, `form_namespace_and_path`, `status`, `interpretation`) VALUES 
(@CURRENT_PATIENT_ID,5088,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE,' 14:21:31'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,36.8,NULL,NULL,NULL,NULL,1,'2021-03-19 14:21:31',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_PATIENT_ID,5087,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE,' 14:21:31'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,85,NULL,NULL,NULL,NULL,1,'2021-03-19 14:21:31',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_PATIENT_ID,5242,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE,' 14:21:31'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16,NULL,NULL,NULL,NULL,1,'2021-03-19 14:21:31',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_PATIENT_ID,5085,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE,' 14:21:31'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,126,NULL,NULL,NULL,NULL,1,'2021-03-19 14:21:31',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_PATIENT_ID,5086,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE,' 14:21:31'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,86,NULL,NULL,NULL,NULL,1,'2021-03-19 14:21:31',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_PATIENT_ID,5092,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE,' 14:21:31'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,98,NULL,NULL,NULL,NULL,1,'2021-03-19 14:21:31',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL);

/* admit patient */
SELECT max(encounter_id)+1 INTO @CURRENT_ENC_ID from encounter;
INSERT INTO `encounter` (`encounter_id`, `encounter_type`, `patient_id`, `location_id`, `form_id`, `encounter_datetime`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `changed_by`, `date_changed`, `visit_id`, `uuid`) VALUES
(@CURRENT_ENC_ID,2,@CURRENT_PATIENT_ID,9,3,CONCAT(@CLASS_DATE,' 14:38:05'),1,'2021-03-19 14:38:05',0,NULL,NULL,NULL,NULL,NULL,@CURRENT_VISIT_ID,(select uuid()));

-- uses encounter_id from above
INSERT INTO `encounter_provider` (`encounter_id`, `provider_id`, `encounter_role_id`, `creator`, `date_created`, `changed_by`, `date_changed`, `voided`, `date_voided`, `voided_by`, `void_reason`, `uuid`) VALUES 
(@CURRENT_ENC_ID,1,1,1,'2021-03-19 14:38:05',NULL,NULL,0,NULL,NULL,NULL,(select uuid()));

/*TODO add 2 erytrocyten transfusies */

/* labs */
INSERT INTO `obs` (`person_id`, `concept_id`, `encounter_id`, `order_id`, `obs_datetime`, `location_id`, `obs_group_id`,`accession_number`, `value_group_id`, `value_coded`, `value_coded_name_id`, `value_drug`, `value_datetime`, `value_numeric`, `value_modifier`, `value_text`, `value_complex`, `comments`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `uuid`, `previous_version`, `form_namespace_and_path`, `status`, `interpretation`) VALUES 
(@CURRENT_PATIENT_ID,169763,NULL,NULL,@CLASS_DATE,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,78,NULL,NULL,NULL,'',1,'2021-04-09 17:35:51',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL), -- Kreatinine	umol/l	65-95		78
(@CURRENT_PATIENT_ID,169764,NULL,NULL,@CLASS_DATE,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,90,NULL,NULL,NULL,'> 90',1,'2021-04-09 17:37:15',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL), -- eGFR (CKD-EPI)	ml/min/1,73m^2		>90
(@CURRENT_PATIENT_ID,169743,NULL,NULL,@CLASS_DATE,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,5.6,NULL,NULL,NULL,'',1,'2021-04-09 17:43:52',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL), -- Glucose	mmol/l	4,1-5,6			5,9
(@CURRENT_PATIENT_ID,169775,NULL,NULL,@CLASS_DATE,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,19,NULL,NULL,NULL,'',1,'2021-04-09 17:44:29',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL), -- Bilirubine (totaal)	umol/l	0-17	19
(@CURRENT_PATIENT_ID,169770,NULL,NULL,@CLASS_DATE,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16,NULL,NULL,NULL,'',1,'2021-04-09 17:48:02',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL), -- aspartate aminotransferase (AST)	16
(@CURRENT_PATIENT_ID,169769,NULL,NULL,@CLASS_DATE,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,51,NULL,NULL,NULL,'',1,'2021-04-09 17:49:07',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL), -- alanine aminotransferase (ALT)		51
(@CURRENT_PATIENT_ID,169771,NULL,NULL,@CLASS_DATE,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,127,NULL,NULL,NULL,'',1,'2021-04-09 17:50:21',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL), -- Gamma-glutamyl transferase (GGT)	127
(@CURRENT_PATIENT_ID,169768,NULL,NULL,@CLASS_DATE,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,71,NULL,NULL,NULL,'',1,'2021-04-09 17:51:11',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL); -- Alkaline phosphatase (ALKP)		71

/* end copying tuesday / start copy wed */

/* add the note */
SELECT max(encounter_id)+1 INTO @CURRENT_ENC_ID from encounter;
INSERT INTO `encounter` (`encounter_id`,`encounter_type`, `patient_id`, `location_id`, `form_id`, `encounter_datetime`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `changed_by`, `date_changed`, `visit_id`, `uuid`) VALUES
(@CURRENT_ENC_ID,3,@CURRENT_PATIENT_ID,6,2,CONCAT(@CLASS_DATE2,' 07:06:30'),1,'2021-03-19 16:17:21',0,NULL,NULL,NULL,NULL,NULL,@CURRENT_VISIT_ID,(select uuid()));
-- uses encounter_id from the above encounter
INSERT INTO `encounter_provider` (`encounter_id`, `provider_id`, `encounter_role_id`, `creator`, `date_created`, `changed_by`, `date_changed`, `voided`, `date_voided`, `voided_by`, `void_reason`, `uuid`) VALUES 
(@CURRENT_ENC_ID,1,1,1,'2021-03-19 16:17:21',NULL,NULL,0,NULL,NULL,NULL,(select uuid()));
SELECT max(obs_id)+1 INTO @CURRENT_OBS_ID from obs;
INSERT INTO `obs` VALUES
(@CURRENT_OBS_ID,@CURRENT_PATIENT_ID,159947,@CURRENT_ENC_ID,NULL,'2021-03-20 15:20:39',6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'2021-03-20 15:20:39',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_OBS_ID+1,@CURRENT_PATIENT_ID,159946,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE2,' 07:06:30'),6,@CURRENT_OBS_ID,NULL,NULL,159943,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'2021-03-20 15:20:39',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_OBS_ID+2,@CURRENT_PATIENT_ID,159394,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE2,' 07:06:30'),6,@CURRENT_OBS_ID,NULL,NULL,159393,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'2021-03-20 15:20:39',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_OBS_ID+3,@CURRENT_PATIENT_ID,1284,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE,' 07:06:30'),6,@CURRENT_OBS_ID,NULL,NULL,121629,127494,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'2021-03-20 15:20:39',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_OBS_ID+4,@CURRENT_PATIENT_ID,162169,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE2,' 07:06:30'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'RvO: symptomatische anemie \n \nVPK: vannacht transfusies ingelopen zonder problemen, verder rustige nacht, maar in ochtend koorts gemeten \n \nA/ \nZij voelt zich wat beter na de transfusies, wel nog steeds last van dysurie. Heeft ook gevoel van kleine beetjes te plassen. Zij hoest niet echt, geen keelpijn, maar soms iets kortademig gevoel, trekt nu ook weer weg. Niet echt snotterig. Iets licht in het hoofd. Werd vanochtend wel zweterig wakker, voelt zich niet koortsig. Niet misselijk. Ontlasting lijkt vanochtend ook iets dunner. Geen huidafwijkingen.  \n \nLichamelijk onderzoek: \nT 38,6°C, P 110/min, RR 110/70mmHg, AH 14/min, O2-sat 96% zonder O2-suppletie \nAlgemene indruk: helder, niet acuut ziek \nH/H: geen lymfadenopathie, in de mond mogelijk iets roodheid in de keel, overig geen afwijkingen \nCor: normale harttonen, geen souffles \nPulm: vesiculair ademgeruis zonder bijgeluiden \nAbd: normale peristaltiek, wisselende tympanie, soepel, geen druk- of loslaatpijn, geen weerstanden \nExtr: normale pulsaties, geen oedeem  \n \nAO/ geen \n \nConclusie \n    Koorts, tachycardie, dysurie, tevens iets dyspneu DD UWI, toch pneumonie, virale bovenste luchtweginfectie  \n    Ruim 3 maanden na stamceltransplantatie in verband met HL \n \nBeleid \nAd 1 \nBloedkweken afnemen, tevens CRP \nSediment plus urinekweek  \nIndien diarree dan ook feceskweek (SSYC, clostridium en virussen) \nRespiratoir virus pakket, incl COVID \nX-thorax \nStart cefriaxon 1 dd 2000 mg + gentamicine 5 mg/kg \nAdvies minimaal 1,5 liter drinken (indien dat niet lukt infuus starten) \n \nAddendum om 16 uur: \nAO/ CRP verder gestegen, Hb wel mooi gestegen, COVID negatief \nX-thorax: ongewijzigd thoraxbeeld met postradiatieveranderingen rechts apicaal. Geen nieuwe voor pneumonie verdachte verdichtingen.  \nC/ \nKoorts, tachycardie, dysurie en leukocyturie passend bij urineweginfectie \nB/ \nZo door ',NULL,NULL,1,'2021-03-20 15:20:39',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL);

/* add some more vitals */
SELECT max(encounter_id)+1 INTO @CURRENT_ENC_ID from encounter;
INSERT INTO `encounter` (`encounter_id`,`encounter_type`, `patient_id`, `location_id`, `form_id`, `encounter_datetime`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `changed_by`, `date_changed`, `visit_id`, `uuid`) VALUES
(@CURRENT_ENC_ID, 7,@CURRENT_PATIENT_ID,6,1,CONCAT(@CLASS_DATE2,' 07:21:31'),1,'2021-03-19 07:21:31',0,NULL,NULL,NULL,NULL,NULL,@CURRENT_VISIT_ID,(select uuid()));
-- uses encounter_id from above
INSERT INTO `encounter_provider` (`encounter_id`, `provider_id`, `encounter_role_id`, `creator`, `date_created`, `changed_by`, `date_changed`, `voided`, `date_voided`, `voided_by`, `void_reason`, `uuid`) VALUES 
(@CURRENT_ENC_ID,1,2,1,'2021-03-19 07:21:31',NULL,NULL,0,NULL,NULL,NULL,(select uuid()));
-- uses encounter_id from above. each vital meas gets an obs entry. Doesn't seem to use obs_group_id 
INSERT INTO `obs` (`person_id`, `concept_id`, `encounter_id`, `order_id`, `obs_datetime`, `location_id`, `obs_group_id`,`accession_number`, `value_group_id`, `value_coded`, `value_coded_name_id`, `value_drug`, `value_datetime`, `value_numeric`, `value_modifier`, `value_text`, `value_complex`, `comments`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `uuid`, `previous_version`, `form_namespace_and_path`, `status`, `interpretation`) VALUES 
(@CURRENT_PATIENT_ID,5088,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE2,' 07:21:31'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,38.6,NULL,NULL,NULL,NULL,1,'2021-03-19 07:21:31',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_PATIENT_ID,5087,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE2,' 07:21:31'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,110,NULL,NULL,NULL,NULL,1,'2021-03-19 07:21:31',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_PATIENT_ID,5242,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE2,' 07:21:31'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,14,NULL,NULL,NULL,NULL,1,'2021-03-19 07:21:31',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_PATIENT_ID,5085,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE2,' 07:21:31'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,110,NULL,NULL,NULL,NULL,1,'2021-03-19 07:21:31',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_PATIENT_ID,5086,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE2,' 07:21:31'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,70,NULL,NULL,NULL,NULL,1,'2021-03-19 07:21:31',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_PATIENT_ID,5092,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE2,' 07:21:31'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,96,NULL,NULL,NULL,NULL,1,'2021-03-19 07:21:31',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL);

/* TODO probably need to add diagnoses/problem list items:
    Koorts, tachycardie, dysurie, tevens iets dyspneu DD UWI, toch pneumonie, virale bovenste luchtweginfectie  
Also orders: 
Bloedkweken afnemen, tevens CRP 
Sediment plus urinekweek  
Indien diarree dan ook feceskweek (SSYC, clostridium en virussen) 
Respiratoir virus pakket, incl COVID 
X-thorax 
Start cefriaxon 1 dd 2000 mg + gentamicine 5 mg/kg 

At 16:00 adjust diagnoses/problem list:
Koorts, tachycardie, dysurie en leukocyturie passend bij urineweginfectie
*/

/* end copy wed / start copy thurs*/

/* add thursday's note */
SELECT max(encounter_id)+1 INTO @CURRENT_ENC_ID from encounter;
INSERT INTO `encounter` (`encounter_id`,`encounter_type`, `patient_id`, `location_id`, `form_id`, `encounter_datetime`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `changed_by`, `date_changed`, `visit_id`, `uuid`) VALUES
(@CURRENT_ENC_ID,3,@CURRENT_PATIENT_ID,6,2,CONCAT(@CLASS_DATE3,' 06:51:30'),1,'2021-03-19 16:17:21',0,NULL,NULL,NULL,NULL,NULL,@CURRENT_VISIT_ID,(select uuid()));
-- uses encounter_id from the above encounter
INSERT INTO `encounter_provider` (`encounter_id`, `provider_id`, `encounter_role_id`, `creator`, `date_created`, `changed_by`, `date_changed`, `voided`, `date_voided`, `voided_by`, `void_reason`, `uuid`) VALUES 
(@CURRENT_ENC_ID,1,1,1,'2021-03-19 16:17:21',NULL,NULL,0,NULL,NULL,NULL,(select uuid()));
SELECT max(obs_id)+1 INTO @CURRENT_OBS_ID from obs;
INSERT INTO `obs` VALUES
(@CURRENT_OBS_ID,@CURRENT_PATIENT_ID,159947,@CURRENT_ENC_ID,NULL,'2021-03-20 15:20:39',6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'2021-03-20 15:20:39',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_OBS_ID+1,@CURRENT_PATIENT_ID,159946,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE3,' 06:51:30'),6,@CURRENT_OBS_ID,NULL,NULL,159943,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'2021-03-20 15:20:39',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_OBS_ID+2,@CURRENT_PATIENT_ID,159394,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE3,' 06:51:30'),6,@CURRENT_OBS_ID,NULL,NULL,159393,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'2021-03-20 15:20:39',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_OBS_ID+3,@CURRENT_PATIENT_ID,1284,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE,' 06:51:30'),6,@CURRENT_OBS_ID,NULL,NULL,121629,127494,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'2021-03-20 15:20:39',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_OBS_ID+4,@CURRENT_PATIENT_ID,162169,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE3,' 06:51:30'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'RvO/ verdenking urineweginfectie \n \nVPK/ Nog wel zwak, koorts afgezakt, branderig pijn tijdens mictie nog wel aanwezig, heeft sinds vannacht jeuk en roodheid op de benen, ook beetje op de buik.  \n \nA/ Voelt zich nog iets vermoeid, wel nog dysurie, hoesten/kortademigheid niet meer. \n \nLO/ T 37,8°C, P 96/min, RR 137/96mmHg, AH 12/min, O2-sat 98% zonder O2-suppletie  \nMaculopapuleuze afwijkingen op bovenbenen, ook in mindere mate op de onderbenen, aantal vlekken op buik.  \n \nAO/  \nGram- staven uit urinekweek, determinatie volgt, bloedkweek vooralsnog negatief \n \nC/  \n    Urineweginfectie met gram- staven \n    Maculopapuleus exantheem benen/buik tgv allergische reactie op antibiotica DD bij infectie of beginnende graft versus host disease (GvHD) agv 3  \n    Ruim 3 mnd na stamceltransplantatie \n \nB/  \n \nAd 1/2  \n    Roodheid aftekenen \n    Gezien huidreactie dermatoloog in consult vragen, passend bij geneesmiddelallergie of toch beginnende GvHD \n    Determinatie urinekweek afwachten en bloedkweek, switch naar meropenem (gezien mgl kruisreactiviteit met andere antibiotica) \n',NULL,NULL,1,'2021-03-20 15:20:39',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL);

/* add some more vitals */
SELECT max(encounter_id)+1 INTO @CURRENT_ENC_ID from encounter;
INSERT INTO `encounter` (`encounter_id`,`encounter_type`, `patient_id`, `location_id`, `form_id`, `encounter_datetime`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `changed_by`, `date_changed`, `visit_id`, `uuid`) VALUES
(@CURRENT_ENC_ID, 7,@CURRENT_PATIENT_ID,6,1,CONCAT(@CLASS_DATE3,' 06:40:31'),1,'2021-03-19 06:40:31',0,NULL,NULL,NULL,NULL,NULL,@CURRENT_VISIT_ID,(select uuid()));
-- uses encounter_id from above
INSERT INTO `encounter_provider` (`encounter_id`, `provider_id`, `encounter_role_id`, `creator`, `date_created`, `changed_by`, `date_changed`, `voided`, `date_voided`, `voided_by`, `void_reason`, `uuid`) VALUES 
(@CURRENT_ENC_ID,1,2,1,'2021-03-19 06:40:31',NULL,NULL,0,NULL,NULL,NULL,(select uuid()));
-- uses encounter_id from above. each vital meas gets an obs entry. Doesn't seem to use obs_group_id 
INSERT INTO `obs` (`person_id`, `concept_id`, `encounter_id`, `order_id`, `obs_datetime`, `location_id`, `obs_group_id`,`accession_number`, `value_group_id`, `value_coded`, `value_coded_name_id`, `value_drug`, `value_datetime`, `value_numeric`, `value_modifier`, `value_text`, `value_complex`, `comments`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `uuid`, `previous_version`, `form_namespace_and_path`, `status`, `interpretation`) VALUES 
(@CURRENT_PATIENT_ID,5088,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE3,' 06:40:31'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,37.8,NULL,NULL,NULL,NULL,1,'2021-03-19 06:40:31',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_PATIENT_ID,5087,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE3,' 06:40:31'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,96,NULL,NULL,NULL,NULL,1,'2021-03-19 06:40:31',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_PATIENT_ID,5242,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE3,' 06:40:31'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,12,NULL,NULL,NULL,NULL,1,'2021-03-19 06:40:31',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_PATIENT_ID,5085,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE3,' 06:40:31'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,137,NULL,NULL,NULL,NULL,1,'2021-03-19 06:40:31',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_PATIENT_ID,5086,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE3,' 06:40:31'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,96,NULL,NULL,NULL,NULL,1,'2021-03-19 06:40:31',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_PATIENT_ID,5092,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE3,' 06:40:31'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,98,NULL,NULL,NULL,NULL,1,'2021-03-19 06:40:31',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL);

/* TODO
Probably update the problem list?
    Urineweginfectie met gram- staven 
    Maculopapuleus exantheem benen/buik tgv allergische reactie op antibiotica DD bij infectie of beginnende graft versus host disease (GvHD) agv 3  
    Ruim 3 mnd na stamceltransplantatie 
dermatoloog in consult vragen
switch naar meropenem
*/

/* end copy thurs */

/* add friday's note */
SELECT max(encounter_id)+1 INTO @CURRENT_ENC_ID from encounter;
INSERT INTO `encounter` (`encounter_id`,`encounter_type`, `patient_id`, `location_id`, `form_id`, `encounter_datetime`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `changed_by`, `date_changed`, `visit_id`, `uuid`) VALUES
(@CURRENT_ENC_ID,3,@CURRENT_PATIENT_ID,6,2,CONCAT(@CLASS_DATE4,' 07:06:30'),1,'2021-03-19 16:17:21',0,NULL,NULL,NULL,NULL,NULL,@CURRENT_VISIT_ID,(select uuid()));
-- uses encounter_id from the above encounter
INSERT INTO `encounter_provider` (`encounter_id`, `provider_id`, `encounter_role_id`, `creator`, `date_created`, `changed_by`, `date_changed`, `voided`, `date_voided`, `voided_by`, `void_reason`, `uuid`) VALUES 
(@CURRENT_ENC_ID,1,1,1,'2021-03-19 16:17:21',NULL,NULL,0,NULL,NULL,NULL,(select uuid()));
SELECT max(obs_id)+1 INTO @CURRENT_OBS_ID from obs;
INSERT INTO `obs` VALUES
(@CURRENT_OBS_ID,@CURRENT_PATIENT_ID,159947,@CURRENT_ENC_ID,NULL,'2021-03-20 15:20:39',6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'2021-03-20 15:20:39',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_OBS_ID+1,@CURRENT_PATIENT_ID,159946,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE4,' 08:21:30'),6,@CURRENT_OBS_ID,NULL,NULL,159943,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'2021-03-20 15:20:39',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_OBS_ID+2,@CURRENT_PATIENT_ID,159394,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE4,' 08:21:30'),6,@CURRENT_OBS_ID,NULL,NULL,159393,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'2021-03-20 15:20:39',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_OBS_ID+3,@CURRENT_PATIENT_ID,1284,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE,' 08:21:30'),6,@CURRENT_OBS_ID,NULL,NULL,121629,127494,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'2021-03-20 15:20:39',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_OBS_ID+4,@CURRENT_PATIENT_ID,162169,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE4,' 08:21:30'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'RvO/ urineweginfectie  \n \nVPK/ voelt zich beter, minder pijn bij plassen \n \nA/ voelt zich al met al wel wat beter, voelt zich fitter, eetlust komt terug, roodheid minimaal uitgebreid \n \nLO/ T 37,4°C, P 89/min, RR 122/88 mmHg, AH 12/min, O2-sat 96% zonder O2-suppletie  \nMaculopapuleuze afwijkingen op bovenbenen minimaal toegenomen  \n \nAO/  \nHb wat gezakt (wrs door infectie bij “jonge” beenmerg) \nE. coli goed gevoelig, ook orale opties \n \nC/  \n    Urineweginfectie met E. coli (geen ESBL) \n    Maculopapuleus exantheem benen/buik waarschijnlijk ten gevolge van ceftriaxon CAVE beginnende GvHD \n    Ruim 3 mnd na stamceltransplantatie \n \nB/  \nAd 1  \nOver naar ciprofloxacine 2 dd 500 mg \n \nAd 2 \nTerugkoppeling van dermatoloog: beeld passend bij geneesmiddelallergie, beginnende GvHD niet uit te sluiten \nWait and see, bij evidente toename dan huidbiopt afnemen \n \nAd 3 \nNog 1x erytrocyten transfusie ',NULL,NULL,1,'2021-03-20 15:20:39',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL);

/* add some more vitals */
SELECT max(encounter_id)+1 INTO @CURRENT_ENC_ID from encounter;
INSERT INTO `encounter` (`encounter_id`,`encounter_type`, `patient_id`, `location_id`, `form_id`, `encounter_datetime`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `changed_by`, `date_changed`, `visit_id`, `uuid`) VALUES
(@CURRENT_ENC_ID, 7,@CURRENT_PATIENT_ID,6,1,CONCAT(@CLASS_DATE4,' 06:59:31'),1,'2021-03-19 06:59:31',0,NULL,NULL,NULL,NULL,NULL,@CURRENT_VISIT_ID,(select uuid()));
-- uses encounter_id from above
INSERT INTO `encounter_provider` (`encounter_id`, `provider_id`, `encounter_role_id`, `creator`, `date_created`, `changed_by`, `date_changed`, `voided`, `date_voided`, `voided_by`, `void_reason`, `uuid`) VALUES 
(@CURRENT_ENC_ID,1,2,1,'2021-03-19 06:59:31',NULL,NULL,0,NULL,NULL,NULL,(select uuid()));
-- uses encounter_id from above. each vital meas gets an obs entry. Doesn't seem to use obs_group_id 
INSERT INTO `obs` (`person_id`, `concept_id`, `encounter_id`, `order_id`, `obs_datetime`, `location_id`, `obs_group_id`,`accession_number`, `value_group_id`, `value_coded`, `value_coded_name_id`, `value_drug`, `value_datetime`, `value_numeric`, `value_modifier`, `value_text`, `value_complex`, `comments`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `uuid`, `previous_version`, `form_namespace_and_path`, `status`, `interpretation`) VALUES 
(@CURRENT_PATIENT_ID,5088,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE4,' 06:59:31'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,37.4,NULL,NULL,NULL,NULL,1,'2021-03-19 06:59:31',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_PATIENT_ID,5087,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE4,' 06:59:31'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,89,NULL,NULL,NULL,NULL,1,'2021-03-19 06:59:31',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_PATIENT_ID,5242,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE4,' 06:59:31'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,12,NULL,NULL,NULL,NULL,1,'2021-03-19 06:59:31',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_PATIENT_ID,5085,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE4,' 06:59:31'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,128,NULL,NULL,NULL,NULL,1,'2021-03-19 06:59:31',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_PATIENT_ID,5086,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE4,' 06:59:31'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,88,NULL,NULL,NULL,NULL,1,'2021-03-19 06:59:31',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_PATIENT_ID,5092,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE4,' 06:59:31'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,96,NULL,NULL,NULL,NULL,1,'2021-03-19 06:59:31',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL);

/* TODO probably add
diagnoses
    Urineweginfectie met E. coli (geen ESBL) 
    Maculopapuleus exantheem benen/buik waarschijnlijk ten gevolge van ceftriaxon CAVE beginnende GvHD 
    Ruim 3 mnd na stamceltransplantatie 
Meds: 
	Over naar ciprofloxacine 2 dd 500 mg 
	Nog 1x erytrocyten transfusie 
Terugkoppeling van dermatoloog: beeld passend bij geneesmiddelallergie, beginnende GvHD niet uit te sluiten 
*/ 

/************************ ZATERDAG *************************/
SET @DAY_OF_WEEK := 'Zaterdag';
SET @CURRENT_PATIENT_IDENTIFIER := @CURRENT_PATIENT_IDENTIFIER +4;
SET @ORDCOUNT := 0; -- first order is always ORD-1, second is ORD-2, etc.

SELECT max(person_id)+1 INTO @CURRENT_PATIENT_ID from person;

/* add patient */
INSERT INTO `person` VALUES(@CURRENT_PATIENT_ID,'F','1977-10-01',0,0,NULL,NULL,1,'2021-03-19 10:36:22',NULL,NULL,0,NULL,NULL,NULL,(select UUID()),0,NULL);
INSERT INTO `patient` VALUES (@CURRENT_PATIENT_ID,1,'2021-03-19 10:36:22',NULL,NULL,0,NULL,NULL,NULL,'Unknown');
INSERT INTO `patient_identifier` (`patient_id`, `identifier`, `identifier_type`, `preferred`, `location_id`, `creator`, `date_created`, `date_changed`, `changed_by`, `voided`, `voided_by`, `date_voided`, `void_reason`, `uuid`) VALUES 
(@CURRENT_PATIENT_ID,@CURRENT_PATIENT_IDENTIFIER,3,1,6,1,'2021-03-19 10:36:23',NULL,NULL,0,NULL,NULL,NULL,(select UUID()));

INSERT INTO `person_address` (`person_id`, `preferred`, `address1`, `address2`, `city_village`, `state_province`, `postal_code`, `country`, `latitude`, `longitude`, `start_date`, `end_date`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `county_district`, `address3`, `address4`, `address5`, `address6`, `date_changed`, `changed_by`, `uuid`, `address7`, `address8`, `address9`, `address10`, `address11`, `address12`, `address13`, `address14`, `address15`) VALUES  
(@CURRENT_PATIENT_ID,1,'Oud Loosdrecht Dijk 1',NULL,'Loosdrecht',NULL,'1234 AA',NULL,NULL,NULL,NULL,NULL,1,'2021-03-19 10:36:23',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,(select UUID()),NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `person_attribute` (`person_id`, `value`, `person_attribute_type_id`, `creator`, `date_created`, `changed_by`, `date_changed`, `voided`, `voided_by`, `date_voided`, `void_reason`, `uuid`) VALUES 
(@CURRENT_PATIENT_ID,'0612345678',8,1,'2021-03-19 10:36:23',NULL,NULL,0,NULL,NULL,NULL,(select UUID()));
INSERT INTO `person_name` (`preferred`, `person_id`, `prefix`, `given_name`, `middle_name`, `family_name_prefix`, `family_name`, `family_name2`, `family_name_suffix`, `degree`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `changed_by`, `date_changed`, `uuid`) VALUES 
(1,@CURRENT_PATIENT_ID,NULL,CONCAT('A.',@DAY_OF_WEEK),NULL,NULL,CONCAT('de Vries',@STUDENT_ID),NULL,NULL,NULL,1,'2021-03-19 10:36:23',0,NULL,NULL,NULL,NULL,NULL,(select UUID()));

/* add patient relations */
INSERT INTO `relationship` (`person_a`, `relationship`, `person_b`, `start_date`, `end_date`, `creator`, `date_created`, `date_changed`, `changed_by`, `voided`, `voided_by`, `date_voided`, `void_reason`, `uuid`) VALUES
(@CURRENT_PATIENT_ID,3,@DAUGHTER_PID,NULL,NULL,1,'2021-03-19 10:36:23',NULL,NULL,0,NULL,NULL,NULL,(select uuid()));

/* copy tuesday*

/* add meds: Each drug order creates an entry in encounter, encounter_provider, orders, and drug_order. */
-- drug order encounters don't have a visit_id
-- technically it is perfectly safe to reset CURRENT_ENC_ID rather than making a new variable, but since the two aren't equal I'm making different vars.
SELECT max(encounter_id)+1 INTO @CURRENT_ENC_ID from encounter;
INSERT INTO `encounter` (`encounter_id`, `encounter_type`, `patient_id`, `location_id`, `form_id`, `encounter_datetime`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `changed_by`, `date_changed`, `visit_id`, `uuid`) VALUES  
(@CURRENT_ENC_ID,8,@CURRENT_PATIENT_ID,NULL,NULL,CONCAT(@CLASS_DATE,' 13:32:04'),1,'2021-03-19 13:32:04',0,NULL,NULL,NULL,NULL,NULL,NULL,(select UUID()));
INSERT INTO `encounter_provider` (`encounter_id`, `provider_id`, `encounter_role_id`, `creator`, `date_created`, `changed_by`, `date_changed`, `voided`, `date_voided`, `voided_by`, `void_reason`, `uuid`) VALUES  
(@CURRENT_ENC_ID,1,2,1,'2021-03-19 13:32:04',NULL,NULL,0,NULL,NULL,NULL,(select uuid()));
-- Order uses encounter_id. Orders that share an encounter_id were signed together.
SELECT max(order_id)+1 INTO @CURRENT_ORD_ID from orders; -- We will count on the orders being inserted sequentially
INSERT INTO `orders` (`order_id`,`order_type_id`, `concept_id`, `orderer`, `encounter_id`, `instructions`, `date_activated`, `auto_expire_date`, `date_stopped`, `order_reason`, `order_reason_non_coded`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `patient_id`, `accession_number`, `uuid`, `urgency`, `order_number`, `previous_order_id`, `order_action`, `comment_to_fulfiller`, `care_setting`, `scheduled_date`, `order_group_id`, `sort_weight`) VALUES 
(@CURRENT_ORD_ID, 2,166299,1,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE,' 13:32:04'),NULL,NULL,NULL,NULL,1,'2021-03-19 13:32:04',0,NULL,NULL,NULL,@CURRENT_PATIENT_ID,NULL,(select uuid()),'ROUTINE',CONCAT('ORD-',@ORDCOUNT+1),NULL,'NEW',NULL,1,NULL,NULL,NULL),
(@CURRENT_ORD_ID +1, 2,165680,1,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE,' 12:58:25'),NULL,NULL,NULL,NULL,1,'2021-03-19 13:32:04',0,NULL,NULL,NULL,@CURRENT_PATIENT_ID,NULL,(select uuid()),'ROUTINE',CONCAT('ORD-',@ORDCOUNT +2),NULL,'NEW',NULL,1,NULL,NULL,NULL);

SET @ORDCOUNT := @ORDCOUNT +2;
-- uses the order_id from the above orders
-- dose is just the literal number entered for the dose (100 mg and 10 mg respectively, in this case)
-- dosing_instructions free text shows up in the summary, structured info does not
-- quantity_units 1513 = tablet; 1514 = packet
-- route 160240 = oral
-- dose_units 161553 = mg
-- frequency 16 = once daily, 11 = twice daily
INSERT INTO `drug_order` (`order_id`, `drug_inventory_id`, `dose`, `as_needed`, `dosing_type`, `quantity`, 
`as_needed_condition`, `num_refills`, `dosing_instructions`, `duration`, `duration_units`, `quantity_units`, 
`route`, `dose_units`, `frequency`, `brand_name`, `dispense_as_written`, `drug_non_coded`) VALUES 
(@CURRENT_ORD_ID,23,100,0,'org.openmrs.SimpleDosingInstructions',90,NULL,0,'1 dd 100 mg',NULL,NULL,1514,160240,161553,16,NULL,0,NULL),
(@CURRENT_ORD_ID +1,67,10,0,'org.openmrs.SimpleDosingInstructions',90,NULL,0,'1 dd 10 mg',NULL,NULL,1513,160240,161553,16,NULL,0,NULL);


/* TODO add
Ciclosporine 2 dd 300 mg 
Cotrimoxazol 1 dd 480 mg 
Hypromellose 3 mg/ml oogdruppels 4 dd zn 
Macrogol/zouten sachet 1 dd 1 zn 
Metoclopramide 3 dd 10 mg zn 
Magnesiumgluconaat 2 dd 1 gr 
Omeprazol 1 dd 40 mg 
Valaciclovir 2 dd 500 mg 
*/

/* start visit */
SELECT max(visit_id)+1 INTO @CURRENT_VISIT_ID from visit;
INSERT INTO `visit` (`visit_id`,`patient_id`, `visit_type_id`, `date_started`, `date_stopped`, `indication_concept_id`, `location_id`, `creator`, `date_created`, `changed_by`, `date_changed`, `voided`, `voided_by`, `date_voided`, `void_reason`, `uuid`) VALUES 
(@CURRENT_VISIT_ID, @CURRENT_PATIENT_ID,1,CONCAT(@CLASS_DATE,' 13:12:39'),NULL,NULL,8,1,'2021-03-19 13:12:39',NULL,NULL,0,NULL,NULL,NULL, (select UUID()));

/* add visit diagnosis and note*/
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
(@CURRENT_PATIENT_ID,1284,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE,' 13:27:14'),6,@CURRENT_OBS_ID,NULL,NULL,121629,127494,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'2021-03-19 13:27:14',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_PATIENT_ID,162169,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE,' 13:27:14'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Opnamestatus op dinsdag \nVoorgeschiedenis: \nRefractair Hodgkin lymfoom (HL) wv allogene stamceltransplantatie (nov-2020) 01-04-2019 Prioriteit: Hoog \nIntentietremor zonder sensibiliteits- of motorische uitval DD bijwerking bij ciclosporine (>10%) 15-12-2020 \nstent in RCA 01-01-2017 \ninspanningsgerelateerde astma 01-01-1995 \n\nMedicatie bij opname: \nAmlodipine 1 dd 10 mg \nCarbasalaatcalcium poeder 1 dd 100 mg \nCiclosporine 2 dd 300 mg \nCotrimoxazol 1 dd 480 mg \nHypromellose 3 mg/ml oogdruppels 4 dd zn \nMacrogol/zouten sachet 1 dd 1 zn \nMetoclopramide 3 dd 10 mg zn \nMagnesiumgluconaat 2 dd 1 gr \nOmeprazol 1 dd 40 mg \nValaciclovir 2 dd 500 mg \n\nIntoxicaties: Geen \nAllergieën: Niet voor zover bekend \n\nRvO/ anemie bij status na refractair Hodgkin lymfoom waarvoor allogene stamceltransplantatie (+3 maanden) \n\nAnamnese: \nWas vorige week nog op policontrole geweest, ging toen wel goed. Echter sinds 2 dagen toenemend vermoeid, geen energie meer. Hierop belde zij naar de SEH en is derhalve gekomen. Eetlust is nog matig, maar onveranderd sinds de stamceltransplantatie. Niet misselijk of braken, ook geen diarree. Mictie iets branderig, maar niet hele tijd. Niet ziek geweest, klein hoestje, soms wat kortademig gevoel, wisselend aanwezig. Geen koorts bemerkt. Geen huidafwijkingen gezien. \n\nTractus anamnese: behoudens iets vocht vasthouden in de benen, geen bijzonderheden. \n\nLichamelijk onderzoek: \nT 36.8°C, P 85/min, RR 126/86mmHg, AH 16/min, O2-sat 98% zonder O2-suppletie  \nAlgemene indruk: helder, niet acuut zieke, maar wel zwak ogende patiënte \nH/H: in de mond geen afwijkingen, geen lymfadenopathie \nCor: normale harttonen, geen souffles \nPulm: normaal ademgeruis zonder bijgeluiden \nAbd: normale peristaltiek, wisselende tympanie, soepel, geen drukpijn, geen weerstanden \nExtr: iets pitting oedeem rondom de enkels, goed voelbare pulsaties  \n\nAO/ laag Hb, iets verhoogd CRP\n \nC/ \n1. Symptomatisch anemie  \n2. Ruim 3 maanden na stamceltransplantatie in verband met HL\n\nB/ \nAd 1 \nOpname op acute opname afdeling voor 2 erytrocyten transfusies (bestraald/parvo-B19 veilig) \nVolledig beleid, normaal dieet \nDoor met thuismedicatie \nIn principe morgenochtend naar huis',NULL,NULL,1,'2021-03-19 16:17:49',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL);

/* add vitals */
SELECT max(encounter_id)+1 INTO @CURRENT_ENC_ID from encounter;
INSERT INTO `encounter` (`encounter_id`,`encounter_type`, `patient_id`, `location_id`, `form_id`, `encounter_datetime`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `changed_by`, `date_changed`, `visit_id`, `uuid`) VALUES
(@CURRENT_ENC_ID, 7,@CURRENT_PATIENT_ID,6,1,CONCAT(@CLASS_DATE,' 14:21:31'),1,'2021-03-19 14:21:31',0,NULL,NULL,NULL,NULL,NULL,@CURRENT_VISIT_ID,(select uuid()));
-- uses encounter_id from above
INSERT INTO `encounter_provider` (`encounter_id`, `provider_id`, `encounter_role_id`, `creator`, `date_created`, `changed_by`, `date_changed`, `voided`, `date_voided`, `voided_by`, `void_reason`, `uuid`) VALUES 
(@CURRENT_ENC_ID,1,2,1,'2021-03-19 14:21:31',NULL,NULL,0,NULL,NULL,NULL,(select uuid()));
-- uses encounter_id from above. each vital meas gets an obs entry. Doesn't seem to use obs_group_id 
INSERT INTO `obs` (`person_id`, `concept_id`, `encounter_id`, `order_id`, `obs_datetime`, `location_id`, `obs_group_id`,`accession_number`, `value_group_id`, `value_coded`, `value_coded_name_id`, `value_drug`, `value_datetime`, `value_numeric`, `value_modifier`, `value_text`, `value_complex`, `comments`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `uuid`, `previous_version`, `form_namespace_and_path`, `status`, `interpretation`) VALUES 
(@CURRENT_PATIENT_ID,5088,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE,' 14:21:31'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,36.8,NULL,NULL,NULL,NULL,1,'2021-03-19 14:21:31',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_PATIENT_ID,5087,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE,' 14:21:31'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,85,NULL,NULL,NULL,NULL,1,'2021-03-19 14:21:31',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_PATIENT_ID,5242,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE,' 14:21:31'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16,NULL,NULL,NULL,NULL,1,'2021-03-19 14:21:31',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_PATIENT_ID,5085,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE,' 14:21:31'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,126,NULL,NULL,NULL,NULL,1,'2021-03-19 14:21:31',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_PATIENT_ID,5086,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE,' 14:21:31'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,86,NULL,NULL,NULL,NULL,1,'2021-03-19 14:21:31',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_PATIENT_ID,5092,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE,' 14:21:31'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,98,NULL,NULL,NULL,NULL,1,'2021-03-19 14:21:31',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL);

/* admit patient */
SELECT max(encounter_id)+1 INTO @CURRENT_ENC_ID from encounter;
INSERT INTO `encounter` (`encounter_id`, `encounter_type`, `patient_id`, `location_id`, `form_id`, `encounter_datetime`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `changed_by`, `date_changed`, `visit_id`, `uuid`) VALUES
(@CURRENT_ENC_ID,2,@CURRENT_PATIENT_ID,9,3,CONCAT(@CLASS_DATE,' 14:38:05'),1,'2021-03-19 14:38:05',0,NULL,NULL,NULL,NULL,NULL,@CURRENT_VISIT_ID,(select uuid()));

-- uses encounter_id from above
INSERT INTO `encounter_provider` (`encounter_id`, `provider_id`, `encounter_role_id`, `creator`, `date_created`, `changed_by`, `date_changed`, `voided`, `date_voided`, `voided_by`, `void_reason`, `uuid`) VALUES 
(@CURRENT_ENC_ID,1,1,1,'2021-03-19 14:38:05',NULL,NULL,0,NULL,NULL,NULL,(select uuid()));

/*TODO add 2 erytrocyten transfusies */

/* labs */
INSERT INTO `obs` (`person_id`, `concept_id`, `encounter_id`, `order_id`, `obs_datetime`, `location_id`, `obs_group_id`,`accession_number`, `value_group_id`, `value_coded`, `value_coded_name_id`, `value_drug`, `value_datetime`, `value_numeric`, `value_modifier`, `value_text`, `value_complex`, `comments`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `uuid`, `previous_version`, `form_namespace_and_path`, `status`, `interpretation`) VALUES 
(@CURRENT_PATIENT_ID,169763,NULL,NULL,@CLASS_DATE,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,78,NULL,NULL,NULL,'',1,'2021-04-09 17:35:51',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL), -- Kreatinine	umol/l	65-95		78
(@CURRENT_PATIENT_ID,169764,NULL,NULL,@CLASS_DATE,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,90,NULL,NULL,NULL,'> 90',1,'2021-04-09 17:37:15',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL), -- eGFR (CKD-EPI)	ml/min/1,73m^2		>90
(@CURRENT_PATIENT_ID,169743,NULL,NULL,@CLASS_DATE,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,5.6,NULL,NULL,NULL,'',1,'2021-04-09 17:43:52',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL), -- Glucose	mmol/l	4,1-5,6			5,9
(@CURRENT_PATIENT_ID,169775,NULL,NULL,@CLASS_DATE,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,19,NULL,NULL,NULL,'',1,'2021-04-09 17:44:29',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL), -- Bilirubine (totaal)	umol/l	0-17	19
(@CURRENT_PATIENT_ID,169770,NULL,NULL,@CLASS_DATE,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,16,NULL,NULL,NULL,'',1,'2021-04-09 17:48:02',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL), -- aspartate aminotransferase (AST)	16
(@CURRENT_PATIENT_ID,169769,NULL,NULL,@CLASS_DATE,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,51,NULL,NULL,NULL,'',1,'2021-04-09 17:49:07',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL), -- alanine aminotransferase (ALT)		51
(@CURRENT_PATIENT_ID,169771,NULL,NULL,@CLASS_DATE,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,127,NULL,NULL,NULL,'',1,'2021-04-09 17:50:21',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL), -- Gamma-glutamyl transferase (GGT)	127
(@CURRENT_PATIENT_ID,169768,NULL,NULL,@CLASS_DATE,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,71,NULL,NULL,NULL,'',1,'2021-04-09 17:51:11',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL); -- Alkaline phosphatase (ALKP)		71

/* end copying tuesday / start copy wed */

/* add the note */
SELECT max(encounter_id)+1 INTO @CURRENT_ENC_ID from encounter;
INSERT INTO `encounter` (`encounter_id`,`encounter_type`, `patient_id`, `location_id`, `form_id`, `encounter_datetime`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `changed_by`, `date_changed`, `visit_id`, `uuid`) VALUES
(@CURRENT_ENC_ID,3,@CURRENT_PATIENT_ID,6,2,CONCAT(@CLASS_DATE2,' 07:06:30'),1,'2021-03-19 16:17:21',0,NULL,NULL,NULL,NULL,NULL,@CURRENT_VISIT_ID,(select uuid()));
-- uses encounter_id from the above encounter
INSERT INTO `encounter_provider` (`encounter_id`, `provider_id`, `encounter_role_id`, `creator`, `date_created`, `changed_by`, `date_changed`, `voided`, `date_voided`, `voided_by`, `void_reason`, `uuid`) VALUES 
(@CURRENT_ENC_ID,1,1,1,'2021-03-19 16:17:21',NULL,NULL,0,NULL,NULL,NULL,(select uuid()));
SELECT max(obs_id)+1 INTO @CURRENT_OBS_ID from obs;
INSERT INTO `obs` VALUES
(@CURRENT_OBS_ID,@CURRENT_PATIENT_ID,159947,@CURRENT_ENC_ID,NULL,'2021-03-20 15:20:39',6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'2021-03-20 15:20:39',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_OBS_ID+1,@CURRENT_PATIENT_ID,159946,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE2,' 07:06:30'),6,@CURRENT_OBS_ID,NULL,NULL,159943,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'2021-03-20 15:20:39',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_OBS_ID+2,@CURRENT_PATIENT_ID,159394,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE2,' 07:06:30'),6,@CURRENT_OBS_ID,NULL,NULL,159393,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'2021-03-20 15:20:39',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_OBS_ID+3,@CURRENT_PATIENT_ID,1284,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE,' 07:06:30'),6,@CURRENT_OBS_ID,NULL,NULL,121629,127494,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'2021-03-20 15:20:39',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_OBS_ID+4,@CURRENT_PATIENT_ID,162169,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE2,' 07:06:30'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'RvO: symptomatische anemie \n \nVPK: vannacht transfusies ingelopen zonder problemen, verder rustige nacht, maar in ochtend koorts gemeten \n \nA/ \nZij voelt zich wat beter na de transfusies, wel nog steeds last van dysurie. Heeft ook gevoel van kleine beetjes te plassen. Zij hoest niet echt, geen keelpijn, maar soms iets kortademig gevoel, trekt nu ook weer weg. Niet echt snotterig. Iets licht in het hoofd. Werd vanochtend wel zweterig wakker, voelt zich niet koortsig. Niet misselijk. Ontlasting lijkt vanochtend ook iets dunner. Geen huidafwijkingen.  \n \nLichamelijk onderzoek: \nT 38,6°C, P 110/min, RR 110/70mmHg, AH 14/min, O2-sat 96% zonder O2-suppletie \nAlgemene indruk: helder, niet acuut ziek \nH/H: geen lymfadenopathie, in de mond mogelijk iets roodheid in de keel, overig geen afwijkingen \nCor: normale harttonen, geen souffles \nPulm: vesiculair ademgeruis zonder bijgeluiden \nAbd: normale peristaltiek, wisselende tympanie, soepel, geen druk- of loslaatpijn, geen weerstanden \nExtr: normale pulsaties, geen oedeem  \n \nAO/ geen \n \nConclusie \n    Koorts, tachycardie, dysurie, tevens iets dyspneu DD UWI, toch pneumonie, virale bovenste luchtweginfectie  \n    Ruim 3 maanden na stamceltransplantatie in verband met HL \n \nBeleid \nAd 1 \nBloedkweken afnemen, tevens CRP \nSediment plus urinekweek  \nIndien diarree dan ook feceskweek (SSYC, clostridium en virussen) \nRespiratoir virus pakket, incl COVID \nX-thorax \nStart cefriaxon 1 dd 2000 mg + gentamicine 5 mg/kg \nAdvies minimaal 1,5 liter drinken (indien dat niet lukt infuus starten) \n \nAddendum om 16 uur: \nAO/ CRP verder gestegen, Hb wel mooi gestegen, COVID negatief \nX-thorax: ongewijzigd thoraxbeeld met postradiatieveranderingen rechts apicaal. Geen nieuwe voor pneumonie verdachte verdichtingen.  \nC/ \nKoorts, tachycardie, dysurie en leukocyturie passend bij urineweginfectie \nB/ \nZo door ',NULL,NULL,1,'2021-03-20 15:20:39',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL);

/* add some more vitals */
SELECT max(encounter_id)+1 INTO @CURRENT_ENC_ID from encounter;
INSERT INTO `encounter` (`encounter_id`,`encounter_type`, `patient_id`, `location_id`, `form_id`, `encounter_datetime`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `changed_by`, `date_changed`, `visit_id`, `uuid`) VALUES
(@CURRENT_ENC_ID, 7,@CURRENT_PATIENT_ID,6,1,CONCAT(@CLASS_DATE2,' 07:21:31'),1,'2021-03-19 07:21:31',0,NULL,NULL,NULL,NULL,NULL,@CURRENT_VISIT_ID,(select uuid()));
-- uses encounter_id from above
INSERT INTO `encounter_provider` (`encounter_id`, `provider_id`, `encounter_role_id`, `creator`, `date_created`, `changed_by`, `date_changed`, `voided`, `date_voided`, `voided_by`, `void_reason`, `uuid`) VALUES 
(@CURRENT_ENC_ID,1,2,1,'2021-03-19 07:21:31',NULL,NULL,0,NULL,NULL,NULL,(select uuid()));
-- uses encounter_id from above. each vital meas gets an obs entry. Doesn't seem to use obs_group_id 
INSERT INTO `obs` (`person_id`, `concept_id`, `encounter_id`, `order_id`, `obs_datetime`, `location_id`, `obs_group_id`,`accession_number`, `value_group_id`, `value_coded`, `value_coded_name_id`, `value_drug`, `value_datetime`, `value_numeric`, `value_modifier`, `value_text`, `value_complex`, `comments`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `uuid`, `previous_version`, `form_namespace_and_path`, `status`, `interpretation`) VALUES 
(@CURRENT_PATIENT_ID,5088,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE2,' 07:21:31'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,38.6,NULL,NULL,NULL,NULL,1,'2021-03-19 07:21:31',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_PATIENT_ID,5087,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE2,' 07:21:31'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,110,NULL,NULL,NULL,NULL,1,'2021-03-19 07:21:31',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_PATIENT_ID,5242,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE2,' 07:21:31'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,14,NULL,NULL,NULL,NULL,1,'2021-03-19 07:21:31',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_PATIENT_ID,5085,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE2,' 07:21:31'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,110,NULL,NULL,NULL,NULL,1,'2021-03-19 07:21:31',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_PATIENT_ID,5086,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE2,' 07:21:31'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,70,NULL,NULL,NULL,NULL,1,'2021-03-19 07:21:31',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_PATIENT_ID,5092,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE2,' 07:21:31'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,96,NULL,NULL,NULL,NULL,1,'2021-03-19 07:21:31',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL);

/* TODO probably need to add diagnoses/problem list items:
    Koorts, tachycardie, dysurie, tevens iets dyspneu DD UWI, toch pneumonie, virale bovenste luchtweginfectie  
Also orders: 
Bloedkweken afnemen, tevens CRP 
Sediment plus urinekweek  
Indien diarree dan ook feceskweek (SSYC, clostridium en virussen) 
Respiratoir virus pakket, incl COVID 
X-thorax 
Start cefriaxon 1 dd 2000 mg + gentamicine 5 mg/kg 

At 16:00 adjust diagnoses/problem list:
Koorts, tachycardie, dysurie en leukocyturie passend bij urineweginfectie
*/

/* end copy wed / start copy thurs*/

/* add thursday's note */
SELECT max(encounter_id)+1 INTO @CURRENT_ENC_ID from encounter;
INSERT INTO `encounter` (`encounter_id`,`encounter_type`, `patient_id`, `location_id`, `form_id`, `encounter_datetime`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `changed_by`, `date_changed`, `visit_id`, `uuid`) VALUES
(@CURRENT_ENC_ID,3,@CURRENT_PATIENT_ID,6,2,CONCAT(@CLASS_DATE3,' 06:51:30'),1,'2021-03-19 16:17:21',0,NULL,NULL,NULL,NULL,NULL,@CURRENT_VISIT_ID,(select uuid()));
-- uses encounter_id from the above encounter
INSERT INTO `encounter_provider` (`encounter_id`, `provider_id`, `encounter_role_id`, `creator`, `date_created`, `changed_by`, `date_changed`, `voided`, `date_voided`, `voided_by`, `void_reason`, `uuid`) VALUES 
(@CURRENT_ENC_ID,1,1,1,'2021-03-19 16:17:21',NULL,NULL,0,NULL,NULL,NULL,(select uuid()));
SELECT max(obs_id)+1 INTO @CURRENT_OBS_ID from obs;
INSERT INTO `obs` VALUES
(@CURRENT_OBS_ID,@CURRENT_PATIENT_ID,159947,@CURRENT_ENC_ID,NULL,'2021-03-20 15:20:39',6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'2021-03-20 15:20:39',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_OBS_ID+1,@CURRENT_PATIENT_ID,159946,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE3,' 06:51:30'),6,@CURRENT_OBS_ID,NULL,NULL,159943,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'2021-03-20 15:20:39',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_OBS_ID+2,@CURRENT_PATIENT_ID,159394,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE3,' 06:51:30'),6,@CURRENT_OBS_ID,NULL,NULL,159393,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'2021-03-20 15:20:39',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_OBS_ID+3,@CURRENT_PATIENT_ID,1284,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE,' 06:51:30'),6,@CURRENT_OBS_ID,NULL,NULL,121629,127494,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'2021-03-20 15:20:39',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_OBS_ID+4,@CURRENT_PATIENT_ID,162169,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE3,' 06:51:30'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'RvO/ verdenking urineweginfectie \n \nVPK/ Nog wel zwak, koorts afgezakt, branderig pijn tijdens mictie nog wel aanwezig, heeft sinds vannacht jeuk en roodheid op de benen, ook beetje op de buik.  \n \nA/ Voelt zich nog iets vermoeid, wel nog dysurie, hoesten/kortademigheid niet meer. \n \nLO/ T 37,8°C, P 96/min, RR 137/96mmHg, AH 12/min, O2-sat 98% zonder O2-suppletie  \nMaculopapuleuze afwijkingen op bovenbenen, ook in mindere mate op de onderbenen, aantal vlekken op buik.  \n \nAO/  \nGram- staven uit urinekweek, determinatie volgt, bloedkweek vooralsnog negatief \n \nC/  \n    Urineweginfectie met gram- staven \n    Maculopapuleus exantheem benen/buik tgv allergische reactie op antibiotica DD bij infectie of beginnende graft versus host disease (GvHD) agv 3  \n    Ruim 3 mnd na stamceltransplantatie \n \nB/  \n \nAd 1/2  \n    Roodheid aftekenen \n    Gezien huidreactie dermatoloog in consult vragen, passend bij geneesmiddelallergie of toch beginnende GvHD \n    Determinatie urinekweek afwachten en bloedkweek, switch naar meropenem (gezien mgl kruisreactiviteit met andere antibiotica) \n',NULL,NULL,1,'2021-03-20 15:20:39',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL);

/* add some more vitals */
SELECT max(encounter_id)+1 INTO @CURRENT_ENC_ID from encounter;
INSERT INTO `encounter` (`encounter_id`,`encounter_type`, `patient_id`, `location_id`, `form_id`, `encounter_datetime`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `changed_by`, `date_changed`, `visit_id`, `uuid`) VALUES
(@CURRENT_ENC_ID, 7,@CURRENT_PATIENT_ID,6,1,CONCAT(@CLASS_DATE3,' 06:40:31'),1,'2021-03-19 06:40:31',0,NULL,NULL,NULL,NULL,NULL,@CURRENT_VISIT_ID,(select uuid()));
-- uses encounter_id from above
INSERT INTO `encounter_provider` (`encounter_id`, `provider_id`, `encounter_role_id`, `creator`, `date_created`, `changed_by`, `date_changed`, `voided`, `date_voided`, `voided_by`, `void_reason`, `uuid`) VALUES 
(@CURRENT_ENC_ID,1,2,1,'2021-03-19 06:40:31',NULL,NULL,0,NULL,NULL,NULL,(select uuid()));
-- uses encounter_id from above. each vital meas gets an obs entry. Doesn't seem to use obs_group_id 
INSERT INTO `obs` (`person_id`, `concept_id`, `encounter_id`, `order_id`, `obs_datetime`, `location_id`, `obs_group_id`,`accession_number`, `value_group_id`, `value_coded`, `value_coded_name_id`, `value_drug`, `value_datetime`, `value_numeric`, `value_modifier`, `value_text`, `value_complex`, `comments`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `uuid`, `previous_version`, `form_namespace_and_path`, `status`, `interpretation`) VALUES 
(@CURRENT_PATIENT_ID,5088,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE3,' 06:40:31'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,37.8,NULL,NULL,NULL,NULL,1,'2021-03-19 06:40:31',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_PATIENT_ID,5087,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE3,' 06:40:31'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,96,NULL,NULL,NULL,NULL,1,'2021-03-19 06:40:31',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_PATIENT_ID,5242,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE3,' 06:40:31'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,12,NULL,NULL,NULL,NULL,1,'2021-03-19 06:40:31',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_PATIENT_ID,5085,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE3,' 06:40:31'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,137,NULL,NULL,NULL,NULL,1,'2021-03-19 06:40:31',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_PATIENT_ID,5086,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE3,' 06:40:31'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,96,NULL,NULL,NULL,NULL,1,'2021-03-19 06:40:31',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_PATIENT_ID,5092,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE3,' 06:40:31'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,98,NULL,NULL,NULL,NULL,1,'2021-03-19 06:40:31',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL);

/* TODO
Probably update the problem list?
    Urineweginfectie met gram- staven 
    Maculopapuleus exantheem benen/buik tgv allergische reactie op antibiotica DD bij infectie of beginnende graft versus host disease (GvHD) agv 3  
    Ruim 3 mnd na stamceltransplantatie 
dermatoloog in consult vragen
switch naar meropenem
*/

/* end copy thurs / start copy fri */

/* add friday's note */
SELECT max(encounter_id)+1 INTO @CURRENT_ENC_ID from encounter;
INSERT INTO `encounter` (`encounter_id`,`encounter_type`, `patient_id`, `location_id`, `form_id`, `encounter_datetime`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `changed_by`, `date_changed`, `visit_id`, `uuid`) VALUES
(@CURRENT_ENC_ID,3,@CURRENT_PATIENT_ID,6,2,CONCAT(@CLASS_DATE4,' 07:06:30'),1,'2021-03-19 16:17:21',0,NULL,NULL,NULL,NULL,NULL,@CURRENT_VISIT_ID,(select uuid()));
-- uses encounter_id from the above encounter
INSERT INTO `encounter_provider` (`encounter_id`, `provider_id`, `encounter_role_id`, `creator`, `date_created`, `changed_by`, `date_changed`, `voided`, `date_voided`, `voided_by`, `void_reason`, `uuid`) VALUES 
(@CURRENT_ENC_ID,1,1,1,'2021-03-19 16:17:21',NULL,NULL,0,NULL,NULL,NULL,(select uuid()));
SELECT max(obs_id)+1 INTO @CURRENT_OBS_ID from obs;
INSERT INTO `obs` VALUES
(@CURRENT_OBS_ID,@CURRENT_PATIENT_ID,159947,@CURRENT_ENC_ID,NULL,'2021-03-20 15:20:39',6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'2021-03-20 15:20:39',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_OBS_ID+1,@CURRENT_PATIENT_ID,159946,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE4,' 08:21:30'),6,@CURRENT_OBS_ID,NULL,NULL,159943,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'2021-03-20 15:20:39',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_OBS_ID+2,@CURRENT_PATIENT_ID,159394,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE4,' 08:21:30'),6,@CURRENT_OBS_ID,NULL,NULL,159393,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'2021-03-20 15:20:39',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_OBS_ID+3,@CURRENT_PATIENT_ID,1284,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE,' 08:21:30'),6,@CURRENT_OBS_ID,NULL,NULL,121629,127494,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'2021-03-20 15:20:39',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_OBS_ID+4,@CURRENT_PATIENT_ID,162169,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE4,' 08:21:30'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'RvO/ urineweginfectie  \n \nVPK/ voelt zich beter, minder pijn bij plassen \n \nA/ voelt zich al met al wel wat beter, voelt zich fitter, eetlust komt terug, roodheid minimaal uitgebreid \n \nLO/ T 37,4°C, P 89/min, RR 122/88 mmHg, AH 12/min, O2-sat 96% zonder O2-suppletie  \nMaculopapuleuze afwijkingen op bovenbenen minimaal toegenomen  \n \nAO/  \nHb wat gezakt (wrs door infectie bij “jonge” beenmerg) \nE. coli goed gevoelig, ook orale opties \n \nC/  \n    Urineweginfectie met E. coli (geen ESBL) \n    Maculopapuleus exantheem benen/buik waarschijnlijk ten gevolge van ceftriaxon CAVE beginnende GvHD \n    Ruim 3 mnd na stamceltransplantatie \n \nB/  \nAd 1  \nOver naar ciprofloxacine 2 dd 500 mg \n \nAd 2 \nTerugkoppeling van dermatoloog: beeld passend bij geneesmiddelallergie, beginnende GvHD niet uit te sluiten \nWait and see, bij evidente toename dan huidbiopt afnemen \n \nAd 3 \nNog 1x erytrocyten transfusie ',NULL,NULL,1,'2021-03-20 15:20:39',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL);

/* add some more vitals */
SELECT max(encounter_id)+1 INTO @CURRENT_ENC_ID from encounter;
INSERT INTO `encounter` (`encounter_id`,`encounter_type`, `patient_id`, `location_id`, `form_id`, `encounter_datetime`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `changed_by`, `date_changed`, `visit_id`, `uuid`) VALUES
(@CURRENT_ENC_ID, 7,@CURRENT_PATIENT_ID,6,1,CONCAT(@CLASS_DATE4,' 06:59:31'),1,'2021-03-19 06:59:31',0,NULL,NULL,NULL,NULL,NULL,@CURRENT_VISIT_ID,(select uuid()));
-- uses encounter_id from above
INSERT INTO `encounter_provider` (`encounter_id`, `provider_id`, `encounter_role_id`, `creator`, `date_created`, `changed_by`, `date_changed`, `voided`, `date_voided`, `voided_by`, `void_reason`, `uuid`) VALUES 
(@CURRENT_ENC_ID,1,2,1,'2021-03-19 06:59:31',NULL,NULL,0,NULL,NULL,NULL,(select uuid()));
-- uses encounter_id from above. each vital meas gets an obs entry. Doesn't seem to use obs_group_id 
INSERT INTO `obs` (`person_id`, `concept_id`, `encounter_id`, `order_id`, `obs_datetime`, `location_id`, `obs_group_id`,`accession_number`, `value_group_id`, `value_coded`, `value_coded_name_id`, `value_drug`, `value_datetime`, `value_numeric`, `value_modifier`, `value_text`, `value_complex`, `comments`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `uuid`, `previous_version`, `form_namespace_and_path`, `status`, `interpretation`) VALUES 
(@CURRENT_PATIENT_ID,5088,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE4,' 06:59:31'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,37.4,NULL,NULL,NULL,NULL,1,'2021-03-19 06:59:31',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_PATIENT_ID,5087,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE4,' 06:59:31'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,89,NULL,NULL,NULL,NULL,1,'2021-03-19 06:59:31',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_PATIENT_ID,5242,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE4,' 06:59:31'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,12,NULL,NULL,NULL,NULL,1,'2021-03-19 06:59:31',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_PATIENT_ID,5085,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE4,' 06:59:31'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,128,NULL,NULL,NULL,NULL,1,'2021-03-19 06:59:31',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_PATIENT_ID,5086,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE4,' 06:59:31'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,88,NULL,NULL,NULL,NULL,1,'2021-03-19 06:59:31',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_PATIENT_ID,5092,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE4,' 06:59:31'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,96,NULL,NULL,NULL,NULL,1,'2021-03-19 06:59:31',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL);

/* TODO probably add
diagnoses
    Urineweginfectie met E. coli (geen ESBL) 
    Maculopapuleus exantheem benen/buik waarschijnlijk ten gevolge van ceftriaxon CAVE beginnende GvHD 
    Ruim 3 mnd na stamceltransplantatie 
Meds: 
	Over naar ciprofloxacine 2 dd 500 mg 
	Nog 1x erytrocyten transfusie 
Terugkoppeling van dermatoloog: beeld passend bij geneesmiddelallergie, beginnende GvHD niet uit te sluiten 
*/ 

/* end copy fri */

/* add saturday's note */
SELECT max(encounter_id)+1 INTO @CURRENT_ENC_ID from encounter;
INSERT INTO `encounter` (`encounter_id`,`encounter_type`, `patient_id`, `location_id`, `form_id`, `encounter_datetime`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `changed_by`, `date_changed`, `visit_id`, `uuid`) VALUES
(@CURRENT_ENC_ID,3,@CURRENT_PATIENT_ID,6,2,CONCAT(@CLASS_DATE5,' 07:06:30'),1,'2021-03-19 16:17:21',0,NULL,NULL,NULL,NULL,NULL,@CURRENT_VISIT_ID,(select uuid()));
-- uses encounter_id from the above encounter
INSERT INTO `encounter_provider` (`encounter_id`, `provider_id`, `encounter_role_id`, `creator`, `date_created`, `changed_by`, `date_changed`, `voided`, `date_voided`, `voided_by`, `void_reason`, `uuid`) VALUES 
(@CURRENT_ENC_ID,1,1,1,'2021-03-19 16:17:21',NULL,NULL,0,NULL,NULL,NULL,(select uuid()));
SELECT max(obs_id)+1 INTO @CURRENT_OBS_ID from obs;
INSERT INTO `obs` VALUES
(@CURRENT_OBS_ID,@CURRENT_PATIENT_ID,159947,@CURRENT_ENC_ID,NULL,'2021-03-20 15:20:39',6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'2021-03-20 15:20:39',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_OBS_ID+1,@CURRENT_PATIENT_ID,159946,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE5,' 08:21:30'),6,@CURRENT_OBS_ID,NULL,NULL,159943,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'2021-03-20 15:20:39',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_OBS_ID+2,@CURRENT_PATIENT_ID,159394,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE5,' 08:21:30'),6,@CURRENT_OBS_ID,NULL,NULL,159393,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'2021-03-20 15:20:39',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_OBS_ID+3,@CURRENT_PATIENT_ID,1284,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE,' 08:21:30'),6,@CURRENT_OBS_ID,NULL,NULL,121629,127494,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'2021-03-20 15:20:39',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_OBS_ID+4,@CURRENT_PATIENT_ID,162169,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE5,' 08:21:30'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'RvO/ urineweginfectie  \n \nVPK/ gaat goed \n \nA/ duidelijk opgeknapt, loopt rond \n \nLO/ T 37,0°C, P 80/min, RR 119/78 mmHg, AH 12/min, O2-sat 99% zonder O2-suppletie  \nErythemateuze afwijkingen op bovenbenen afgenomen  \n \nAO/  \nBloedbeeld fraai herstellende \n \nC/  \n    Urineweginfectie met E. coli \n    Jeuk en roodheid benen/buik ten gevolge van ceftriaxon, minder passend bij GvHD \n    Ruim 3 mnd na stamceltransplantatie \n \nB/  \nAd 1  \nDoor met ciprofloxacine 2 dd 500 mg (totaal 14 dagen) \nVandaag naar huis \n \nAd 2 \nExpectatief, bij toename huidafwijkingen moet zij bellen \n \nAd 3 \nExpectatief ',NULL,NULL,1,'2021-03-20 15:20:39',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL);

/* add some more vitals */
SELECT max(encounter_id)+1 INTO @CURRENT_ENC_ID from encounter;
INSERT INTO `encounter` (`encounter_id`,`encounter_type`, `patient_id`, `location_id`, `form_id`, `encounter_datetime`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `changed_by`, `date_changed`, `visit_id`, `uuid`) VALUES
(@CURRENT_ENC_ID, 7,@CURRENT_PATIENT_ID,6,1,CONCAT(@CLASS_DATE5,' 06:59:31'),1,'2021-03-19 06:59:31',0,NULL,NULL,NULL,NULL,NULL,@CURRENT_VISIT_ID,(select uuid()));
-- uses encounter_id from above
INSERT INTO `encounter_provider` (`encounter_id`, `provider_id`, `encounter_role_id`, `creator`, `date_created`, `changed_by`, `date_changed`, `voided`, `date_voided`, `voided_by`, `void_reason`, `uuid`) VALUES 
(@CURRENT_ENC_ID,1,2,1,'2021-03-19 06:59:31',NULL,NULL,0,NULL,NULL,NULL,(select uuid()));
-- uses encounter_id from above. each vital meas gets an obs entry. Doesn't seem to use obs_group_id 
INSERT INTO `obs` (`person_id`, `concept_id`, `encounter_id`, `order_id`, `obs_datetime`, `location_id`, `obs_group_id`,`accession_number`, `value_group_id`, `value_coded`, `value_coded_name_id`, `value_drug`, `value_datetime`, `value_numeric`, `value_modifier`, `value_text`, `value_complex`, `comments`, `creator`, `date_created`, `voided`, `voided_by`, `date_voided`, `void_reason`, `uuid`, `previous_version`, `form_namespace_and_path`, `status`, `interpretation`) VALUES 
(@CURRENT_PATIENT_ID,5088,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE5,' 06:59:31'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,37.0,NULL,NULL,NULL,NULL,1,'2021-03-19 06:59:31',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_PATIENT_ID,5087,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE5,' 06:59:31'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,80,NULL,NULL,NULL,NULL,1,'2021-03-19 06:59:31',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_PATIENT_ID,5242,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE5,' 06:59:31'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,12,NULL,NULL,NULL,NULL,1,'2021-03-19 06:59:31',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_PATIENT_ID,5085,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE5,' 06:59:31'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,119,NULL,NULL,NULL,NULL,1,'2021-03-19 06:59:31',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_PATIENT_ID,5086,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE5,' 06:59:31'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,78,NULL,NULL,NULL,NULL,1,'2021-03-19 06:59:31',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL),
(@CURRENT_PATIENT_ID,5092,@CURRENT_ENC_ID,NULL,CONCAT(@CLASS_DATE5,' 06:59:31'),6,NULL,NULL,NULL,NULL,NULL,NULL,NULL,99,NULL,NULL,NULL,NULL,1,'2021-03-19 06:59:31',0,NULL,NULL,NULL,(select uuid()),NULL,NULL,'FINAL',NULL);

/* TODO probably update problem list:
    Urineweginfectie met E. coli 
    Jeuk en roodheid benen/buik ten gevolge van ceftriaxon, minder passend bij GvHD 
    Ruim 3 mnd na stamceltransplantatie 
make sure rx reflects new duration: Door met ciprofloxacine 2 dd 500 mg (totaal 14 dagen) 
*/


/* cleaning up tests:
UPDATE person_name SET family_name = 'de Vries', given_name = CONCAT('A.', person_id -191) WHERE family_name = 'de Vries1';
UPDATE patient_identifier SET identifier = CONCAT('10000',patient_id) WHERE identifier = '77777700006'; 
*/