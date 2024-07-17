//data of all big login response
class ShopLoginModel {
  bool? status;
  String? msg;
  ShopUserData? data;
  ShopLoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['message'];
    data = json['data'] != null ? ShopUserData.fromJson(json['data']) : null;
  }
}

// user data = data in top model
class ShopUserData {
  int? id;
  String? email;
  String? name;
  String? token;
  String? phone;
  String? img;
  int? points;
  int? credit;

  ShopUserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    token = json['token'];
    phone = json['phone'];
    img = json['image'];
    points = json['points'];
    credit = json['credit'];
  }
}

/*Fluttertoast.showToast(
        msg: "This is Center Short Toast",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );*/
