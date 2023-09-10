FROM mcr.microsoft.com/mssql/server:2022-latest
USER root
WORKDIR /scripts
COPY ./*.sh .
COPY ./database ./database
RUN chmod +x ./entrypoint.sh
RUN chmod +x ./script_db.sh
ENV ACCEPT_EULA=Y
ENV MSSQL_SA_PASSWORD=PasswordS3cur1t!
ENTRYPOINT /bin/bash ./entrypoint.sh