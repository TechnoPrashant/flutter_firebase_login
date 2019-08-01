class UserBean {
  String fullname;
  String emailAddress;
  String phoneNumber;
  String profilPic;
  bool isSuccess;
  String uid;
  String loginProvide;

  UserBean.name(this.fullname, this.emailAddress, this.phoneNumber,
      this.profilPic, this.isSuccess, this.uid, this.loginProvide);

  UserBean(this.fullname, this.emailAddress, this.phoneNumber, this.profilPic,
      this.isSuccess, this.uid, this.loginProvide);
}
