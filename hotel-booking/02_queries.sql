-- Upcoming bookings with guest and room details.
SELECT b.booking_id, g.full_name, r.room_number, r.room_type,
       b.check_in, b.check_out, b.status
FROM bookings b
JOIN guests g ON g.guest_id = b.guest_id
JOIN rooms r ON r.room_id = b.room_id
WHERE b.status IN ('reserved', 'checked_in')
ORDER BY b.check_in;

-- Rooms available for a requested date range.
SELECT r.room_number, r.room_type, r.nightly_rate
FROM rooms r
WHERE NOT EXISTS (
    SELECT 1
    FROM bookings b
    WHERE b.room_id = r.room_id
      AND b.status <> 'cancelled'
      AND b.check_in < DATE '2026-10-09'
      AND b.check_out > DATE '2026-10-07'
)
ORDER BY r.nightly_rate;

-- Estimated booking revenue and payment balance.
SELECT b.booking_id, g.full_name,
       (b.check_out - b.check_in) * r.nightly_rate AS booking_total,
       COALESCE(SUM(p.amount), 0) AS paid,
       (b.check_out - b.check_in) * r.nightly_rate - COALESCE(SUM(p.amount), 0) AS balance
FROM bookings b
JOIN guests g ON g.guest_id = b.guest_id
JOIN rooms r ON r.room_id = b.room_id
LEFT JOIN payments p ON p.booking_id = b.booking_id
GROUP BY b.booking_id, g.full_name, r.nightly_rate, b.check_in, b.check_out
ORDER BY b.booking_id;
