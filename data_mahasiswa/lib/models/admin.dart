class Admin{

  int _id;
  String _name;
  String _username;
  String _password;

  Admin(this._name, this._username, this._password);

  //SETTER
  Admin.fromMap(Map<String, dynamic> map){
    this._id = map['id'];
    this._name = map['name'];
    this._username = map['username'];
    this._password = map['password'];
  }

  //GETTER
  Map<String, dynamic> toMap(){
    var map = Map<String, dynamic>();
    if(_id != null){
      map['id'] = _id;
    }
    map['name'] = _name;
    map['username'] = _username;
    map['password'] = _username;
    return map;
  }

  //GETTER
  String get password => _password;
  String get username => _username;
  String get name => _name;
  int get id => _id;


}