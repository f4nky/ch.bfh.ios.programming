DELETE FROM api_attendance;
DELETE FROM api_event;
DELETE FROM api_member;
DELETE FROM api_eventtype;
DELETE FROM api_membertype;
DELETE FROM api_period;

INSERT INTO api_period (id, name) VALUES
	(1, 'Saison 16/17');

INSERT INTO api_membertype (id, name) VALUES
	(1, 'TrainerIn'),
	(2, 'SpielerIn');

INSERT INTO api_eventtype (id, name) VALUES
	(1, 'Training'),
	(2, 'Match'),
	(3, 'Turnier');

INSERT INTO api_member (id, first_name, last_name, birth_date, member_type_id) VALUES
	(1, 'Michael', 'Fankhauser', '1985-11-04', 1),
	(2, 'Stefan', 'Oppliger', '1992-03-06', 1),
	(3, 'Jane', 'Doe', '2002-09-01', 2),
	(4, 'Alice', 'Scott', '2001-12-12', 2);

INSERT INTO api_event (id, date, period_id, event_type_id) VALUES
	(1, '2016-04-25', 1, 1),
	(2, '2016-04-29', 1, 1),
	(3, '2016-05-02', 1, 1),
	(4, '2016-05-09', 1, 1),
	(5, '2016-05-13', 1, 1);
