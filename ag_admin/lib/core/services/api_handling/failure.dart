class Failure {
  Failure({this.message, this.statusCode, this.hello});

  Failure.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    statusCode = json['code'].toString();
  }
  String? message;
  String? statusCode;
  String? Function(String?)? hello;

  Map<String, dynamic> toJson() {
    return {
      "message": message,
      "code": statusCode,
    };
  }
}
