/// response_code : "1"
/// msg : "Membership plans"
/// data : [{"id":"1","title":"Pro Membership","description":"Pro Membership","price":1000,"time":"28","type":"1","image":"https://developmentalphawizz.com/e_gate/uploads/63343112edf05.jpeg","created_at":"2022-09-28 05:41:06","updated_at":"2022-09-28 11:33:38","time_text":"28 Days","plan_type":"Days"},{"id":"2","title":"Premium membership","description":"Premium membership","price":10000,"time":"3","type":"2","image":"https://developmentalphawizz.com/e_gate/uploads/633431231d7ad.jpeg","created_at":"2022-09-28 05:41:06","updated_at":"2022-09-28 11:33:55","time_text":"3 Months","plan_type":"Monthly"},{"id":"7","title":"Free Plan","description":"Free Plan","price":0,"time":"2","type":"1","image":"https://developmentalphawizz.com/e_gate/uploads/6334028573694.jpeg","created_at":"2022-09-28 08:15:01","updated_at":"2022-10-08 10:02:14","time_text":"2 Days","plan_type":"Days"}]

class SubscriptionModel {
  SubscriptionModel({
      String? responseCode,
      String? msg,
      List<Data>? data,}){
    _responseCode = responseCode;
    _msg = msg;
    _data = data;
}

  SubscriptionModel.fromJson(dynamic json) {
    _responseCode = json['response_code'];
    _msg = json['msg'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  String? _responseCode;
  String? _msg;
  List<Data>? _data;
SubscriptionModel copyWith({  String? responseCode,
  String? msg,
  List<Data>? data,
}) => SubscriptionModel(  responseCode: responseCode ?? _responseCode,
  msg: msg ?? _msg,
  data: data ?? _data,
);
  String? get responseCode => _responseCode;
  String? get msg => _msg;
  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['response_code'] = _responseCode;
    map['msg'] = _msg;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "1"
/// title : "Pro Membership"
/// description : "Pro Membership"
/// price : 1000
/// time : "28"
/// type : "1"
/// image : "https://developmentalphawizz.com/e_gate/uploads/63343112edf05.jpeg"
/// created_at : "2022-09-28 05:41:06"
/// updated_at : "2022-09-28 11:33:38"
/// time_text : "28 Days"
/// plan_type : "Days"

class Data {
  Data({
      String? id,
      String? title,
      String? description,
      num? price,
      String? time,
      String? type,
      String? image,
      String? createdAt,
      String? updatedAt,
      String? timeText,
     String? startDate,
     String? endtDate,
      String? planType,}){
    _id = id;
    _title = title;
    _description = description;
    _price = price;
    _time = time;
    _type = type;
    _image = image;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _timeText = timeText;
    _planType = planType;
    _startDate = startDate;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _description = json['description'];
    _price = json['price'];
    _time = json['time'];
    _type = json['type'];
    _image = json['image'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _timeText = json['time_text'];
    _planType = json['plan_type'];
    _startDate = json['start_date'];

  }
  String? _id;
  String? _title;
  String? _description;
  num? _price;
  String? _time;
  String? _type;
  String? _image;
  String? _createdAt;
  String? _updatedAt;
  String? _timeText;
  String? _planType;
  String? _startDate;
Data copyWith({  String? id,
  String? title,
  String? description,
  num? price,
  String? time,
  String? type,
  String? image,
  String? createdAt,
  String? updatedAt,
  String? timeText,
  String? planType,
  String? startDate,
}) => Data(  id: id ?? _id,
  title: title ?? _title,
  description: description ?? _description,
  price: price ?? _price,
  time: time ?? _time,
  type: type ?? _type,
  image: image ?? _image,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  timeText: timeText ?? _timeText,
  planType: planType ?? _planType,
  startDate: startDate ?? _startDate,
);
  String? get id => _id;
  String? get title => _title;
  String? get description => _description;
  num? get price => _price;
  String? get time => _time;
  String? get type => _type;
  String? get image => _image;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get timeText => _timeText;
  String? get planType => _planType;
  String? get startDate => _startDate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['description'] = _description;
    map['price'] = _price;
    map['time'] = _time;
    map['type'] = _type;
    map['image'] = _image;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['time_text'] = _timeText;
    map['plan_type'] = _planType;
    map['start_date'] = _startDate;
    return map;
  }

}