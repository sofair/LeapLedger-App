class Server {
  late final Network network;
  late final String signKey;
  Server();
  init() {
    signKey = const String.fromEnvironment("config.server.signKey", defaultValue: '');
    network = Network();
  }
}

class Network {
  late final String host;
  late final String port;
  late final bool tls;
  late final String httpAddress;
  late final String websocketAddress;
  Network() {
    host = const String.fromEnvironment("config.server.network.host", defaultValue: '10.0.2.2').trim();
    port = const String.fromEnvironment("config.server.network.port", defaultValue: '8080').trim();
    tls = const bool.fromEnvironment("config.server.network.tls", defaultValue: true);
    if (host.isEmpty) host = '10.0.2.2';
    if (port.isEmpty) host = '8080';

    if (tls) {
      httpAddress = "https://$host:$port";
      websocketAddress = "wss://$host:$port";
    } else {
      httpAddress = "http://$host:$port";
      websocketAddress = "ws://$host:$port";
    }
  }
  Network.fromJson(dynamic data) {
    if (data.runtimeType == Map<String, dynamic>) {
      tls = data['tls'] != "false";
      host = data['host'];
      port = data['port'];
    } else {
      throw Exception("类型错误");
    }
  }
}
