/* Revenue Generation Analysis */
SELECT tt.train_type, SUM(j.ticket_price) AS total_revenue
FROM railway_system.train_type tt
JOIN railway_system.train_details td ON tt.train_type_id = td.train_type_id
JOIN railway_system.journey j ON td.train_id = j.train_id
WHERE j.payment_status = 'Paid'
GROUP BY tt.train_type;


/* List of Trains Running on a Specific Day */
SELECT DISTINCT td.train_id
FROM railway_system.train_details td
WHERE DATE(td.journey_start) = '09-01-2000';

/* User Sign-Up Trends */
SELECT DATE_TRUNC('week', sign_up_on) AS week, COUNT(*) AS sign_ups
FROM railway_system.user_login
GROUP BY week
ORDER BY week;

/* Top 5 Most Popular Trains Based on Passenger Count */
SELECT td.train_id, COUNT(j.passenger_id) AS total_passengers
FROM railway_system.train_details td
JOIN railway_system.journey j ON td.train_id = j.train_id
GROUP BY td.train_id
ORDER BY total_passengers DESC
LIMIT 5;

/* Active Users per Month */
SELECT DATE_TRUNC('month', sign_up_on) AS month, COUNT(user_id) AS user_count
FROM railway_system.user_login
GROUP BY month
ORDER BY month;

/* Train Delays Analysis */
SELECT tr.station_id, s.station_name, COUNT(*) AS delay_count
FROM railway_system.train_routes tr
JOIN railway_system.stations s ON tr.station_id = s.station_id
WHERE tr.estimated_arrival > tr.estimated_departure
GROUP BY tr.station_id, s.station_name;

/* Passenger Demographics Based on Journey History */
SELECT tt.train_type, COUNT(DISTINCT p.passenger_id) AS passenger_count
FROM railway_system.journey j
JOIN railway_system.passenger p ON j.passenger_id = p.passenger_id
JOIN railway_system.train_details td ON j.train_id = td.train_id
JOIN railway_system.train_type tt ON td.train_type_id = tt.train_type_id
GROUP BY tt.train_type;

/* Most Popular Routes */
SELECT td.source_station_id, td.destination_station_id, COUNT(j.journey_id) AS total_journeys
FROM railway_system.train_details td
JOIN railway_system.journey j ON td.train_id = j.train_id
GROUP BY td.source_station_id, td.destination_station_id
ORDER BY total_journeys DESC;

/* Average Journey Duration Per Train Type */
SELECT tt.train_type, AVG(td.duration_minutes) AS avg_duration
FROM railway_system.train_type tt
JOIN railway_system.train_details td ON tt.train_type_id = td.train_type_id
GROUP BY tt.train_type;

/* Station-wise Passenger Traffic */
SELECT s.station_name, COUNT(j.passenger_id) AS passenger_count
FROM railway_system.stations s
JOIN railway_system.train_routes tr ON s.station_id = tr.station_id
JOIN railway_system.journey j ON tr.train_id = j.train_id
GROUP BY s.station_name
ORDER BY passenger_count DESC;

/* Train Utilization and Availability Analysis */
SELECT td.train_id, 
       td.is_available,
       COUNT(j.journey_id) AS total_journeys,
       (CAST(COUNT(j.journey_id) AS FLOAT) / CAST(td.passenger_strength AS INT)) * 100 AS utilization_percentage
FROM railway_system.train_details td
LEFT JOIN railway_system.journey j ON td.train_id = j.train_id
GROUP BY td.train_id, td.is_available, td.passenger_strength;

/* Route Complexity Analysis */
SELECT tr.train_id, COUNT(tr.station_id) AS number_of_stops, AVG(tr.halt_duration_minutes) AS avg_halt_duration
FROM railway_system.train_routes tr
GROUP BY tr.train_id
HAVING COUNT(tr.station_id) > 5
ORDER BY number_of_stops DESC, avg_halt_duration DESC;




