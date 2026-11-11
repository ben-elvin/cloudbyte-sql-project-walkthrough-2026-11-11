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
