# CloudByte handover

The eleven tables of `cloudbyte`, one heading each, in the order `schema.sql` declares them: every column, what it holds, and the query that proved it. I hold half A, and map the three tables both halves share and my own four; the other half's four carry their heading and nothing else.

## staff

*12 rows.* `SELECT count(*) FROM staff;`

| column | what it holds | the query that proved it |
|---|---|---|
| `username` | a member of staff's login name, one lower-case first name per person: `alice`, `bob`, `carol`, `dave`, `emma` first | `SELECT username, department, started_on FROM staff ORDER BY username LIMIT 5;` |
| `department` | which of three departments they work in: `Engineering` 4, `Marketing` 3, `Operations` 5 | `SELECT department, count(*) FROM staff GROUP BY department ORDER BY department;` |
| `started_on` | the day they started, from `2020-02-03` to `2024-07-15` | `SELECT min(started_on), max(started_on), count(*) FROM staff;` |

## customers

*43 rows.* `SELECT count(*) FROM customers;`

| column | what it holds | the query that proved it |
|---|---|---|
| `customer_id` | the customer's number, from `1` to `43` | `SELECT min(customer_id), max(customer_id), min(signed_on) AS first_signed, max(signed_on) AS last_signed, count(*) FROM customers;` |
| `company_name` | the customer's company name written out in full: `Acme GmbH`, `Brandt Logistik`, `Cordes AG` | `SELECT customer_id, company_name FROM customers ORDER BY customer_id LIMIT 5;` |
| `city` | the city the customer is in, 28 spellings; Berlin appears as `Berlin` 7, `Berlín` 1 and `berlin` 2 | `SELECT city, count(*) FROM customers GROUP BY city ORDER BY city;` |
| `country` | a two-letter country code: `AT` 1, `CH` 1, `DE` 40, `SE` 1 | `SELECT country, count(*) FROM customers GROUP BY country ORDER BY country;` |
| `signed_on` | the day the customer signed, from `2023-01-17` to `2025-04-08` | `SELECT min(customer_id), max(customer_id), min(signed_on) AS first_signed, max(signed_on) AS last_signed, count(*) FROM customers;` |
| `plan` | which of three plans the customer is on: `basic` 16, `enterprise` 9, `standard` 18 | `SELECT plan, count(*) FROM customers GROUP BY plan ORDER BY plan;` |
| `status` | `active` 38 or `churned` 5 | `SELECT status, count(*) FROM customers GROUP BY status ORDER BY status;` |
| `contact_1_email` | a first contact's email address, filled on 41 of the 43 customers | `SELECT count(*) FILTER (WHERE contact_1_email <> '') AS has_1, count(*) FILTER (WHERE contact_2_email <> '') AS has_2, count(*) FILTER (WHERE contact_3_email <> '') AS has_3 FROM customers;` |
| `contact_2_email` | a second contact's email address, filled on 29 of the 43 | `SELECT count(*) FILTER (WHERE contact_1_email <> '') AS has_1, count(*) FILTER (WHERE contact_2_email <> '') AS has_2, count(*) FILTER (WHERE contact_3_email <> '') AS has_3 FROM customers;` |
| `contact_3_email` | a third contact's email address, filled on 2 of the 43. A fourth contact has nowhere to go: no column holds one, and finding a customer by a contact's address means searching all three columns | `SELECT count(*) FILTER (WHERE contact_1_email <> '') AS has_1, count(*) FILTER (WHERE contact_2_email <> '') AS has_2, count(*) FILTER (WHERE contact_3_email <> '') AS has_3 FROM customers;` |

## pricing

*5 rows.* `SELECT count(*) FROM pricing;`

| column | what it holds | the query that proved it |
|---|---|---|
| `instance_type` | the five instance sizes: `cb.gpu`, `cb.large`, `cb.medium`, `cb.small`, `cb.xlarge` | `SELECT instance_type, rate_eur_hour FROM pricing ORDER BY instance_type;` |
| `rate_eur_hour` | the hourly rate for each size, from `0.024` (`cb.small`) to `0.740` (`cb.gpu`) | `SELECT instance_type, rate_eur_hour FROM pricing ORDER BY instance_type;` |

## instances

*404 rows.* `SELECT count(*) FROM instances;`

| column | what it holds | the query that proved it |
|---|---|---|
| `instance_id` | the instance's number, from `1001` to `1404` | `SELECT min(instance_id), max(instance_id), min(customer_ref), max(customer_ref), min(launched_on) AS first_launch, max(launched_on) AS last_launch, min(terminated_on) AS first_term, max(terminated_on) AS last_term, count(*) FROM instances;` |
| `customer_ref` | a customer number, from `1` to `46` | `SELECT min(instance_id), max(instance_id), min(customer_ref), max(customer_ref), min(launched_on) AS first_launch, max(launched_on) AS last_launch, min(terminated_on) AS first_term, max(terminated_on) AS last_term, count(*) FROM instances;` |
| `region` | which of three regions it runs in: `eu-central-1` 138, `eu-north-1` 141, `eu-west-1` 125 | `SELECT region, count(*) FROM instances GROUP BY region ORDER BY region;` |
| `instance_type` | its size: `cb.gpu` 91, `cb.large` 87, `cb.medium` 65, `cb.small` 77, `cb.xlarge` 84 | `SELECT instance_type, count(*) FROM instances GROUP BY instance_type ORDER BY instance_type;` |
| `launched_on` | the day it was launched, from `2024-01-01` to `2025-10-02` | `SELECT min(instance_id), max(instance_id), min(customer_ref), max(customer_ref), min(launched_on) AS first_launch, max(launched_on) AS last_launch, min(terminated_on) AS first_term, max(terminated_on) AS last_term, count(*) FROM instances;` |
| `terminated_on` | the day it was shut down, from `2024-03-29` to `2025-12-27` | `SELECT min(instance_id), max(instance_id), min(customer_ref), max(customer_ref), min(launched_on) AS first_launch, max(launched_on) AS last_launch, min(terminated_on) AS first_term, max(terminated_on) AS last_term, count(*) FROM instances;` |

## usage_daily

*180660 rows.* `SELECT count(*) FROM usage_daily;`

| column | what it holds | the query that proved it |
|---|---|---|
| `usage_id` | the row's number, from `1` to `180660` | `SELECT min(usage_id), max(usage_id), min(instance_id), max(instance_id), min(day), max(day), min(hours), max(hours), min(cost_eur), max(cost_eur), count(*) FROM usage_daily;` |
| `instance_id` | an instance number, from `1001` to `1404` | `SELECT min(usage_id), max(usage_id), min(instance_id), max(instance_id), min(day), max(day), min(hours), max(hours), min(cost_eur), max(cost_eur), count(*) FROM usage_daily;` |
| `day` | the day the usage was for, from `2024-01-01` to `2025-12-31` | `SELECT min(usage_id), max(usage_id), min(instance_id), max(instance_id), min(day), max(day), min(hours), max(hours), min(cost_eur), max(cost_eur), count(*) FROM usage_daily;` |
| `hours` | hours run that day, from `-20` to `24` | `SELECT min(usage_id), max(usage_id), min(instance_id), max(instance_id), min(day), max(day), min(hours), max(hours), min(cost_eur), max(cost_eur), count(*) FROM usage_daily;` |
| `cost_eur` | what that day cost, from `-9.6200` to `17.7600` | `SELECT min(usage_id), max(usage_id), min(instance_id), max(instance_id), min(day), max(day), min(hours), max(hours), min(cost_eur), max(cost_eur), count(*) FROM usage_daily;` |

`usage_daily` has no row for July 2025: 10067 rows in June, 0 in July and 10735 in August. Found with `SELECT count(*) FILTER (WHERE day BETWEEN DATE '2025-06-01' AND DATE '2025-06-30') AS jun_2025, count(*) FILTER (WHERE day BETWEEN DATE '2025-07-01' AND DATE '2025-07-31') AS jul_2025, count(*) FILTER (WHERE day BETWEEN DATE '2025-08-01' AND DATE '2025-08-31') AS aug_2025 FROM usage_daily;`

## invoices

*854 rows.* `SELECT count(*) FROM invoices;`

| column | what it holds | the query that proved it |
|---|---|---|
| `invoice_id` | the invoice's number, from `5001` to `5854` | `SELECT min(invoice_id), max(invoice_id), min(customer_ref), max(customer_ref), min(period_month), max(period_month), min(issued_on), max(issued_on), min(total_eur), max(total_eur), count(*) FROM invoices;` |
| `customer_ref` | a customer number, from `1` to `43` | `SELECT min(invoice_id), max(invoice_id), min(customer_ref), max(customer_ref), min(period_month), max(period_month), min(issued_on), max(issued_on), min(total_eur), max(total_eur), count(*) FROM invoices;` |
| `period_month` | the month billed, as its first day, from `2024-01-01` to `2025-12-01` | `SELECT min(invoice_id), max(invoice_id), min(customer_ref), max(customer_ref), min(period_month), max(period_month), min(issued_on), max(issued_on), min(total_eur), max(total_eur), count(*) FROM invoices;` |
| `issued_on` | the day the invoice was sent, from `2024-02-05` to `2026-01-05` | `SELECT min(invoice_id), max(invoice_id), min(customer_ref), max(customer_ref), min(period_month), max(period_month), min(issued_on), max(issued_on), min(total_eur), max(total_eur), count(*) FROM invoices;` |
| `status` | `open` 174, `overdue` 151 or `paid` 529 | `SELECT status, count(*) FROM invoices GROUP BY status ORDER BY status;` |
| `total_eur` | the invoice total, from `12.97` to `2338.73` | `SELECT min(invoice_id), max(invoice_id), min(customer_ref), max(customer_ref), min(period_month), max(period_month), min(issued_on), max(issued_on), min(total_eur), max(total_eur), count(*) FROM invoices;` |

## invoice_lines

*3811 rows.* `SELECT count(*) FROM invoice_lines;`

| column | what it holds | the query that proved it |
|---|---|---|
| `line_id` | the line's number, from `20001` to `23811` | `SELECT min(line_id), max(line_id), min(invoice_id), max(invoice_id), min(qty), max(qty), count(*) FROM invoice_lines;` |
| `invoice_id` | an invoice number, from `5001` to `5854` | `SELECT min(line_id), max(line_id), min(invoice_id), max(invoice_id), min(qty), max(qty), count(*) FROM invoice_lines;` |
| `line_desc` | a description written out, a size and an instance: `cb.medium compute, instance 1007` | `SELECT line_id, line_desc FROM invoice_lines ORDER BY line_id LIMIT 5;` |
| `qty` | a quantity, from `400` to `744` | `SELECT min(line_id), max(line_id), min(invoice_id), max(invoice_id), min(qty), max(qty), count(*) FROM invoice_lines;` |
| `trn_amt_3` | the line's charge in whole cents, `qty` hours times the hourly rate in cents: the ratio comes back as five rates, `2.40` 601, `4.80` 524, `9.60` 880, `19.20` 831 and `74.00` 975, which add up to all 3811 lines | `SELECT round(trn_amt_3 * 1.0 / qty, 2) AS per_unit, count(*) FROM invoice_lines WHERE qty > 0 GROUP BY per_unit ORDER BY per_unit;` |
| `vat_rate` | one rate on every line: `0.190` 3811 | `SELECT vat_rate, count(*) FROM invoice_lines GROUP BY vat_rate ORDER BY vat_rate;` |

## contacts

*Half B's table: the other side maps it.*

## tickets

*Half B's table: the other side maps it.*

## ticket_notes

*Half B's table: the other side maps it.*

## portal_hits

*Half B's table: the other side maps it.*

## Relationships

| relationship | `INNER JOIN` rows | `LEFT JOIN` rows | the queries that proved it |
|---|---|---|---|
| `instances.customer_ref` → `customers.customer_id` | 398 | 404 | `SELECT count(*) AS inner_join FROM instances i JOIN customers c ON c.customer_id = i.customer_ref;` `SELECT count(*) AS left_join FROM instances i LEFT JOIN customers c ON c.customer_id = i.customer_ref;` |
| `invoices.customer_ref` → `customers.customer_id` | 854 | 854 | `SELECT count(*) AS inner_join FROM invoices v JOIN customers c ON c.customer_id = v.customer_ref;` `SELECT count(*) AS left_join FROM invoices v LEFT JOIN customers c ON c.customer_id = v.customer_ref;` |
| `usage_daily.instance_id` → `instances.instance_id` | 180660 | 180660 | `SELECT count(*) AS inner_join FROM usage_daily u JOIN instances i ON i.instance_id = u.instance_id;` `SELECT count(*) AS left_join FROM usage_daily u LEFT JOIN instances i ON i.instance_id = u.instance_id;` |
| `invoice_lines.invoice_id` → `invoices.invoice_id` | 3811 | 3811 | `SELECT count(*) AS inner_join FROM invoice_lines l JOIN invoices v ON v.invoice_id = l.invoice_id;` `SELECT count(*) AS left_join FROM invoice_lines l LEFT JOIN invoices v ON v.invoice_id = l.invoice_id;` |

`invoices` has 854 rows (`SELECT count(*) AS invoices FROM invoices;`). Joined to `invoice_lines` on `invoice_id`, it returns 3811 rows, one for each invoice line (`SELECT count(*) AS after_join FROM invoices v JOIN invoice_lines l ON l.invoice_id = v.invoice_id;`).

Declaring `instances.customer_ref` → `customers.customer_id` as a foreign key:

```sql
ALTER TABLE instances ADD CONSTRAINT fk_instances_customer
  FOREIGN KEY (customer_ref) REFERENCES customers (customer_id);
```

The engine refused it:

```text
ERROR:  insert or update on table "instances" violates foreign key constraint "fk_instances_customer"
DETAIL:  Key (customer_ref)=(44) is not present in table "customers".
```

Two instances carry `44`: `1399` and `1400` (`SELECT instance_id, customer_ref FROM instances WHERE customer_ref = 44 ORDER BY instance_id;`).

In all, 6 instances point at a customer that is not in `customers`, and between them they point at 3 missing customer numbers (`SELECT count(*) AS orphan_instances, count(DISTINCT i.customer_ref) AS missing_customers FROM instances i LEFT JOIN customers c ON i.customer_ref = c.customer_id WHERE c.customer_id IS NULL;`).

## Corrections

### Blank `usage_daily.cost_eur`

Some rows of `usage_daily` have no value in `cost_eur`. The total of `cost_eur` is 1020370.6520, calculated from 177669 of the 180660 rows: `SELECT count(*) AS usage_rows, count(cost_eur) AS with_cost, sum(cost_eur) AS total_eur FROM usage_daily;`

The rows the total left out: `SELECT count(*) AS usage_rows FROM usage_daily WHERE cost_eur IS NULL;`

*2991 rows.*

Nothing in cloudbyte had been changed when this count was taken.

The repair, kept. A blank cost is the reading's hours times the hourly rate of its instance's type, two tables away. The rule first held on every reading that has a cost: `SELECT count(*) AS with_cost FROM usage_daily u JOIN instances i ON i.instance_id = u.instance_id JOIN pricing p ON p.instance_type = i.instance_type WHERE u.cost_eur IS NOT NULL;` and `SELECT count(*) AS cost_agrees FROM usage_daily u JOIN instances i ON i.instance_id = u.instance_id JOIN pricing p ON p.instance_type = i.instance_type WHERE u.cost_eur = u.hours * p.rate_eur_hour;` both returned 174061.

```sql
BEGIN;
UPDATE usage_daily u SET cost_eur = u.hours * p.rate_eur_hour FROM instances i JOIN pricing p ON p.instance_type = i.instance_type WHERE i.instance_id = u.instance_id AND u.cost_eur IS NULL;
COMMIT;
```

The count just before it was 2942, not 2991: 49 of the blank rows went with the earlier deletes (test accounts, orphans and the second rows of duplicated days). The tag was `UPDATE 2942`. The check, `SELECT usage_id FROM usage_daily WHERE cost_eur IS NULL;`, lists any blank left; it returned 0 rows, and from a new connection too. By hand, reading 35 (instance 1001, `cb.medium`) has 24 hours at 0.048, and its new cost is 1.1520. The repair moved the `cost_eur` total up, from 1008414.6240 to 1025258.6440, and it is now taken over all 177003 rows.

### Berlin spelled three ways in `customers.city`

`customers.city` holds Berlin three ways: `Berlin` on 7 customers, `Berlín` (an accent on the i) on 1, and `berlin ` (a small b and a space at the end) on 2: `SELECT city, length(city) AS characters, count(*) AS customers FROM customers WHERE lower(btrim(city)) LIKE 'berl%' GROUP BY city ORDER BY city;`

I count them as one city. All ten rows carry country `DE` (`SELECT customer_id, company_name, city, country, plan FROM customers WHERE lower(btrim(city)) IN ('berlin', 'berlín') ORDER BY city, customer_id;`), there is no German city called Berlín, and one of the `berlin ` customers is named after Grunewald, a district of Berlin. Folded, the three spellings come to 10 customers: `SELECT count(*) AS customers FROM customers WHERE lower(btrim(city)) IN ('berlin', 'berlín');`

Nothing in cloudbyte had been changed when this count was taken.


The repair, kept:

```sql
BEGIN;
UPDATE customers SET city = 'Berlin' WHERE lower(btrim(city)) IN ('berlin', 'berlín');
COMMIT;
```

The count just before it was 10 (`SELECT count(*) AS customers FROM customers WHERE lower(btrim(city)) IN ('berlin', 'berlín');`), the same as above, and the tag was `UPDATE 10`. The check, `SELECT customer_id, city FROM customers WHERE lower(btrim(city)) IN ('berlin', 'berlín') AND city <> 'Berlin';`, returned 0 rows. The repair didn't change the `cost_eur` total from **What A Blank Does To A Total**: it is still 1020370.6520, because the repair touched only `customers.city`. Had the tag come back below 10, the `UPDATE`'s `WHERE` would have missed some of the rows I counted, and I would have rolled it back.

### Negative `hours` in `usage_daily`

The unwritten rule: an instance can't run for a negative number of hours in a day. The rows that break it: `SELECT usage_id, instance_id, day, hours, cost_eur FROM usage_daily WHERE hours < 0 ORDER BY usage_id;`

*12 rows.*

Nothing in cloudbyte had been changed when this count was taken.

The repair, kept. A negative reading is a credit typed in as usage, so the rows are deleted:

```sql
BEGIN;
DELETE FROM usage_daily WHERE hours < 0;
COMMIT;
```

The count just before it was 12 (`SELECT count(*) AS readings FROM usage_daily WHERE hours < 0;`), the same as above, and the tag was `DELETE 12`. The check, the listing above, returned 0 rows, before the `COMMIT` and again from a new connection. The repair moved the `cost_eur` total up, from 1020370.6520 to 1020387.9520, because the 12 deleted rows carried negative costs; it is now taken over 177657 of 180648 rows. It also took 9 of the 195 instance-days counted under **Instance-days loaded twice**: 9 of the deleted rows were the second row of a duplicated day, so that count is now 186.

### Acme GmbH twice in `customers`

The unwritten rule: each company is in `customers` once. The companies with more than one row, folded so that capitals and end spaces don't split them: `SELECT lower(btrim(company_name)) AS company, count(*) AS rows FROM customers GROUP BY lower(btrim(company_name)) HAVING count(*) > 1 ORDER BY company;`

*1 row.*

Its two rows are `customer_id` 1 (`Acme GmbH`) and 41 (`ACME GmbH`): `SELECT customer_id, company_name FROM customers WHERE lower(btrim(company_name)) = 'acme gmbh' ORDER BY customer_id;`

Nothing in cloudbyte had been changed when this count was taken.

The consolidation, kept. Customer 1 is the original (the lower id) and 41 the copy. The rows pointing at 41 before it: `SELECT 'instances' AS table_name, count(*) AS rows FROM instances WHERE customer_ref = 41 UNION ALL SELECT 'tickets', count(*) FROM tickets WHERE customer_ref = 41 UNION ALL SELECT 'invoices', count(*) FROM invoices WHERE customer_ref = 41 UNION ALL SELECT 'contacts', count(*) FROM contacts WHERE customer_ref = 41 UNION ALL SELECT 'portal_hits', count(*) FROM portal_hits WHERE customer_ref = 41;` returned `instances` 16, `tickets` 31, `invoices` 24, `contacts` 3, `portal_hits` 3780.

```sql
BEGIN;
UPDATE instances SET customer_ref = 1 WHERE customer_ref = 41;
UPDATE tickets SET customer_ref = 1 WHERE customer_ref = 41;
UPDATE invoices SET customer_ref = 1 WHERE customer_ref = 41;
UPDATE contacts SET customer_ref = 1 WHERE customer_ref = 41;
UPDATE portal_hits SET customer_ref = 1 WHERE customer_ref = 41;
DELETE FROM customers WHERE customer_id = 41;
COMMIT;
```

The tags were `UPDATE 16`, `UPDATE 31`, `UPDATE 24`, `UPDATE 3`, `UPDATE 3780` and `DELETE 1`, each matching its line of the tally. Both checks returned 0 rows, before the `COMMIT` and again from a new connection: `SELECT 'instances' AS table_name, instance_id AS id FROM instances WHERE customer_ref = 41 UNION ALL SELECT 'tickets', ticket_id FROM tickets WHERE customer_ref = 41 UNION ALL SELECT 'invoices', invoice_id FROM invoices WHERE customer_ref = 41 UNION ALL SELECT 'contacts', contact_id FROM contacts WHERE customer_ref = 41 UNION ALL SELECT 'portal_hits', hit_id FROM portal_hits WHERE customer_ref = 41;` and `SELECT lower(btrim(company_name)) AS company, count(*) AS rows FROM customers GROUP BY lower(btrim(company_name)) HAVING count(*) > 1 ORDER BY company;`. The consolidation didn't change the `cost_eur` total from **What A Blank Does To A Total**: it was still 1020370.6520 after it, because no row of `usage_daily` changed.

### Instance-days loaded twice in `usage_daily`

The unwritten rule: `usage_daily` holds one row for each instance on each day. The instance-days with more than one row: `SELECT instance_id, day, count(*) AS rows FROM usage_daily GROUP BY instance_id, day HAVING count(*) > 1 ORDER BY instance_id, day;`

*195 rows.*

Each of the 195 holds two rows.

Nothing in cloudbyte had been changed when this count was taken.

The repair, kept. A self-join; the row with the lower `usage_id` stays:

```sql
BEGIN;
DELETE FROM usage_daily a USING usage_daily b WHERE b.instance_id = a.instance_id AND b.day = a.day AND a.usage_id > b.usage_id;
COMMIT;
```

Just before it, the duplicated instance-days counted 182 (`SELECT count(*) AS instance_days FROM (SELECT instance_id, day, count(*) AS rows FROM usage_daily GROUP BY instance_id, day HAVING count(*) > 1) d;`), not 195: 9 went with the negative-hours repair, and 4 more belonged to the test accounts' or the orphans' instances. The tag was `DELETE 182`. The check, the entry's listing, returned 0 rows from a new connection. It moved the `cost_eur` total from **What A Blank Does To A Total** down. I took the figure once, after all three repairs on this page: 1008414.6240, over 174061 of 177003 rows.

### Test accounts in `customers`

The unwritten rule: a test account isn't a customer. The rows whose `company_name` says they are test accounts: `SELECT customer_id, company_name FROM customers WHERE company_name ILIKE '%test%' ORDER BY customer_id;`

*2 rows.*

Their `customer_id` values are 42 (`zz_test_account`) and 43 (`TEST-Account`). The rows linked to them in the eight tables that link to `customers`: `SELECT 'instances' AS table_name, count(*) AS rows FROM instances WHERE customer_ref IN (42, 43) UNION ALL SELECT 'invoices', count(*) FROM invoices WHERE customer_ref IN (42, 43) UNION ALL SELECT 'contacts', count(*) FROM contacts WHERE customer_ref IN (42, 43) UNION ALL SELECT 'tickets', count(*) FROM tickets WHERE customer_ref IN (42, 43) UNION ALL SELECT 'portal_hits', count(*) FROM portal_hits WHERE customer_ref IN (42, 43) UNION ALL SELECT 'usage_daily', count(*) FROM usage_daily u JOIN instances i ON i.instance_id = u.instance_id WHERE i.customer_ref IN (42, 43) UNION ALL SELECT 'invoice_lines', count(*) FROM invoice_lines l JOIN invoices v ON v.invoice_id = l.invoice_id WHERE v.customer_ref IN (42, 43) UNION ALL SELECT 'ticket_notes', count(*) FROM ticket_notes n JOIN tickets t ON t.ticket_id = n.ticket_id WHERE t.customer_ref IN (42, 43);`

- `instances`: 4
- `invoices`: 44
- `contacts`: 0
- `tickets`: 4
- `portal_hits`: 0
- `usage_daily`, through `instances`: 2136
- `invoice_lines`, through `invoices`: 75
- `ticket_notes`, through `tickets`: 15

Nothing in cloudbyte had been changed when this count was taken.

The repair, kept. Rows reached through a join go first, `customers` last:

```sql
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
```

The tally just before it was the same as above. The tags were `DELETE 2136`, `DELETE 75`, `DELETE 15`, `DELETE 4`, `DELETE 44`, `DELETE 4`, `DELETE 0`, `DELETE 0` and `DELETE 2`, each matching its line. The checks returned 0 rows from a new connection: the tally with each table's id (`SELECT 'instances' AS table_name, instance_id AS id FROM instances WHERE customer_ref IN (42, 43) UNION ALL SELECT 'invoices', invoice_id FROM invoices WHERE customer_ref IN (42, 43) UNION ALL SELECT 'contacts', contact_id FROM contacts WHERE customer_ref IN (42, 43) UNION ALL SELECT 'tickets', ticket_id FROM tickets WHERE customer_ref IN (42, 43) UNION ALL SELECT 'portal_hits', hit_id FROM portal_hits WHERE customer_ref IN (42, 43);`), the rows left pointing at a parent that isn't there (`SELECT 'usage_daily' AS table_name, u.usage_id AS id FROM usage_daily u WHERE NOT EXISTS (SELECT 1 FROM instances i WHERE i.instance_id = u.instance_id) UNION ALL SELECT 'invoice_lines', l.line_id FROM invoice_lines l WHERE NOT EXISTS (SELECT 1 FROM invoices v WHERE v.invoice_id = l.invoice_id) UNION ALL SELECT 'ticket_notes', n.note_id FROM ticket_notes n WHERE NOT EXISTS (SELECT 1 FROM tickets t WHERE t.ticket_id = n.ticket_id);`), and the entry's own listing. It moved the `cost_eur` total from **What A Blank Does To A Total** down. I took the figure once, after all three repairs on this page: 1008414.6240, over 174061 of 177003 rows.

### Instances that point at no customer

The unwritten rule: every row points at a customer who exists. The instances whose `customer_ref` has no row in `customers`: `SELECT i.instance_id, i.customer_ref FROM instances i LEFT JOIN customers c ON i.customer_ref = c.customer_id WHERE c.customer_id IS NULL ORDER BY i.instance_id;`

*6 rows.*

They are instances 1399 and 1400 (customer 44), 1401 and 1402 (customer 45), and 1403 and 1404 (customer 46), the same 6 counted under `## Relationships`.

Nothing in cloudbyte had been changed when this count was taken.

The repair, kept:

```sql
BEGIN;
DELETE FROM usage_daily WHERE instance_id IN (SELECT i.instance_id FROM instances i LEFT JOIN customers c ON i.customer_ref = c.customer_id WHERE c.customer_id IS NULL);
DELETE FROM instances i WHERE NOT EXISTS (SELECT 1 FROM customers c WHERE c.customer_id = i.customer_ref);
COMMIT;
```

Just before it, the orphans counted 6 (`SELECT count(*) AS orphan_instances FROM instances i LEFT JOIN customers c ON i.customer_ref = c.customer_id WHERE c.customer_id IS NULL;`) and their rows in `usage_daily` 1327 (`SELECT count(*) AS usage_rows FROM usage_daily WHERE instance_id IN (SELECT i.instance_id FROM instances i LEFT JOIN customers c ON i.customer_ref = c.customer_id WHERE c.customer_id IS NULL);`). The tags were `DELETE 1327` and `DELETE 6`. The checks, the entry's listing and `SELECT u.usage_id FROM usage_daily u WHERE NOT EXISTS (SELECT 1 FROM instances i WHERE i.instance_id = u.instance_id);`, returned 0 rows from a new connection. It moved the `cost_eur` total from **What A Blank Does To A Total** down. I took the figure once, after all three repairs on this page: 1008414.6240, over 174061 of 177003 rows.

`customers.status` holds two values, `active` on 35 customers and `churned` on 5, and neither is a fault: a churned customer was a real customer who left (`SELECT status, count(*) FROM customers GROUP BY status ORDER BY status;`).

### The corrected figures

**Day one's top five**

The published query, the one behind `spend-report.md`'s first table: `SELECT city, sum(amount_eur) AS total_eur FROM billing_export GROUP BY city ORDER BY total_eur DESC LIMIT 5;`

The corrected query. It keeps each bill once, leaves out the test accounts and the blank amounts, and counts every spelling of Berlin as one city: `WITH each_bill AS (SELECT DISTINCT * FROM billing_export) SELECT CASE WHEN lower(btrim(city)) IN ('berlin', 'berlín') THEN 'Berlin' ELSE city END AS folded_city, sum(amount_eur) AS total_eur FROM each_bill WHERE company NOT ILIKE '%test%' AND amount_eur IS NOT NULL GROUP BY folded_city ORDER BY total_eur DESC LIMIT 5;`

| Rank | Published | Corrected |
|---|---|---|
| 1 | Bremen, EUR 6296.25 | Berlin, EUR 10221.05 |
| 2 | Hamburg, EUR 5932.03 | Bremen, EUR 5343.37 |
| 3 | Berlin, EUR 5749.73 | Hamburg, EUR 4858.99 |
| 4 | München, EUR 3717.24 | München, EUR 3185.13 |
| 5 | Berlín, EUR 3279.31 | Jena, EUR 2434.80 |

The rows the corrected query leaves out, counted at four stops (406, 336, 327 and 306 rows: `SELECT count(*) AS all_rows FROM billing_export;`, `WITH each_bill AS (SELECT DISTINCT * FROM billing_export) SELECT count(*) AS after_copies FROM each_bill;`, `WITH each_bill AS (SELECT DISTINCT * FROM billing_export) SELECT count(*) AS after_tests FROM each_bill WHERE company NOT ILIKE '%test%';`, `WITH each_bill AS (SELECT DISTINCT * FROM billing_export) SELECT count(*) AS after_blanks FROM each_bill WHERE company NOT ILIKE '%test%' AND amount_eur IS NOT NULL;`):

- bills that are in twice: 70 rows
- test accounts: 9 rows
- blank amounts: 21 rows

The published answer was wrong mostly because of Berlin: its three spellings split the city across three rows, two of them in the top five, so the city that cost the most showed up third, at about half its real total.

**The metered cost**

| | Old | Now |
|---|---|---|
| The figure | 1020370.6520 | 1025258.6440 |
| Rows it left out | 2991 | 0 |

Queries: `SELECT count(*) AS usage_rows, count(cost_eur) AS with_cost, sum(cost_eur) AS total_eur FROM usage_daily;` and `SELECT count(*) AS usage_rows FROM usage_daily WHERE cost_eur IS NULL;`

The old figure left out the 2991 readings with a blank cost, and it also counted readings that later repairs deleted: credits, test accounts' readings, orphan instances' readings and readings loaded twice.

## Constraints

| # | the statement | what it closes |
|---:|---|---|
| 1 | `ALTER TABLE instances ADD CONSTRAINT fk_instances_customer FOREIGN KEY (customer_ref) REFERENCES customers (customer_id);` | `## Relationships`: `instances.customer_ref` → `customers.customer_id` |
| 2 | `ALTER TABLE invoices ADD CONSTRAINT fk_invoices_customer FOREIGN KEY (customer_ref) REFERENCES customers (customer_id);` | `## Relationships`: `invoices.customer_ref` → `customers.customer_id` |
| 3 | `ALTER TABLE usage_daily ADD CONSTRAINT fk_usage_daily_instance FOREIGN KEY (instance_id) REFERENCES instances (instance_id);` | `## Relationships`: `usage_daily.instance_id` → `instances.instance_id` |
| 4 | `ALTER TABLE invoice_lines ADD CONSTRAINT fk_invoice_lines_invoice FOREIGN KEY (invoice_id) REFERENCES invoices (invoice_id);` | `## Relationships`: `invoice_lines.invoice_id` → `invoices.invoice_id` |
| 5 | `ALTER TABLE usage_daily ALTER COLUMN cost_eur SET NOT NULL;` | `## Corrections`: Blank `usage_daily.cost_eur` |
| 6 | `ALTER TABLE customers ADD CONSTRAINT uq_customers_company_name UNIQUE (company_name);` | `## Corrections`: Acme GmbH twice in `customers` |
| 7 | `ALTER TABLE usage_daily ADD CONSTRAINT uq_usage_daily_instance_day UNIQUE (instance_id, day);` | `## Corrections`: Instance-days loaded twice in `usage_daily` |
| 8 | `ALTER TABLE usage_daily ADD CONSTRAINT ck_usage_daily_hours CHECK (hours >= 0 AND hours <= 24);` | `## Corrections`: Negative `hours` in `usage_daily` |
| 9 | `ALTER TABLE customers ADD CONSTRAINT ck_customers_status CHECK (status IN ('active', 'churned'));` | the sentence on the status column, below the Section 4 entries |

The constraints the database holds, from its own catalogue:

```sql
SELECT c.conrelid::regclass::text AS table_name, c.conname AS name,
       CASE c.contype WHEN 'f' THEN 'foreign key' WHEN 'u' THEN 'unique' ELSE 'check' END AS kind
  FROM pg_constraint c
 WHERE c.connamespace = 'public'::regnamespace AND c.contype IN ('f', 'u', 'c')
UNION ALL
SELECT a.attrelid::regclass::text, a.attname::text, 'not null'
  FROM pg_attribute a JOIN pg_class r ON r.oid = a.attrelid
 WHERE r.relnamespace = 'public'::regnamespace AND r.relkind = 'r'
   AND a.attnum > 0 AND NOT a.attisdropped AND a.attnotnull
   AND NOT EXISTS (SELECT 1 FROM pg_constraint p
                    WHERE p.conrelid = a.attrelid AND p.contype = 'p' AND a.attnum = ANY (p.conkey))
ORDER BY table_name, name;
```

```
  table_name   |            name             |    kind     
---------------+-----------------------------+-------------
 customers     | ck_customers_status         | check
 customers     | uq_customers_company_name   | unique
 instances     | fk_instances_customer       | foreign key
 invoice_lines | fk_invoice_lines_invoice    | foreign key
 invoices      | fk_invoices_customer        | foreign key
 usage_daily   | ck_usage_daily_hours        | check
 usage_daily   | cost_eur                    | not null
 usage_daily   | fk_usage_daily_instance     | foreign key
 usage_daily   | uq_usage_daily_instance_day | unique
(9 rows)
```

The unique constraint on `company_name` refuses a second `Acme GmbH` spelled exactly the same, but it lets in `ACME GmbH`: `SELECT company_name, company_name = 'ACME GmbH' AS same_text FROM customers WHERE lower(btrim(company_name)) = 'acme gmbh';` prints `f`, because to PostgreSQL different capital letters make different text.

In `customers.status`, `active` means the customer still buys from CloudByte, and `churned` means a real customer who has left; the constraint allows those two values and nothing else.
