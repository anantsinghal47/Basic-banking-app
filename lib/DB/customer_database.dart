import 'package:banking_app/model/customer.dart';
import 'package:banking_app/model/transactionModel.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class CustomerDatabase {
  static final CustomerDatabase instance = CustomerDatabase._init();
  static Database? _database;

  CustomerDatabase._init();

  //first of all we have to open the database
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('customers.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  //creating database schema
  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';
    final doubleType = 'DOUBLE NOT NULL';
    await db.execute('''
  
  CREATE TABLE $tableCustomers (
    ${CustomerFields.id} $idType,
    ${CustomerFields.name} $textType,
    ${CustomerFields.email} $textType,
    ${CustomerFields.balance} $doubleType,
    ${CustomerFields.time} $textType
   )
''');

    await db.execute('''
  
  CREATE TABLE $tableTransaction(
    ${TransactionFields.id} $idType,
    ${TransactionFields.name} $textType,
    ${TransactionFields.email} $textType,
    ${TransactionFields.balance} $doubleType,
    ${TransactionFields.time} $textType
   )
''');
  }

  Future<Customer> create(Customer customer) async {
    final db = await instance.database;
    final id = await db.insert(tableCustomers, customer.toJson());
    return customer.copy(id: id);
  }

  Future<Customer> readCustomer(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableCustomers,
      columns: CustomerFields.values,
      where: '${CustomerFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Customer.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Customer>> readAllCustomers() async {
    final db = await instance.database;
    final orderBy = '${CustomerFields.time} ASC';
    final result = await db.query(tableCustomers, orderBy: orderBy);
    return result.map((json) => Customer.fromJson(json)).toList();
  }

  Future<int> update(Customer customer) async {
    final db = await instance.database;
    return db.update(
      tableCustomers,
      customer.toJson(),
      where: '${CustomerFields.id} = ?',
      whereArgs: [customer.id],
    );
  }

  Future<void> deleteUser(int id) async {
    final db = await instance.database;
    await db.delete(
      '$tableCustomers',
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<int> delete() async {
    final db = await instance.database;
    return await db.delete(tableCustomers);
  }

// closing the database
  Future close() async {
    final db = await instance.database;
    db.close();
  }

  //for transactions

  Future<Transactions> createTransaction(Transactions transactions) async {
    final db = await instance.database;
    final id = await db.insert(tableTransaction, transactions.toJson());
    return transactions.copy(id: id);
  }

  Future<Transactions> readTransaction(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableTransaction,
      columns: TransactionFields.values,
      where: '${TransactionFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Transactions.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Transactions>> readAllTransactions() async {
    final db = await instance.database;
    final orderBy = '${TransactionFields.time} DESC';
    final result = await db.query(tableTransaction, orderBy: orderBy);
    return result.map((json) => Transactions.fromJson(json)).toList();
  }

  Future<int> updateTransaction(Transactions transactions) async {
    final db = await instance.database;
    return db.update(
      tableTransaction,
      transactions.toJson(),
      where: '${TransactionFields.id} = ?',
      whereArgs: [transactions.id],
    );
  }

  Future<int> deleteTransactions() async {
    final db = await instance.database;
    return await db.delete(tableTransaction);
  }

// closing the database
  Future closeTransaction() async {
    final db = await instance.database;
    db.close();
  }
}
