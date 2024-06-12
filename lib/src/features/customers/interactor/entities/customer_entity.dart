class CustomerEntity {
  final String? id;
  final String name;
  final String cnpj;
  final String adress;
  final String email;
  final String phoneNumber;

  const CustomerEntity({
    this.id,
    required this.name,
    required this.cnpj,
    required this.adress,
    required this.email,
    required this.phoneNumber,
  });

  CustomerEntity copyWith({
    String? id,
    String? name,
    String? cnpj,
    String? adress,
    String? email,
    String? phoneNumber,
    List<String>? orderIds,
  }) {
    return CustomerEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      cnpj: cnpj ?? this.cnpj,
      adress: adress ?? this.adress,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }
}
