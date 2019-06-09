FROM mcr.microsoft.com/dotnet/core/sdk:2.2 AS build
WORKDIR /app

# copy csproj and restore as distinct layers
COPY TestBuddyAppNetCore/*.csproj ./TestBuddyAppNetCore/
COPY Tests/*.csproj ./Tests/
WORKDIR /app/TestBuddyAppNetCore
RUN dotnet restore

# copy and publish app and libraries
WORKDIR /app/
COPY TestBuddyAppNetCore/. ./TestBuddyAppNetCore/
COPY Tests/. ./Tests/
WORKDIR /app/TestBuddyAppNetCore
RUN dotnet publish -c Release -o out


# test application -- see: dotnet-docker-unit-testing.md
FROM build AS testrunner
WORKDIR /app/Tests
COPY Tests/. .
ENTRYPOINT ["dotnet", "test"]


FROM mcr.microsoft.com/dotnet/core/runtime:2.2 AS runtime
WORKDIR /app
COPY --from=build /app/TestBuddyAppNetCore/out ./
ENTRYPOINT ["dotnet", "TestBuddyAppNetCore.dll"]