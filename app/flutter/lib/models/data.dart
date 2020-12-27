class Data {
  final roles = {-1: 'User', 0: 'Root', 1: 'Admin'};

  final int role;
  String roleName;

  Data({this.role}) {
    roleName = roles[role];
  }
}
