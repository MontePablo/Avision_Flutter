

import '../network/network_api_service.dart';
import '../network/urls.dart';

class MagazineStudentzoneRepo{
  BaseApiServices apiServices=NetworkApiService();

  Future<dynamic> fetch() async{
    try{
      dynamic response= await apiServices.getApi(AppUrl.magazineStudentZone);
      return response;
    }catch(e){
      print(e.toString());
    }
  }
}