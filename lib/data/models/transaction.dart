class Transaction {
  final String id;
  final DateTime date;
  final double amount;
  final String description;
  String? category;

  Transaction({
    required this.id,
    required this.date,
    required this.amount,
    required this.description,
    this.category,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'],
      date: DateTime.parse(json['date']),
      amount: json['amount'],
      description: json['description'],
      category: json['category'],
    );
  }
}