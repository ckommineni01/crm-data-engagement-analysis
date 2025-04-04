CREATE TABLE channels (
    channel_id SERIAL PRIMARY KEY,
    channel_name VARCHAR(50) NOT NULL
);
INSERT INTO channels (channel_name) 
VALUES 
('Email'),
('SMS'),
('WhatsApp');


CREATE TABLE segments (
    segment_id SERIAL PRIMARY KEY,
    segment_name VARCHAR(50) NOT NULL UNIQUE
);
INSERT INTO segments (segment_name) 
VALUES 
('open rate'),
('click rates'),
('conversion rates'),
('un-subscribe rate'),
('inbox placement');


CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    user_name VARCHAR(50) NOT NULL,
    user_number VARCHAR(50) NOT NULL,
    user_email VARCHAR(50) NOT NULL,
    segment_id INT, 
    channel_id INT,
    FOREIGN KEY (segment_id) REFERENCES segments(segment_id),
    FOREIGN KEY (channel_id) REFERENCES channels(channel_id)
);


DO $$ 
DECLARE
  first_names TEXT[] := ARRAY[
    'Alice', 'Bob', 'Charlie', 'Diana', 'Eve', 'Frank', 'Grace', 'Harry', 'Ivy', 'Jack', 
    'Laura', 'Mason', 'Nina', 'Oliver', 'Penny', 'Quincy', 'Rachel', 'Sam', 'Tina', 
    'Ursula', 'Victor', 'Wendy', 'Xander', 'Yara', 'Zane', 'Anna', 'Ben', 'Clara', 
    'David', 'Emily', 'Finn', 'Gina', 'Hank', 'Isla', 'James', 'Kara', 'Leo', 'Maya', 
    'Nathan', 'Olivia', 'Peter', 'Quinn', 'Rachel', 'Steve', 'Tara', 'Ulysses', 'Vera', 
    'Walter', 'Xander', 'Yvonne', 'Zoe', 'Abigail', 'Brandon', 'Catherine', 'Derek', 
    'Felix', 'Georgia', 'Henry', 'Ivy', 'Jack', 'Kenny', 'Lily', 'Megan'
  ];
  
  last_names TEXT[] := ARRAY[
    'Johnson', 'Smith', 'Brown', 'Green', 'White', 'Black', 'Blue', 'Yellow', 'Red', 'Purple', 
    'Pink', 'Gray', 'Orange', 'Gold', 'Silver', 'Bronze', 'Emerald', 'Ruby', 'Diamond', 
    'Sapphire', 'Amethyst', 'Jade', 'Pearl', 'Opal', 'Cooper', 'Wilson', 'Harris', 'Lee', 
    'Clark', 'Taylor', 'Thomas', 'Lewis', 'Walker', 'King', 'Scott', 'Turner', 'Allen', 
    'Adams', 'Hill', 'Knight', 'Carter', 'Mitchell', 'Rose', 'Peterson', 'Hughes', 
    'Spencer', 'Bryant', 'Wood', 'Franklin', 'Griffin', 'Stevens', 'Harrison', 'Lawson'
  ];
BEGIN
  FOR i IN 1..500 LOOP
    INSERT INTO users (user_name, user_number, user_email, segment_id, channel_id) 
    VALUES (
      first_names[(i % array_length(first_names, 1)) + 1] || ' ' || last_names[(i % array_length(last_names, 1)) + 1],  
      '555-' || LPAD((FLOOR(RANDOM() * 9000) + 1000)::TEXT, 4, '0'),  
      LOWER(REPLACE(first_names[(i % array_length(first_names, 1)) + 1], ' ', '.')) || '.' || LOWER(REPLACE(last_names[(i % array_length(last_names, 1)) + 1], ' ', '.')) || i || '@example.com',  
      (i % 5) + 1,  
      (i % 3) + 1  
    );
  END LOOP;
END $$;



SELECT * FROM channels;
SELECT * FROM segments;
SELECT * FROM users;