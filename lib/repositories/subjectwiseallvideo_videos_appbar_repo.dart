

import '../network/network_api_service.dart';
import '../network/urls.dart';

class SubjectWiseAllVideoVideosAppBarRepo{
  BaseApiServices apiServices=NetworkApiService();

  Future<dynamic> fetch(dynamic data) async{
    try{
      dynamic response= await apiServices.postMultiPartApi(AppUrl.subjectwiseAllvideoVideosAppBar , data);
      return response;
    }catch(e){
      print(e.toString());
    }
  }
}