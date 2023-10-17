FROM mcr.microsoft.com/vscode/devcontainers/dotnet:0-5.0

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | gpg --dearmor > /usr/share/keyrings/yarn-archive-keyring.gpg
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends postgresql-client-common postgresql-client

RUN dotnet tool install --global dotnet-ef --version 5.*
RUN dotnet tool install --global dotnet-aspnet-codegenerator --version 5.*

ENV PATH="${PATH}:/root/.dotnet/tools"

RUN dotnet dev-certs https --trust

WORKDIR /app

COPY app/ .

ENTRYPOINT ["tail", "-f", "/dev/null"]
