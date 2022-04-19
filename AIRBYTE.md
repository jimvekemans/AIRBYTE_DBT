# Airbyte

>At its core, Airbyte is geared to handle the EL (Extract Load) steps of an ELT process.<br>
> These steps can also be referred in Airbyte's dialect as "Source" and "Destination".

## Airbyte Local
```bash
$ git clone https://github.com/airbytehq/airbyte.git
$ cd airbyte
$ docker-compose up
```

***Issues***: 
- Airbyte connection to snowflake fails on M1 macbook (host architecture does not match target architecture)
- Can't install Docker in Windows VM (nested virtualization not working on AMD Zen 1/2 architecture)

***

## Snowflake destination
**Destination type:** `Snowflake`

**Name:** `SNOWFLAKE_AIRBYTE_DESTINATION`

**Host:** `datasense.eu-west-1.snowflakecomputing.com`

**Role:** `AIRBYTE_ROLE`

**Warehouse:** `AIRBYTE_WAREHOUSE`

**Database:** `AIRBYTE_DBT_DEMO`

**Default schema:** `AIRBYTE_SCHEMA`

**Username:** `JVEKEMANS`

**Authentication Method:** *Username and Password*<br>
*Password*: `............`

**JDBC URL Params:** `\`

**Loading Method:** `[Recommended] Internal Staging`

***

## File source

#### Add file to airbyte local storage
```bash
docker cp LOCAL_PATH/SOMEFILE airbyte-scheduler:/tmp/airbyte_local/SOMEFILE
```

**Source type:** `File`

**Name:** `SOMEFILE`

**URL:** `/local/SOMEFILE`

**File Format:** `AIRBYTE_ROLE`

**Storage Provider:** `Local Filesystem`

**Dataset Name:** `XLSX_SOURCE_TEST`

***

## Connection

**Replication frequency:** `Manual`

**Destination Namespace:** `Destination default`

**Destination Stream Prefix (Optional):** `\`

**Normalization:** `Normalized tabular data`
> More info: https://docs.airbyte.com/understanding-airbyte/basic-normalization/


## Octavia-cli

Octavia is AirByte's latest addition and makes it possible to manage airbyte from the command line.

## Postgres

Connect to cloud instance:
```bash
EXPORT PGPASSWORD='postgres'; psql -h 3.123.92.133 -p 5432 -U postgres
```

Create read-only airbyte user on postgres:
```psql
CREATE USER airbyte PASSWORD 'datasense';
GRANT USAGE ON SCHEMA public TO airbyte;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT ON TABLES TO airbyte;
```