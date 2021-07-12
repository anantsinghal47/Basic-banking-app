

final String tableTransaction = 'transactions';

class TransactionFields {
  static final List<String> values = [id, name, balance, time];
  static final String id = '_id';
  static final String name = 'name';
  static final String balance = 'balance';
  static final String email = 'email';
  static final String time = 'time';
}

class Transactions {
  final int? id;
  final String name;
  final String email;
  final double balance;
  final DateTime createdTime;

  const Transactions({
    this.id,
    required this.name,
    required this.email,
    required this.balance,
    required this.createdTime,
  });

  Transactions copy(
      {int? id, String? name, double? balance, DateTime? createdTime , String? email}) =>
      Transactions(
          id: id ?? this.id,
          name: name ?? this.name,
          email: email ?? this.email,
          balance: balance ?? this.balance,
          createdTime: createdTime ?? this.createdTime);

  static Transactions fromJson(Map<String, Object?> json) => Transactions(
      id: json[TransactionFields.id] as int?,
      name: json[TransactionFields.name] as String,
      email: json[TransactionFields.email] as String,
      balance: json[TransactionFields.balance] as double,
      createdTime: DateTime.parse(json[TransactionFields.time] as String));

  Map<String, Object?> toJson() => {
    TransactionFields.id: id,
    TransactionFields.name: name,
    TransactionFields.email: email,
    TransactionFields.balance: balance,
    TransactionFields.time: createdTime.toIso8601String(),
  };
}



