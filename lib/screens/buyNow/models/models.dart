class OrderDetails {
  String productId;
  String totalAmount;
  String quantity;
  bool isDelievered;
  DateTime orderedTime;
  int delieveryCharge;
  String email;
  DateTime? delieveredTime;
  String? location;
  int phoneNum;

  OrderDetails(
      this.productId,
      this.totalAmount,
      this.quantity,
      this.isDelievered,
      this.orderedTime,
      this.delieveredTime,
      this.delieveryCharge,
      this.phoneNum,
      this.location,this.email);

  static Map<String, dynamic> toMap(OrderDetails orderDetails) {
    return {
      "productId": orderDetails.productId,
      "totalAmount": orderDetails.totalAmount,
      "quantity": orderDetails.quantity,
      "isDelievered": orderDetails.isDelievered,
      "orderedTime": orderDetails.orderedTime,
      "delieveredTime": orderDetails.delieveredTime,
      "delieveryCharge": orderDetails.delieveryCharge,
      "location": orderDetails.location
    };
  }
}
