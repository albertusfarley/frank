class Role {
  final Map<int, String> roles = {
    -2: 'Unknown',
    -1: 'User',
    0: 'Root',
    1: 'Admin'
  };

  final List<int> roleUnderAdmin = [-2, -1];
  final List<int> roleUnderRoot = [-2, -1, 0, 1];

  var codes = {};

  Role() {
    roles.map((k, v) => MapEntry(v, k));
  }

  getName(int role) {
    return roles[role];
  }

  getCode(String name) {
    int code =
        roles.keys.firstWhere((k) => roles[k] == name, orElse: () => null);
    print(code);
    return code;
  }

  getRoles() {
    return roles;
  }

  List<int> getAllCodes() {
    return roles.keys.toList();
  }

  List<String> getAllNames() {
    return roles.values.toList();
  }

  List<String> getAllNamesByRole(int role) {
    List<int> roles = [];
    List<String> roleNames = [];
    if (role == 0)
      roles = roleUnderRoot;
    else if (role == 1) roles = roleUnderAdmin;

    for (var role in roles) {
      roleNames.add(getName(role));
    }
    print('1337 ' + roleNames.toString());
    return roleNames;
  }
}
