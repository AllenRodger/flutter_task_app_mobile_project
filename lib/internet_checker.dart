import 'package:data_connection_checker/data_connection_checker.dart';

class InternetChecker{
  bool isConnected;
  bool getConnection(){
    if(DataConnectionStatus.connected == true){
      isConnected = true;
    }
    if(DataConnectionStatus.disconnected == true){
      isConnected = false;
    }
   return isConnected;
  }
}