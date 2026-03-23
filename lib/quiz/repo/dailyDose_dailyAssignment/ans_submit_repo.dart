


import '../../../network/network_api_service.dart';
import '../../../network/urls.dart';

class DailydoseAnsSubmitRepo{
  BaseApiServices apiServices=NetworkApiService();

  Future<dynamic> fetch(dynamic data) async{
    try{
      dynamic response= await apiServices.postApi(AppUrl.dailydoseSubmitAns, data);
      return response;
    }catch(e){
      print(e.toString());
    }
  }
}