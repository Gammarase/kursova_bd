class User {
  late int userId;
  late String name;
  late String surname;
  late String patronymic;
  late String passportId;
  late String phone;
  late String email;
  late String password;

  User(
      {required this.userId,
      required this.name,
      required this.surname,
      required this.patronymic,
      required this.passportId,
      required this.phone,
      required this.email,
      required this.password});

  User.fromJson(Map<String, dynamic> json) {
    userId = int.parse(json['user_id']);
    name = json['name'];
    surname = json['surname'];
    patronymic = json['patronymic'];
    passportId = json['pasport_id'];
    phone = json['phone'];
    email = json['email'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId.toString();
    data['name'] = name;
    data['surname'] = surname;
    data['patronymic'] = patronymic;
    data['passport_id'] = passportId;
    data['phone'] = phone;
    data['email'] = email;
    data['password'] = password;
    return data;
  }
}


class Producer {
  late int producerId;
  late String name;
  late String description;
  late String location;
  late String contactPhone;

  Producer(
      {required this.producerId,
      required this.name,
      required this.description,
      required this.location,
      required this.contactPhone});

  Producer.fromJson(Map<String, dynamic> json) {
    producerId = int.parse(json['producer_id']);
    name = json['name'];
    description = json['description'];
    location = json['location'];
    contactPhone = json['contact_phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['producer_id'] = producerId.toString();
    data['name'] = name;
    data['description'] = description;
    data['location'] = location;
    data['contact_phone'] = contactPhone;
    return data;
  }
}


class Product {
  late int productId;
  late String name;
  late String dateOfReceipt;
  late String expirationDate;
  late int amount;
  late double price;
  late int madeOf;
  late int ownerId;

  Product(
      {required this.productId,
      required this.name,
      required this.dateOfReceipt,
      required this.expirationDate,
      required this.amount,
      required this.price,
      required this.madeOf,
      required this.ownerId});

  Product.fromJson(Map<String, dynamic> json) {
    productId = int.parse(json['product_id']);
    name = json['name'];
    dateOfReceipt = json['date_of_receipt'];
    expirationDate = json['expiration_date'];
    amount = int.parse(json['amount']);
    price = double.parse(json['price']);
    madeOf = int.parse(json['made_of']);
    ownerId = int.parse(json['owner_id']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_id'] = productId.toString();
    data['name'] = name;
    data['date_of_receipt'] = dateOfReceipt;
    data['expiration_date'] = expirationDate;
    data['amount'] = amount.toString();
    data['price'] = price.toString();
    data['made_of'] = madeOf.toString();
    data['owner_id'] = ownerId.toString();
    return data;
  }
}