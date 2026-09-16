DROP TABLE IF EXISTS payments;
DROP TABLE IF EXISTS bookings;
DROP TABLE IF EXISTS rooms;
DROP TABLE IF EXISTS guests;

CREATE TABLE guests (
    guest_id SERIAL PRIMARY KEY,
    full_name TEXT NOT NULL,
    email TEXT NOT NULL UNIQUE
);

CREATE TABLE rooms (
    room_id SERIAL PRIMARY KEY,
    room_number TEXT NOT NULL UNIQUE,
    room_type TEXT NOT NULL CHECK (room_type IN ('single', 'double', 'suite')),
    nightly_rate NUMERIC(10, 2) NOT NULL CHECK (nightly_rate > 0)
);

CREATE TABLE bookings (
    booking_id SERIAL PRIMARY KEY,
    guest_id INTEGER NOT NULL REFERENCES guests(guest_id),
    room_id INTEGER NOT NULL REFERENCES rooms(room_id),
    check_in DATE NOT NULL,
    check_out DATE NOT NULL,
    status TEXT NOT NULL CHECK (status IN ('reserved', 'checked_in', 'checked_out', 'cancelled')),
    CHECK (check_out > check_in)
);

CREATE TABLE payments (
    payment_id SERIAL PRIMARY KEY,
    booking_id INTEGER NOT NULL REFERENCES bookings(booking_id),
    amount NUMERIC(10, 2) NOT NULL CHECK (amount > 0),
    paid_on DATE NOT NULL DEFAULT CURRENT_DATE
);

INSERT INTO guests (full_name, email) VALUES
    ('Liam Chen', 'liam@example.test'),
    ('Emma Wilson', 'emma@example.test');

INSERT INTO rooms (room_number, room_type, nightly_rate) VALUES
    ('101', 'single', 85.00), ('202', 'double', 125.00), ('501', 'suite', 240.00);

INSERT INTO bookings (guest_id, room_id, check_in, check_out, status) VALUES
    (1, 1, '2026-10-05', '2026-10-08', 'reserved'),
    (2, 2, '2026-10-06', '2026-10-10', 'reserved');

INSERT INTO payments (booking_id, amount, paid_on) VALUES (1, 255.00), (2, 250.00);
