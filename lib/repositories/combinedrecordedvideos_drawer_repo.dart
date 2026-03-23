

import '../network/network_api_service.dart';
import '../network/urls.dart';

class CombinedRecordedVideosDrawerRepo{
  BaseApiServices apiServices=NetworkApiService();

  Future<dynamic> fetch() async{
    try{
      dynamic response= await apiServices.getApi(AppUrl.combinedRecordedVideosDrawer);
      return response;
    }catch(e){
      print(e.toString());
    }
  }
}