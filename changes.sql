-- Berlin spelled three ways in customers.city
BEGIN;
UPDATE customers SET city = 'Berlin' WHERE lower(btrim(city)) IN ('berlin', 'berlín');
COMMIT;

-- Acme GmbH twice in customers: consolidate 41 into 1
BEGIN;
UPDATE instances SET customer_ref = 1 WHERE customer_ref = 41;
UPDATE tickets SET customer_ref = 1 WHERE customer_ref = 41;
UPDATE invoices SET customer_ref = 1 WHERE customer_ref = 41;
UPDATE contacts SET customer_ref = 1 WHERE customer_ref = 41;
UPDATE portal_hits SET customer_ref = 1 WHERE customer_ref = 41;
DELETE FROM customers WHERE customer_id = 41;
COMMIT;

-- Negative hours in usage_daily
BEGIN;
DELETE FROM usage_daily WHERE hours < 0;
COMMIT;

-- Test accounts in customers: delete them and every row that belongs to them
BEGIN;
DELETE FROM usage_daily u USING instances i WHERE i.instance_id = u.instance_id AND i.customer_ref IN (42, 43);
DELETE FROM invoice_lines l USING invoices v WHERE v.invoice_id = l.invoice_id AND v.customer_ref IN (42, 43);
DELETE FROM ticket_notes n USING tickets t WHERE t.ticket_id = n.ticket_id AND t.customer_ref IN (42, 43);
DELETE FROM instances WHERE customer_ref IN (42, 43);
DELETE FROM invoices WHERE customer_ref IN (42, 43);
DELETE FROM tickets WHERE customer_ref IN (42, 43);
DELETE FROM contacts WHERE customer_ref IN (42, 43);
DELETE FROM portal_hits WHERE customer_ref IN (42, 43);
DELETE FROM customers WHERE customer_id IN (42, 43);
COMMIT;

-- Instances that point at no customer: their usage first, then the instances
BEGIN;
DELETE FROM usage_daily WHERE instance_id IN (SELECT i.instance_id FROM instances i LEFT JOIN customers c ON i.customer_ref = c.customer_id WHERE c.customer_id IS NULL);
DELETE FROM instances i WHERE NOT EXISTS (SELECT 1 FROM customers c WHERE c.customer_id = i.customer_ref);
COMMIT;

-- Instance-days loaded twice in usage_daily: keep the lower usage_id
BEGIN;
DELETE FROM usage_daily a USING usage_daily b WHERE b.instance_id = a.instance_id AND b.day = a.day AND a.usage_id > b.usage_id;
COMMIT;

-- Blank usage_daily.cost_eur: hours times the rate of the instance's type
BEGIN;
UPDATE usage_daily u SET cost_eur = u.hours * p.rate_eur_hour FROM instances i JOIN pricing p ON p.instance_type = i.instance_type WHERE i.instance_id = u.instance_id AND u.cost_eur IS NULL;
COMMIT;
