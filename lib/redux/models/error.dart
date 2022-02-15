class MyError {
  String code;
  String msg;
  String errorMsg;
  String location;

  MyError(
      { this.code,
       this.msg,
       this.errorMsg,
       this.location});

  Map<String, dynamic> toJson() {
    return {
      "code": this.code,
      "msg": this.msg,
      "errorMsg": this.errorMsg,
      "location": this.location,
    };
  }
}
