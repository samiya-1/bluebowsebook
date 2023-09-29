class favouriteModel {
  List<Data>? data;
  String? message;
  bool? success;

  favouriteModel({this.data, this.message, this.success});

  favouriteModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    message = json['message'];
    success = json['success'];
  }

  get bookname => null;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    data['success'] = this.success;
    return data;
  }
}

class Data {
  int? id;
  String? bookname;
  String? status;
  int? user;
  int? book;

  Data({this.id, this.bookname, this.status, this.user, this.book});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bookname = json['bookname'];
    status = json['status'];
    user = json['user'];
    book = json['book'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['bookname'] = this.bookname;
    data['status'] = this.status;
    data['user'] = this.user;
    data['book'] = this.book;
    return data;
  }
}