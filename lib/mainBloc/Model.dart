class CardModel {
  late String netWorkName;
  late String type;
  late String time;
  late String size;
  late String username;
  late String password;
  CardModel({
    required this.netWorkName,
    required this.type,
    required this.time,
    required this.size,
    required this.username,
    required this.password,
  });

  CardModel.fromMap(Map<dynamic, dynamic> map)
      : netWorkName = map["netWorkName"],
        type = map["type"],
        time = map["time"],
        size = map["size"],
        username = map["username"],
        password = map["password"];
}
