-- Reservation query exercises. Run after 01_schema.sql.
-- 1. Show upcoming bookings with table capacity.
SELECT r.reserved_for, g.full_name, r.party_size, t.table_label, t.seats
FROM reservations r
JOIN guests g ON g.guest_id = r.guest_id
JOIN dining_tables t ON t.table_id = r.table_id
WHERE r.status = 'booked' AND r.reserved_for >= CURRENT_TIMESTAMP
ORDER BY r.reserved_for;

-- 2. Find tables that can accommodate a party of five.
SELECT table_label, seats
FROM dining_tables
WHERE seats >= 5
ORDER BY seats;

-- 3. Daily reservation load.
SELECT reserved_for::DATE AS service_date,
       COUNT(*) FILTER (WHERE status <> 'cancelled') AS active_reservations,
       SUM(party_size) FILTER (WHERE status <> 'cancelled') AS expected_guests
FROM reservations
GROUP BY reserved_for::DATE
ORDER BY service_date;

-- Discussion: how would you enforce no overlapping bookings for one table?
