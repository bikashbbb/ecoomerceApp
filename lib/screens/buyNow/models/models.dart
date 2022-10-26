class OrderDetails {
  String productId;
  String totalAmount;
  String quantity;
  bool isDelievered;
  DateTime orderedTime;
  int delieveryCharge;
  DateTime? delieveredTime;
  int phoneNum;

  OrderDetails(
      this.productId,
      this.totalAmount,
      this.quantity,
      this.isDelievered,
      this.orderedTime,
      this.delieveredTime,
      this.delieveryCharge,this.phoneNum);

  static Map<String, dynamic> toMap(OrderDetails orderDetails) {
    return {
      "productId": orderDetails.productId,
      "totalAmount": orderDetails.totalAmount,
      "quantity": orderDetails.quantity,
      "isDelievered": orderDetails.isDelievered,
      "orderedTime": orderDetails.orderedTime,
      "delieveredTime": orderDetails.delieveredTime,
      "delieveryCharge": orderDetails.delieveryCharge
    };
  }
}
