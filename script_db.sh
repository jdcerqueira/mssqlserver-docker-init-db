#! /bin/bash
sleep 10
find . -type f -name "*.sql" -not -ipath "*rollback*" -printf "%f\t%p\n" | sort -n | cut -d$'\t' -f2 | while read -r file
do
    /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P PasswordS3cur1t! -i $file -o "$file.log"
    echo "Executando o script: $file"
done