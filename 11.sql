1)

CREATE TABLE Cars (
    car_model VARCHAR(100) PRIMARY KEY,
    car_manufacturer VARCHAR(100)
);

CREATE TABLE RaceResults (
    race_id INT,
    driver_id INT,
    car_model VARCHAR(100),
    finish_time TIME,
    PRIMARY KEY (race_id, driver_id),
    FOREIGN KEY (car_model) REFERENCES Cars(car_model)
);

2)

CREATE TABLE EventTypes (
    event_type VARCHAR(50) PRIMARY KEY,
    room_name VARCHAR(100)
);

CREATE TABLE Events (
    event_name VARCHAR(255) PRIMARY KEY,
    event_type VARCHAR(50),
    FOREIGN KEY (event_type) REFERENCES EventTypes(event_type)
);

CREATE TABLE RoomBookings (
    booking_time DATETIME,
    room_name VARCHAR(100),
    event_name VARCHAR(255),
    PRIMARY KEY (booking_time, room_name),
    FOREIGN KEY (event_name) REFERENCES Events(event_name),
    FOREIGN KEY (room_name) REFERENCES EventTypes(room_name)  -- Опционально, для целостности
);

3)

CREATE TABLE IF NOT EXISTS EventsName (
event_name VARCHAR(100) PRIMARY KEY
);

CREATE TABLE IF NOT EXISTS Events (
event_type VARCHAR(50),
event_name VARCHAR(100),
room_name VARCHAR(100),
FOREIGN KEY (event_name) REFERENCES EventsName(event_name),
PRIMARY KEY (event_type, room_name)
);

CREATE TABLE IF NOT EXISTS RoomBookings (
booking_time TIMESTAMP,
room_name VARCHAR(100),
event_name VARCHAR(255),
event_type VARCHAR(50),
FOREIGN KEY (event_type, room_name) REFERENCES Events(event_type, room_name),
FOREIGN KEY (event_name) REFERENCES EventsName(event_name),
PRIMARY KEY (booking_time, room_name)
);
