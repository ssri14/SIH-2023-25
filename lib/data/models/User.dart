import 'dart:convert';
/// _id : "6513f852aad9664e5efb059a"
/// name : "Lavanya"
/// phoneNo : "8494989"
/// department : "police"
/// district : "Dhanbad"
/// username : "lava"
/// password : "123"
/// isAdmin : "False"
/// adminUsername : "kaush"
/// Lat : 0
/// Long : 0
/// __v : 0

User userFromJson(String str) => User.fromJson(json.decode(str));
String userToJson(User data) => json.encode(data.toJson());
class User {
  User({
      String? id, 
      String? name, 
      String? phoneNo, 
      String? department, 
      String? district, 
      String? username, 
      String? password, 
      String? isAdmin, 
      String? adminUsername, 
      num? lat, 
      num? long, 
      num? v,}){
    _id = id;
    _name = name;
    _phoneNo = phoneNo;
    _department = department;
    _district = district;
    _username = username;
    _password = password;
    _isAdmin = isAdmin;
    _adminUsername = adminUsername;
    _lat = lat;
    _long = long;
    _v = v;
}

  User.fromJson(dynamic json) {
    _id = json['_id'];
    _name = json['name'];
    _phoneNo = json['phoneNo'];
    _department = json['department'];
    _district = json['district'];
    _username = json['username'];
    _password = json['password'];
    _isAdmin = json['isAdmin'];
    _adminUsername = json['adminUsername'];
    _lat = json['Lat'];
    _long = json['Long'];
    _v = json['__v'];
  }
  String? _id;
  String? _name;
  String? _phoneNo;
  String? _department;
  String? _district;
  String? _username;
  String? _password;
  String? _isAdmin;
  String? _adminUsername;
  num? _lat;
  num? _long;
  num? _v;
User copyWith({  String? id,
  String? name,
  String? phoneNo,
  String? department,
  String? district,
  String? username,
  String? password,
  String? isAdmin,
  String? adminUsername,
  num? lat,
  num? long,
  num? v,
}) => User(  id: id ?? _id,
  name: name ?? _name,
  phoneNo: phoneNo ?? _phoneNo,
  department: department ?? _department,
  district: district ?? _district,
  username: username ?? _username,
  password: password ?? _password,
  isAdmin: isAdmin ?? _isAdmin,
  adminUsername: adminUsername ?? _adminUsername,
  lat: lat ?? _lat,
  long: long ?? _long,
  v: v ?? _v,
);
  String? get id => _id;
  String? get name => _name;
  String? get phoneNo => _phoneNo;
  String? get department => _department;
  String? get district => _district;
  String? get username => _username;
  String? get password => _password;
  String? get isAdmin => _isAdmin;
  String? get adminUsername => _adminUsername;
  num? get lat => _lat;
  num? get long => _long;
  num? get v => _v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['name'] = _name;
    map['phoneNo'] = _phoneNo;
    map['department'] = _department;
    map['district'] = _district;
    map['username'] = _username;
    map['password'] = _password;
    map['isAdmin'] = _isAdmin;
    map['adminUsername'] = _adminUsername;
    map['Lat'] = _lat;
    map['Long'] = _long;
    map['__v'] = _v;
    return map;
  }

}