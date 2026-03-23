class AppExeption implements Exception{

  final message;
  final prefix;
  AppExeption(this.message,this.prefix);

  @override
  String toString() {
    return "$prefix $message";
  }
}
class FetchDataException extends AppExeption{
  FetchDataException([String? message]) : super(message,"Error during communication");
}
class BadRequestException extends AppExeption{
  BadRequestException([String? message]) : super(message,"Invalid request");
}
class UnauthorizedException extends AppExeption{
  UnauthorizedException([String? message]) : super(message,"Unauthorized request");
}
class InvalidInputException extends AppExeption{
  InvalidInputException([String? message]) : super(message,"Invalid input request");
}