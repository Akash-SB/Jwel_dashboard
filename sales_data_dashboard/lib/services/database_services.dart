import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseService {
  static Database? _db;

  static Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDB();
    return _db!;
  }

  static Future<Database> _initDB() async {
    final path = join(await getDatabasesPath(), 'management.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  static Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE products(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        hsnCode TEXT,
        prodName TEXT,
        size TEXT,
        carat TEXT,
        rate TEXT,
        amount TEXT,
        description TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE customers(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        custName TEXT,
        mobileNumber TEXT,
        gstNumber TEXT,
        usertype TEXT,
        address TEXT,
        daysOfInterest INTEGER
      )
    ''');

    await db.execute('''
      CREATE TABLE invoices(
        invoiceId TEXT PRIMARY KEY,
        date TEXT,
        carat TEXT,
        rate TEXT,
        amount TEXT,
        productIds TEXT,
        transactionType TEXT,
        custType TEXT,
        custName TEXT,
        paymentStatus TEXT,
        paymentType TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE ledger(
        ledgerId TEXT PRIMARY KEY,
        customerId TEXT,
        invoiceId TEXT,
        date TEXT,
        transactionType TEXT,
        amount REAL,
        paymentType TEXT,
        note TEXT
      )
    ''');
  }

  Future<Database> getNotfDatabase() async {
    final dbPath = await databaseFactory.getDatabasesPath();
    final path = join(dbPath, 'app_database.db');

    return databaseFactory.openDatabase(path,
        options: OpenDatabaseOptions(
          version: 1,
          onCreate: (db, version) async {
            await db.execute('''
        CREATE TABLE notifications(
          id TEXT PRIMARY KEY,
          invoiceId TEXT,
          userId TEXT,
          message TEXT,
          notifyDate TEXT,
          isRead INTEGER
        )
      ''');
          },
        ));
  }
}
