# DBT (Data Build Tool)
## Installation (Docker)
#### From source:
```bash
$ git clone xemulian/docker-dbt.git /opt/
$ cd /opt/docker-dbt
$ docker build --build-arg PLUGINS=snowflake --tag datasense/dbt:1.1.0 .
```
#### From dockerhub
```bash
$ docker pull xemuliam/dbt:latest
```
#### Using homebrew
```zsh
~ brew update
~ brew tap dbt-labs/dbt
~ brew install dbt-snowflake
```

## Creating a new DBT project
```bash
$ docker run -it -v $(pwd):/usr/app/projects datasense/dbt:1.1.0 bash
$ dbt init

enter a name for your project (letters, digits, underscore):
$ AIRBYTE_DBT_DEMO

Which database would you like to use?
[1] snowflake
$ 1

account (http://<this_value>.snowflakecomputing.com)
$ datasense.eu-west-1

user (dev username):
$ JVEKEMANS

Desired authentication type option:
[1] password
[2] keypair
[3] sso
$ 1

password:
$ {PASSWORD}

role:
$ DBT_ROLE

warehouse:
$ AIRBYTE_WAREHOUSE

database:
$ AIRBYTE_DBT_DEMO

schema:
$ DEFAULT

threads:
$ 1
```

This profile will be stored under ~/.dbt/profiles.yml and looks like this:
```YAML
config:
  send_anonymous_usage_stats: false
  use_colors: true
  # partial_parse: <integer>
  # printer_width: <true | false>
  # write_json: <true | false>
  # warn_error: <true | false>
  # log_format: <true | false>
  # debug: <true | false>
  # version_check: <true | false>
  # fail_fast: <true | false>
  # use_experimental_parser: <true | false>
  # static_parser: <true | false>

AIRBYTE_DBT_DEMO: # NAME OF PROFILE
  target: dev # MUST MATCH ANY OF DEFINED OUTPUTS
  outputs:
    dev: # TARGET NAME
      type: snowflake
      account: datasense.eu-west-1

      user: JVEKEMANS
      password: "{}[]&*#?|-<>=!%@:`," # STORED IN PLAIN TEXT

      role: DBT_ROLE

      warehouse: AIRBYTE_WAREHOUSE
      database: AIRBYTE_DBT_DEMO
      schema: DEFAULT

      threads: 1
```

> To change where the profile is stored, you can add --profiles-dir /path/to/dir to the run command

dbt Cloud supports:
- *Postgres*
- *Redshift*
- *BigQuery*
- *Snowflake*
- *Databricks*
- *Spark*