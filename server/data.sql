DELETE FROM api_attendance;
DELETE FROM api_event;
DELETE FROM api_member;
DELETE FROM api_eventtype;
DELETE FROM api_membertype;
DELETE FROM api_period;

INSERT INTO api_period (id, name) VALUES
	(1, 'Saison 16/17');

INSERT INTO api_membertype (id, name) VALUES
	(1, 'Trainer/in'),
	(2, 'Spieler/in');

INSERT INTO api_eventtype (id, name, abbr) VALUES
	(1, 'Training', 'Tr'),
	(2, 'Match', 'Ma'),
	(3, 'Turnier', 'Tu');

INSERT INTO api_member (id, first_name, last_name, birth_date, member_type_id) VALUES
	(1, 'John', 'Doe', '1985-11-04', 1),
	(2, 'Max', 'Mustermann', '1992-03-06', 1),
	(3, 'Jane', 'Doe', '2002-09-01', 2),
	(4, 'Alice', 'Scott', '2001-12-12', 2);

INSERT INTO api_event (id, date, period_id, event_type_id) VALUES
	(1, '2016-06-20', 1, 1),
	(2, '2016-06-24', 1, 1),
	(3, '2016-06-27', 1, 1);

INSERT INTO api_attendance (id, event_id, member_id, status) VALUES
	(1, 1, 1, null),
	(2, 1, 2, null),
	(3, 1, 3, null),
	(4, 1, 4, null),

	(5, 2, 1, null),
	(6, 2, 2, null),
	(7, 2, 3, null),
	(8, 2, 4, null),

	(9, 3, 1, null),
	(10, 3, 2, null),
	(11, 3, 3, null),
	(12, 3, 4, null);
