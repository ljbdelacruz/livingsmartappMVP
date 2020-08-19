


class DeliveryService{

  static DeliveryService instance = DeliveryService();

  double getProgressStatus(String status){
    switch(status){
      case "pending":
        return 0.1;
      case "processing":
        return 0.2;
      case "for pickup":
        return 0.5;
      case "for delivery":
        return 0.8;
      case "delivered":
        return 1;
      default:
        return 0.0;
    }
  }
  int getIntDataByStatus(String status){
        switch(status){
      case "pending":
        return 1;
      case "processing":
        return 2;
      case "for pickup":
        return 3;
      case "for delivery":
        return 4;
      case "delivered":
        return 5;
      default:
        return 1;
    }
  }

}