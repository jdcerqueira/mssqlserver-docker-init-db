FROM mcr.microsoft.com/mssql/server:2022-latest
USER root
WORKDIR /scripts
COPY ./data ./data
COPY ./log ./log
COPY ./*.sh .
COPY ./database ./database
VOLUME /scripts/data
VOLUME /scripts/log
RUN chmod +x ./entrypoint.sh
RUN chmod +x ./script_db.sh
RUN chmod -R 777 /scripts/data
RUN chmod -R 777 /scripts/log
USER mssql
ENV ACCEPT_EULA=Y
ENV MSSQL_SA_PASSWORD=PasswordS3cur1t!
ENV MSSQL_DATA_DIR=/scripts/data
ENV MSSQL_LOG_DIR=/scripts/log
ENTRYPOINT /bin/bash ./entrypoint.sh