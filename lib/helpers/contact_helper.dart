import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

final String contactTable = "contactTable";
final String idColumn = "idColumn";
final String nameColumn = "nameColumn";
final String emailColumn = "emailColumn";
final String numberColumn = "numberColumn";
final String imgColumn = "imgColumn";

class ContactHelper {
  static final ContactHelper _instance = ContactHelper.internal();

  factory ContactHelper() => _instance;

  ContactHelper.internal();

  Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    } else {
      _db = await initDb();
    }
  }

  Future<Database> initDb() async {
    final dataBasePath = await getDatabasesPath();
    final path = join(dataBasePath, "contacts.db");

    return await openDatabase(path, version: 1,
        onCreate: (Database db, int newerVersion) async {
      await db
          .execute("CREATE TABLE $contactTable ($idColumn INTEGER PRIMARY KEY,"
              "$nameColumn TEXT,"
              "$emailColumn TEXT,"
              "$numberColumn TEXT,"
              "$imgColumn TEXT)");
    });
  }
}

class Contact {
  int id;
  String name;
  String email;
  String number;
  String img;

  Contact.fromMap(Map map) {
    id = map[idColumn];
    name = map[nameColumn];
    email = map[emailColumn];
    number = map[numberColumn];
    img = map[imgColumn];
  }

  Map toMap() {
    Map<String, dynamic> map = {
      nameColumn: name,
      emailColumn: email,
      numberColumn: number,
      imgColumn: img
    };
    if (id != null) map[idColumn] = id;

    return map;
  }

  @override
  String toString() {
    return "Contact(id: $id , name: $number ,email: $email ,number: $number ,img: $img )";
  }
}
