-- Restaurant reservation schema and sample data.
DROP TABLE IF EXISTS reservations;
DROP TABLE IF EXISTS dining_tables;
DROP TABLE IF EXISTS guests;

CREATE TABLE guests (
    guest_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    full_name TEXT NOT NULL,
    phone TEXT NOT NULL UNIQUE
);
CREATE TABLE dining_tables (
    table_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    table_label TEXT NOT NULL UNIQUE,
    seats INTEGER NOT NULL CHECK (seats > 0)
);
CREATE TABLE reservations (
    reservation_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    guest_id INTEGER NOT NULL REFERENCES guests(guest_id),
    table_id INTEGER NOT NULL REFERENCES dining_tables(table_id),
    reserved_for TIMESTAMP NOT NULL,
    party_size INTEGER NOT NULL CHECK (party_size > 0),
    status TEXT NOT NULL CHECK (status IN ('booked', 'seated', 'completed', 'cancelled')),
    CHECK (party_size <= 20)
);

INSERT INTO guests (full_name, phone) VALUES ('Aisha Khan', '+91-900000001'), ('Marco Silva', '+91-900000002'), ('Nora Chen', '+91-900000003');
INSERT INTO dining_tables (table_label, seats) VALUES ('T1', 2), ('T2', 4), ('T3', 6);
INSERT INTO reservations (guest_id, table_id, reserved_for, party_size, status) VALUES
    (1, 2, TIMESTAMP '2026-09-15 19:00', 4, 'booked'),
    (2, 3, TIMESTAMP '2026-09-15 19:30', 5, 'booked'),
    (3, 1, TIMESTAMP '2026-09-16 18:00', 2, 'booked');
