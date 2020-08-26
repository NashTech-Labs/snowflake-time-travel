ALTER SESSION SET TIMEZONE = 'UTC'

--Select the current timestamp
SELECT CURRENT_TIMESTAMP;

--Copy the timestamp somewhere given by the query
--2020-08-02 11:04:34.068 +0000

USE DATABASE my_db;

SELECT COUNT(*) FROM sales;

--Load new data into sales table using COPY command
COPY INTO my_db.public.sales FROM @my_db.external_stages.my_ext_stage
FILE_FORMAT = (FORMAT_NAME = 'my_csv_format')
ON_ERROR = 'skip_file';

SELECT COUNT(*) FROM sales;

--Clone sales table before loading new records using timestamp
CREATE TRANSIENT TABLE sales_DEV CLONE sales BEFORE(TIMESTAMP => '2020-08-02 11:04:34.068'::timestamp)

SELECT COUNT(*) FROM sales_DEV;

--Clone sales table before loading new records using Query ID
CREATE TRANSIENT TABLE sales_DEV1 CLONE sales BEFORE (STATEMENT => '01949934-002f-2c7c-0000-00001df58551');

SELECT COUNT(*) FROM sales_DEV1;