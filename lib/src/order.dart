class Order {
  final String uuid;

  Order(this.uuid);

  static Order from(data) {
    return Order(data["uuid"]);
  }
}