class vendorValue {
  static String restaurantName = "";
  static String location = "";
  static String mall = "";
  static String unit_number = "";
  static String email = "";
  static void setString(
      {required String restaurantName1,
      required String location1,
      required String mall1,
      required String unitNum1,
      required String email1}) {
    restaurantName = restaurantName1;
    location = location1;
    mall = mall1;
    unit_number = unitNum1;
    email = email1;
  }

  static String getRestaurantName() {
    return restaurantName;
  }

  static String getLocation() {
    return location;
  }

  static String getMall() {
    return mall;
  }

  static String getUnitNum() {
    return unit_number;
  }

  static String getEmail() {
    return email;
  }
}
