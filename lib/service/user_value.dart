class userValue {
  static String userName = "";
  static String userEmail = "";
  static String password = "";
  static String phoneNum = "";

  static void setString({
    required String userName1,
    required String userEmail1,
    required String password1,
    required String phoneNum1,
  }) {
    userName = userName1;
    userEmail = userEmail1;
    password = password1;
    phoneNum = phoneNum1;
  }

  static String getUserName() {
    return userName;
  }

  static String getEmail() {
    return userEmail;
  }

  static String getPassword() {
    return password;
  }

  static String getPhoneNum() {
    return phoneNum;
  }
}
