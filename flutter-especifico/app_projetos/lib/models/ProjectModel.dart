class Project {
  String id;
  String managerId;
  String name;
  bool delivered;
  DateTime deliverDate;
  int membersQuantity;

  Project({
    required this.id,
    required this.managerId,
    required this.name,
    required this.deliverDate,
    required this.delivered,
    required this.membersQuantity,
  });

  Project.fromJson(Map data)
      : this(
          id: data['id'],
          managerId: data['managerId'],
          name: data['name'],
          deliverDate: DateTime.parse(data['deliverDate']),
          delivered: data['delivered'],
          membersQuantity: data['membersQuantity'],
        );

  Map toJson() {
    return {
      'id': id,
      'managerId': managerId,
      'name': name,
      'deliverDate': deliverDate.toString(),
      'delivered': delivered,
      'membersQuantity': membersQuantity,
    };
  }
}
