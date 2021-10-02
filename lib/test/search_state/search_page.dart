class SearchHistory {
  int _id=0;
  String _name='';
  String _time='';
  SearchHistory();
  int get id => _id;

  String get name => _name;

  String get time => _time;

  set time(String value) {
    _time = value;
  }

  set name(String value) {
    _name = value;
  }

  set id(int value) {
    _id = value;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    map['id'] = _id;
    map['name'] = _name;
    map['time'] = _time;

    return map;
  }

  SearchHistory.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._name = map['name'];
    this._time = map['time'];
  }

  @override
  String toString() {
    return '${this.name} ${this.id} ${this.time}';
  }
}
