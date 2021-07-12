
final String tableCustomers = 'customers';

class CustomerFields {
  static final List<String> values = [id, name, balance, time];
  static final String id = '_id';
  static final String name = 'name';
  static final String balance = 'balance';
  static final String email = 'email';
  static final String time = 'time';
}

class Customer {
  final int? id;
  final String name;
  final String email;
  final double balance;
  final DateTime createdTime;

  const Customer({
    this.id,
    required this.name,
    required this.email,
    required this.balance,
    required this.createdTime,
  });

  Customer copy(
          {int? id, String? name, double? balance, DateTime? createdTime , String? email}) =>
      Customer(
          id: id ?? this.id,
          name: name ?? this.name,
          email: email ?? this.email,
          balance: balance ?? this.balance,
          createdTime: createdTime ?? this.createdTime);

  static Customer fromJson(Map<String, Object?> json) => Customer(
      id: json[CustomerFields.id] as int?,
      name: json[CustomerFields.name] as String,
      email: json[CustomerFields.email] as String,
      balance: json[CustomerFields.balance] as double,
      createdTime: DateTime.parse(json[CustomerFields.time] as String));

  Map<String, Object?> toJson() => {
        CustomerFields.id: id,
        CustomerFields.name: name,
        CustomerFields.email: email,
        CustomerFields.balance: balance,
        CustomerFields.time: createdTime.toIso8601String(),
      };
}


