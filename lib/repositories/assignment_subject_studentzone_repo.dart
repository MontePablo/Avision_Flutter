

import '../network/network_api_service.dart';
import '../network/urls.dart';

class AssignmentSubjectStudentzoneRepo{
  BaseApiServices apiServices=NetworkApiService();

  Future<dynamic> fetch() async{
    try{
      dynamic response= await apiServices.getApi(AppUrl.assignmentSubjectStudentZone);
      return response;
    }catch(e){
      print(e.toString());
    }
  }
}