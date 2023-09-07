FROM mcr.microsoft.com/mssql/server:2022-latest
USER root
WORKDIR /scripts
COPY . .
RUN chmod +x ./initialize_db.sh
RUN chmod +x ./script_db.sh
USER mssql
ENV ACCEPT_EULA=Y
ENV MSSQL_SA_PASSWORD=PasswordS3cur1t!
ENTRYPOINT /bin/bash ./initialize_db.sh