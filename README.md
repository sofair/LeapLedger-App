![GitHub License](https://img.shields.io/github/license/ZiRunHua/LeapLedger-App)
![GitHub Downloads (all assets, all releases)](https://img.shields.io/github/downloads/ZiRunHua/LeapLedger-App/total)
![GitHub stars](https://img.shields.io/github/stars/ZiRunHua/LeapLedger-App?style=social)
![GitHub Release](https://img.shields.io/github/v/release/ZiRunHua/LeapLedger-App)

# LeapLedger-App
`LeapLedger`是一个的前后端分离的免费开源的记账软件，基于`flutter`带来丝滑流畅的使用体验，在未来轻松扩展至iOS、Mac和Windows。

这是`LeapLedger`的客户端部分，更多的介绍内容请浏览:https://github.com/ZiRunHua/LeapLedger
## 服务端
Gin服务端项目传送：https://github.com/ZiRunHua/LeapLedger

## 开发
如果你只想使用Docker构建安装包请[跳转](#docker)

1. 检查flutter环境
```bash
flutter doctor -v 
```
2. 克隆项目
```bash
git clone https://github.com/ZiRunHua/LeapLedger-App.git leap_ledger_app
```
3. 新建./.vscode/launch.json文件
新建./.vscode/launch.json文件，复制一下内容并设置`host`
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
4. 启动API服务

我们提供了启动后端服务器的脚本，该脚本会自动寻找当前客户端版本对应的最新可用的后端`docker`镜像，并执行启动命令

API服务依赖[Docker](#https://www.docker.com)，请确保你安装了它
```bash
docker --version
```
  - window

PowerShell脚本，如果命令的执行出现问题，请在“文件管理器”中右键点击start.ps1，选择“使用PowerSheel运行”
```bash
cd service
.\start.ps1
```

- linux/mac
```bash
cd service
./start
```

如果以上方式都没能启动API服务，不用担心，你可以直接`git clone`服务端项目，然后切换到对应版本后运行。

传送门：https://github.com/ZiRunHua/LeapLedger

启动完成后，你可以通过访问以下 URL 来验证 API 服务是否正常运行：

http://localhost:8080/public/health

5. API文档
采用了RESTful API设计风格，提供了多种形式的API文档

- [ApiFox 接口文档](https://apifox.com/apidoc/shared-df940a71-63e8-4af7-9090-1be77ba5c3df)
- 如果通过脚本启动 API 服务，你也可以在 `./service/docs` 目录下查看 API 文档。
- API 服务还提供了在线的 API 文档访问页面：[http://localhost:8080/public/swagger/index.html](http://localhost:8080/public/swagger/index.html)
## 构建安装包

如果你已经配置好了 Flutter 开发环境，可以使用以下命令来构建 APK 文件。

请将 `<ip>` 替换为你主机的 IP 地址，端口默认为 `8080`，可以不做修改。
```bash
flutter build apk --release --dart-define=config.server.network.host=<ip> --dart-define=config.server.network.port=8080
```
### Docker
使用docker构建请在根目录下新建.env文件,并设置 IP 地址
```
# 服务器地址
SERVER_HOST=""
# 服务器端口
SERVER_PORT="8080"
# 服务端接口签名对称秘钥 可选
# SERVER_SIGN_KEY=""
```
执行以下命令来启动构建过程。构建过程可能需要几分钟时间，具体取决于你的系统性能。如果你对 Android 开发有一定了解，可以通过挂载本地的 Gradle 路径来加速构建过程。
```bash
docker-compose up --build build_apk 
```
构建完成后，请检查`./docker/build`目录以查看生成的 APK 文件。


## 我们需要你
LeapLedger项目仍在初期开发阶段，许多功能和细节还在不断完善中。如果你有任何需求和建议欢迎提交`issues`,如果你对LeapLedger感兴趣欢迎体提交`pull request`,期待你的加入。

我们会在develop分支进行功能开发和调整，而main分支则用于发布稳定版本。


[![Stargazers over time](https://starchart.cc/ZiRunHua/LeapLedger-App.svg)](https://starchart.cc/ZiRunHua/LeapLedger-App)