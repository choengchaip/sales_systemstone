class Config{
  var configData = {
    "hostIP": "localhost",
    "port": "8750"
  };
  String getIP(){
    return configData['hostIP'];
  }
  String getPort(){
    return configData['port'];
  }
}