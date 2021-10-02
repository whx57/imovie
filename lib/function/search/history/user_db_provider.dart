import 'base_db_provider.dart';
import 'search_history.dart';
import 'package:sqflite/sqlite_api.dart';

class SearchHistoryProvider extends BaseDbProvider {
  ///表名
  final String name = 'UserInfo';

  final String columnId = "id";
  final String columnName = "name";
  final String columnTime = "time";

  //获取表名称
  @override
  tableName() {
    return name;
  }

  //创建表操作
  @override
  createTableString() {
    return '''
        create table $name (
        $columnId integer primary key autoincrement,$columnName text unique not null,
        $columnTime text not null)
      ''';
  }

  ///查询数据
  Future selectUser(int id) async {
    Database db = await getDataBase();
    return await db.rawQuery("select * from $name where $columnId = $id");
  }

  //查询数据库所有
  Future<List<Map<String, dynamic>>> selectMapList() async {
    var db = await getDataBase();
    var result = await db.query(name);
    return result;
  }

  //获取数据库里所有user
  Future<List<SearchHistory>> getAllUser() async {
    var userMapList = await selectMapList();
    var count = userMapList.length;
    List<SearchHistory> userList = [];

    for (int i = 0; i < count; i++) {
      userList.add(SearchHistory.fromMapObject(userMapList[i]));
    }
    return userList;
  }

  //根据id查询user
  Future<SearchHistory> getUser(int id) async {
    var noteMapList = await selectUser(id); // Get 'Map List' from database
    var user = SearchHistory.fromMapObject(noteMapList[id]);
    return user;
  }

  //增加数据
  Future<int> insertUser(SearchHistory user) async {
    // var db = await getDataBase();
    // var result = await db.insert(name, user.toMap());
    // return result;
    var db = await getDataBase();
    try {
      user.id = await db.insert(name, user.toMap());
    } catch (e) {}
    return user.id;
  }

  //更新数据
  Future<int> update(SearchHistory user) async {
    var database = await getDataBase();
    var result = await database.rawUpdate(
        "update $name set $columnName = ?,$columnTime = ? where $columnId= ?",
        [user.name, user.time, user.id]);
    return result;
  }

  //删除数据
  Future<int> deleteUser(int id) async {
    var db = await getDataBase();
    var result = await db.rawDelete('DELETE FROM $name WHERE $columnId = $id');
    return result;
  }

  Future<int> deleteAll() async {
    var db = await getDataBase();
    var res = await db.rawDelete('DELETE FROM $name');
    return res;
  }
}
