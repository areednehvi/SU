-- Procedure to get pending balances of a student.
-- To get Student pending balances we need to pass studentId and getPending = 1 all other parems can be null.

DROP PROCEDURE IF EXISTS getStudentBalances;
DELIMITER $$
CREATE PROCEDURE getStudentBalances(studentId TEXT, studentFeeIds TEXT, receptNo TEXT, getPending INT, applyFrom TEXT, applyTo TEXT, feesCategorieIds TEXT)
BEGIN
	SELECT 
		`sf`.`id`,
		`sf`.`apply_from`,
		`f`.`last_day`,
		`f`.`fine_per_day`,
		`fc`.`name` AS `fees_category`,
		`sf`.`student_id`,
		`f`.`id` AS `fees_id`,
		`f`.`amount` AS `fee_amount`,
		`sp`.`payment_mode`,
		`sp`.`payment_date`,
		`sp`.`recept_no`,
		`sp`.`comment`,
		`sp`.`amount` AS `payment_amount`,
		`sp`.`fine` AS `payment_fine`,
		`sf`.`fine`,
		`sf`.`concession_amount`,
		IFNULL(`sf`.`concession_amount`,0) AS `concession_amount`,
		IFNULL(`f`.`amount`,0)-IFNULL(SUM(`sp`.`amount`),0) AS `amount_to_pay`,
		IFNULL(`sf`.`fine`,0) AS `fine_to_pay`,
		SUM(`sp`.`amount`) AS `paid_amount`,
		IFNULL(`sp`.`fine`,0) AS `fine_paid`,
		(IFNULL(`f`.`amount`,0)+IFNULL(`sf`.`fine`,0))-(IFNULL(SUM(`sp`.`amount`),0)+IFNULL(SUM(`sp`.`fine`),0))-IFNULL(`sf`.`concession_amount`,0) AS `balance_amount`,
		IF(DATE_FORMAT(`sf`.`apply_from`,'%b %Y')<>DATE_FORMAT(`sf`.`apply_to`,'%b %Y'), CONCAT(DATE_FORMAT(`sf`.`apply_from`,'%b %Y'), ' To ' , DATE_FORMAT(`sf`.`apply_to`,'%b %Y')), DATE_FORMAT(`sf`.`apply_from`,'%b %Y')) AS `period`
	FROM 
		`student_fees` AS `sf`
	LEFT JOIN `grade_fees` AS `gf` ON `gf`.`id` = `sf`.`grade_fees_id`
	LEFT JOIN `route_vehicle_stops_fee_logs` AS `rvsfl` ON `rvsfl`.`id` = `sf`.`route_vehicle_stops_fee_log_id`
	LEFT JOIN `fees` AS `f` ON `f`.`id` = `gf`.`fees_id` OR `f`.`id` = `rvsfl`.`fees_id`
	LEFT JOIN `student_payments` AS `sp` ON `sf`.`id` = `sp`.`student_fees_id`
	LEFT JOIN `fee_categories` AS `fc` ON `fc`.`id` = `f`.`fee_category_id`
	WHERE
		IF(studentId, FIND_IN_SET(`sf`.`student_id`, studentId),1 )
	AND
		IF(receptNo IS NOT NULL, `sp`.`recept_no` = receptNo, 1)
	AND
		IF(studentFeeIds, FIND_IN_SET(`sf`.`id`, studentFeeIds), 1)
	AND
		IF(feesCategorieIds, FIND_IN_SET(`fc`.`id`, feesCategorieIds), 1)
	AND
		IF(applyFrom AND applyTo, (`sf`.`apply_from` BETWEEN applyFrom AND applyTo),1)
	GROUP BY 
		`sf`.`id`
	HAVING
		IF(getPending, (IFNULL(`f`.`amount`,0)+IFNULL(`sf`.`fine`,0)-IFNULL(`sf`.`concession_amount`,0))-(IFNULL(SUM(`sp`.`amount`),1)+IFNULL(SUM(`sp`.`fine`),0)), 1)
	ORDER BY 
		`fc`.`order` ASC, 
		`sf`.`apply_from` ASC;
END;
$$
DELIMITER ;

-- View for listing allocated fees.

DROP view if exists `Student_Fee_Allocation`;
CREATE 
VIEW `Student_Fee_Allocation` AS
SELECT 
	`s`.`id`,
	`s`.`school_id`,
	`s`.`registration_id`,
	`sgsl`.`sgsl_status` AS `status`,
	`uaf`.`file_id` AS `file_id`,
	`sgsl`.`session_id`,
	IFNULL(`f`.`id`,0) AS `fees_id`,
	`sf`.`grade_fees_id`,
	`sf`.`apply_from`,
	`sf`.`apply_to`,
	`sf`.`concession_amount`,
	`sf`.`fine`,
	`sgsl`.`grade_id`,
	`sgsl`.`section_id`,
	`u`.`full_name`,
	`sgsl`.`roll_number`,
	`g`.`name` AS `grade_name`,
	`sc`.`name` AS `section_name`,
	`g`.`order`,
	CONCAT(`g`.`name`, ' - ', `sc`.`name`) AS `grade_section`,
	COUNT(`sf`.`id`) AS `allocated_fee_cource_count`,
	CONCAT('<abbr title="Fathers Name">F:</abbr> ',`p`.`f_first_name`, ' ', `p`.`f_middle_name`, ' ', `p`.`f_last_name`,'<br> <abbr title="Mothers Name">M:</abbr> ',`p`.`m_first_name`, ' ', `p`.`m_middle_name`, ' ', `p`.`m_last_name`) AS `parentage`
FROM 
	`students` AS `s`
LEFT JOIN `users` AS `u` ON `u`.`id` = `s`.`user_id`
LEFT JOIN `student_fees` AS `sf` ON `s`.`id` = `sf`.`student_id`
LEFT JOIN `grade_fees` AS `gf` ON `gf`.`id` = `sf`.`grade_fees_id`
LEFT JOIN `fees` AS `f` ON `f`.`id` = `gf`.`fees_id`
LEFT JOIN `student_grade_session_log` AS `sgsl` ON `s`.`id` = `sgsl`.`student_id`
LEFT JOIN `grades` AS `g` ON `sgsl`.`grade_id` = `g`.`id`
LEFT JOIN `sections` AS `sc` ON `sc`.`id` = `sgsl`.`section_id`
LEFT JOIN `user_avatar_files` `uaf` ON `uaf`.`id` = `u`.`user_avatar_file_id`
LEFT JOIN `parents` AS `p` ON `p`.`id` = `s`.`parent_id`
GROUP BY
	`s`.`id`,`sgsl`.`session_id`;