class APIResponse<TypeModel> {
  TypeModel data;
  bool error;
  String errorMessage;
  APIResponse({this.data, this.errorMessage, this.error});
}