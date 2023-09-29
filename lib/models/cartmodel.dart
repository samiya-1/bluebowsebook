class CartModel {
  int? id;
  String? bookName;
  String? amount;
  String? status;
  int? user;

  CartModel({this.id, this.bookName, this.amount, this.status, this.user});

  CartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bookName = json['book_name'];
    amount = json['amount'];
    status = json['status'];
    user = json['user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['book_name'] = this.bookName;
    data['amount'] = this.amount;
    data['status'] = this.status;
    data['user'] = this.user;
    return data;
  }
}