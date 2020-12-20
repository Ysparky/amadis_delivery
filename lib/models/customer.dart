class Customer {
  Customer({
    this.customerId,
    this.name,
    this.lastName,
    this.documentTypeId,
    this.document,
    this.contactNumber,
    this.birthdate,
  });

  final int customerId;
  final String name;
  final String lastName;
  final int documentTypeId;
  final String document;
  final String contactNumber;
  final DateTime birthdate;

  Customer copyWith({
    int customerId,
    String name,
    String lastName,
    int documentTypeId,
    String document,
    String contactNumber,
    DateTime birthdate,
  }) =>
      Customer(
        customerId: customerId ?? this.customerId,
        name: name ?? this.name,
        lastName: lastName ?? this.lastName,
        documentTypeId: documentTypeId ?? this.documentTypeId,
        document: document ?? this.document,
        contactNumber: contactNumber ?? this.contactNumber,
        birthdate: birthdate ?? this.birthdate,
      );

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        customerId: json['customerId'],
        name: json['name'],
        lastName: json['lastName'],
        documentTypeId: json['documentTypeId'],
        document: json['document'],
        contactNumber: json['contactNumber'],
        birthdate: DateTime.parse(json['birthdate']),
      );

  Map<String, dynamic> toJson() => {
        'customerId': customerId,
        'name': name,
        'lastName': lastName,
        'documentTypeId': documentTypeId,
        'document': document,
        'contactNumber': contactNumber,
        'birthdate':
            "${birthdate.year.toString().padLeft(4, '0')}-${birthdate.month.toString().padLeft(2, '0')}-${birthdate.day.toString().padLeft(2, '0')}",
      };
}
