![GitHub License](https://img.shields.io/github/license/ZiRunHua/LeapLedger-App)
![GitHub Downloads (all assets, all releases)](https://img.shields.io/github/downloads/ZiRunHua/LeapLedger-App/total)
![GitHub stars](https://img.shields.io/github/stars/ZiRunHua/LeapLedger-App?style=social)
![GitHub Release](https://img.shields.io/github/v/release/ZiRunHua/LeapLedger-App)

# LeapLedger-App
 [English](README.en.md) | [简体中文](README.md)

`LeapLedger` is a free, open-source, and front-end/back-end separated accounting software. It offers a smooth and seamless user experience based on `Flutter`, with future plans to easily extend to iOS, Mac, and Windows.

This is the client-side part of `LeapLedger`. For more introduction content, please visit: https://github.com/ZiRunHua/LeapLedger

## Server
Gin server project link: https://github.com/ZiRunHua/LeapLedger

## Development
If you only want to use Docker to build the installation package, please [skip to Docker](#docker)

1. Check Flutter environment
```bash
flutter doctor -v 
```
2. Clone the project
```bash
git clone https://github.com/ZiRunHua/LeapLedger-App.git leap_ledger_app
```
3. Create a ./.vscode/launch.json file
Create a ./.vscode/launch.json file, copy the following content, and set the `host`
```json
{
  "version": "0.2.0",
  "configurations": [
    {
      "name": "LeapLedger-App",
      "request": "launch",
      "type": "dart",
      "args": [
        "--dart-define=config.server.network.host=",
        "--dart-define=config.server.network.port=8080",
      ]
    }
  ]
}
```
4. Start the API service

We provide a script to start the backend server, which will automatically find the latest available backend docker image corresponding to the current client version and execute the startup command.

The API service relies on Docker. Please ensure you have it installed.
```bash
docker --version
```
  - window

PowerShell script. If there is an issue with the command execution, right-click on start.ps1 in the "File Explorer" and select "Run with PowerShell".
```bash
cd service
.\start.ps1
```

- linux/mac
```bash
cd service
./start
```

If the above methods fail to start the API service, don't worry. You can directly `git clone` the server project, switch to the corresponding version, and then run it.

Link: https://github.com/ZiRunHua/LeapLedger

After starting, you can verify if the API service is running normally by accessing the following URL:

http://localhost:8080/public/health

5. API Documentation
Adopts the RESTful API design style and provides multiple forms of API documentation.

- [ApiFox Interface Documentation](https://apifox.com/apidoc/shared-df940a71-63e8-4af7-9090-1be77ba5c3df)
- If you start the API service via the script, you can also view the API documentation in the ./service/docs directory.
- The API service also provides an online API documentation access page:[http://localhost:8080/public/swagger/index.html](http://localhost:8080/public/swagger/index.html)
## Build Installation Package

If you have configured the Flutter development environment, you can use the following command to build the APK file.

Replace `<ip>` with your host's IP address. The port defaults to `8080` and does not need to be modified.
```bash
flutter build apk --release --dart-define=config.server.network.host=<ip> --dart-define=config.server.network.port=8080
```
### Docker
To build using Docker, create a .env file in the root directory and set the IP address.
```
# Server address
SERVER_HOST=""
# Server port
SERVER_PORT="8080"
# Server interface signature symmetric key (optional)
# SERVER_SIGN_KEY=""
```
Execute the following command to start the build process. The build process may take a few minutes, depending on your system performance. If you have some knowledge of Android development, you can mount the local Gradle path to speed up the build process.
```bash
docker-compose up --build build_apk 
```
After the build is complete, check the `./docker/build` directory to view the generated APK file.


## We Need You
The LeapLedger project is still in its early development stage, and many features and details are still being refined. If you have any requirements or suggestions, please submit `issues`. If you are interested in LeapLedger, feel free to submit `pull requests`. We look forward to your participation.

We will conduct feature development and adjustments on the develop branch, while the main branch is used for releasing stable versions.


## Stargazers over time
[![Stargazers over time](https://starchart.cc/ZiRunHua/LeapLedger-App.svg?variant=adaptive)](https://starchart.cc/ZiRunHua/LeapLedger-App)