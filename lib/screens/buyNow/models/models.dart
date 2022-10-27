import 'package:herb/screens/Homepage/firebase/firebase.dart';

class OrderDetails {
  String productId;
  String totalAmount;
  String quantity;
  bool isDelievered;
  DateTime orderedTime;
  String delieveryCharge;
  String email;
  DateTime? delieveredTime;
  String? location;
  String? phoneNum;
  String? id;

  OrderDetails(
      this.productId,
      this.totalAmount,
      this.quantity,
      this.isDelievered,
      this.orderedTime,
      this.delieveredTime,
      this.delieveryCharge,
      this.phoneNum,
      this.location,
      this.email,this.id);

  static Map<String, dynamic> toMap(OrderDetails orderDetails) {
    return {
      "productId": orderDetails.productId,
      "totalAmount": orderDetails.totalAmount,
      "quantity": orderDetails.quantity,
      "isDelievered": orderDetails.isDelievered,
      "orderedTime": orderDetails.orderedTime,
      "delieveredTime": orderDetails.delieveredTime,
      "delieveryCharge": orderDetails.delieveryCharge,
      "location": orderDetails.location,
      "phoneNumber": orderDetails.phoneNum
    };
  }

  static OrderDetails fromMap(snap, id) {
    return OrderDetails(
      snap["productId"],
      snap["totalAmount"],
      snap["quantity"],
      snap["isDelievered"],
      snap["orderedTime"].toDate(),
      null,
      snap["delieveryCharge"].toString(),
      snap["phoneNumber"],
      snap["location"],
      "",
      id
    );
  }
}
