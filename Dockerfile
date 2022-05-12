FROM ubuntu:20.04

WORKDIR /gorkcraft

# Install Powershell 7
RUN apt-get update
RUN apt-get install -y wget apt-transport-https software-properties-common
RUN wget -q https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb
RUN dpkg -i packages-microsoft-prod.deb
RUN apt-get update
RUN add-apt-repository universe
RUN apt-get install -y powershell

# Install Java OpenJDK
RUN apt install -y openjdk-17-jre-headless

# Install screen
RUN apt-get -y install screen

COPY . .

# Get the latest Paper server .jar file
RUN pwsh -Command ./Update-PaperJar.ps1 -NoWarn

# Do initial server run and accept eula
RUN java -jar paper-latest.jar --nogui
RUN pwsh -Command ./Set-EulaAccepted.ps1 -EulaPath ./eula.txt
