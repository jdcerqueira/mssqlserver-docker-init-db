#! /bin/bash
sleep 10
find . -type f -name "*.sql" -not -ipath "*rollback*" -printf "%f\t%p\n" | sort -n | cut -d$'\t' -f2 | while read -r file
do
    sqlcmd -S "192.168.15.26\SQL2019A" -E -i $file -o "$file.log"
    echo "Executando o script: $file"
done