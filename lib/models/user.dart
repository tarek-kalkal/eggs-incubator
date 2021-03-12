class User {

  
  int _phonenbr;  // phone number
  String _name;  // name
  String _password;  // password

  User(this._name, this._password, [this._phonenbr]);

  User.withphonenbr(this._phonenbr, this._name, this._password);

  int get phonenbr => _phonenbr;

  String get name => _name;


  String get password => _password;


  set name(String newname) {
    if (newname.length <= 255) {
      this._name = newname;
    }
  }

  

  set password(String newpassword) {
    this._password = newpassword;
  }

  // Convert a User object into a Map object
  Map<String, dynamic> toMap() {

    var map = Map<String, dynamic>();
    if (phonenbr != null) {
      map['phonenbr'] = _phonenbr;
    }
    map['name'] = _name;
    map['password'] = _password;

    return map;
  }

  // Extract a User object from a Map object
  User.fromMapObject(Map<String, dynamic> map) {
    this._phonenbr = map['phonenbr'];
    this._name = map['name'];
    this._password = map['password'];
  }
}