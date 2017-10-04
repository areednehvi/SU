-- Query for payment history, Please optimize this query Join only those tables that we need to show the data that we have in online version of Payment history tab.
SELECT
	`sp`.*,
	`u`.`full_name` AS `student_name`,
	`f`.`id` AS `fees_id`,
	`sf`.`student_id`,
	`sf`.`grade_fees_id`,
	`sf`.`concession_amount`,
	`rvsfl`.`route_vehicle_stop_id`, 
	DATE_FORMAT(`sf`.`apply_from`,'%b %Y') AS `month`,
	`sf`.`apply_from`,
	`sf`.`apply_to`,
	`f`.`amount` AS `fee_amount`,
	`f`.`fee_category_id`,
	`fc`.`name` AS `category_name`
FROM
	`student_payments` AS `sp`
LEFT JOIN `student_fees` AS `sf` ON `sf`.`id` = `sp`.`student_fees_id`
LEFT JOIN `students` AS `s` ON `s`.`id` = `sf`.`student_id`
LEFT JOIN `users` AS `u` ON `u`.`id` = `s`.`user_id`
LEFT JOIN `grade_fees` AS `gf` ON `gf`.`id` = `sf`.`grade_fees_id`
LEFT JOIN `route_vehicle_stops_fee_logs` AS `rvsfl` ON `rvsfl`.`id` = `sf`.`route_vehicle_stops_fee_log_id`
LEFT JOIN `route_vehicle_stops` AS `rvs` ON `rvs`.`id` = `rvsfl`.`route_vehicle_stop_id`
LEFT JOIN `fees` AS `f` ON `f`.`id` = `gf`.`fees_id` OR `f`.`id` = `rvsfl`.`fees_id`
LEFT JOIN `fee_categories` AS `fc` ON `fc`.`id` = `f`.`fee_category_id`;

-- Query for Fee Due, optimize this too.
SELECT 
	`sf`.`id`,
	`s`.`school_id`,
	`uaf`.`file_id` AS `file_id`,
	`sgsl`.`session_id`,
	IFNULL(`f`.`id`,0) AS `fees_id`,
	`s`.`id` AS `student_id`,
	`sf`.`grade_fees_id`,
	`f`.`last_day`,
	`f`.`amount`,	
	`rvsfl`.`route_vehicle_stop_id`,
	`sf`.`apply_from`,
	`sf`.`apply_to`,
	`sf`.`concession_amount`,
	ROUND(100/`f`.`amount`*`sf`.`concession_amount`,2) AS `concession_percentage`,
	`sf`.`fine`,
	`sgsl`.`grade_id`,
	`sgsl`.`section_id`,
	`sgsl`.`registration_id`,
	`u`.`full_name`,
	`u`.`first_name`,
	`u`.`middle_name`,
	`u`.`last_name`,
    `u`.`address_line_one`,
    CONCAT(`p`.`f_first_name`, ' ', `p`.`f_middle_name`, ' ', `p`.`f_last_name`) AS `parentage`,
    `p`.`f_mobile`,
	`sgsl`.`roll_number`,
	`g`.`name` AS `grade_name`,
	`g`.`order`,
	`fc`.`id` AS `fee_category_id`,
	`fc`.`name` AS `category_name`,
	`f`.`amount`+IFNULL(`sf`.`fine`, 0)-IFNULL(`sf`.`concession_amount`, 0) -IFNULL(`sp`.`amount`, 0)+IFNULL(`sp`.`fine`, 0) AS `student_balance`
FROM 
	`students` AS `s`
LEFT JOIN `users` AS `u` ON `u`.`id` = `s`.`user_id`
LEFT JOIN `parents` AS `p` ON `p`.`id` = `s`.`parent_id`
LEFT JOIN `student_fees` AS `sf` ON `s`.`id` = `sf`.`student_id`
LEFT JOIN `grade_fees` AS `gf` ON `gf`.`id` = `sf`.`grade_fees_id`
LEFT JOIN `route_vehicle_stops_fee_logs` AS `rvsfl` ON `rvsfl`.`id` = `sf`.`route_vehicle_stops_fee_log_id`
LEFT JOIN `fees` AS `f` ON `f`.`id` = `gf`.`fees_id` OR `f`.`id` = `rvsfl`.`fees_id`
LEFT JOIN `fee_categories` AS `fc` ON `fc`.`id` = `f`.`fee_category_id`
LEFT JOIN `student_grade_session_log` AS `sgsl` ON `s`.`id` = `sgsl`.`student_id`
LEFT JOIN `grades` AS `g` ON `sgsl`.`grade_id` = `g`.`id`
LEFT JOIN `user_avatar_files` `uaf` ON `uaf`.`id` = `u`.`user_avatar_file_id`
LEFT JOIN `student_payments` AS `sp` ON `sf`.`id` = `sp`.`student_fees_id`;