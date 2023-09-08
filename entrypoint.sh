#!/bin/bash
set -m
/opt/mssql/bin/sqlservr & ./script_db.sh
fg