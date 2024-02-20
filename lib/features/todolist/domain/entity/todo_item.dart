import 'dart:convert';

class ToDoItem {
  String? name;
  String? estimateBuyingPrice;
  String? estimateSellingPrice;

  ToDoItem(this.name, this.estimateBuyingPrice, this.estimateSellingPrice);

  ToDoItem.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    estimateBuyingPrice = json['estimateBuyingPrice'].toString();
    estimateSellingPrice = json['estimateSellingPrice'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['estimateBuyingPrice'] = estimateBuyingPrice.toString();
    data['estimateSellingPrice'] = estimateSellingPrice.toString();
    return data;
  }
}

class ToDoItemList {
  List<ToDoItem>? tradeItems;

  ToDoItemList({this.tradeItems});

  factory ToDoItemList.fromDynamicList(List<dynamic> list) {
    var orders = <ToDoItem>[];
    for (var item in list) {
      orders.add(ToDoItem.fromJson(item));
    }
    return ToDoItemList(tradeItems: orders);
  }

  List<dynamic> toDynamicList() {
    var orders = [];
    for (var item in tradeItems!) {
      orders.add(item.toJson());
    }
    return orders;
  }

  String toJson() {
    return jsonEncode(toDynamicList());
  }

  factory ToDoItemList.fromJson(String json) {
    return ToDoItemList.fromDynamicList(jsonDecode(json));
  }
}
