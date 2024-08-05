class RouterItem {
  final String path;
  final String name;
  RouterItem({
    required this.path,
    required this.name,
  });

  static final RouterItem loginRoute =
      RouterItem(path: '/login', name: 'login');
     
  static final RouterItem dashboardRoute =
      RouterItem(path: '/dashboard', name: 'dashboard');
  static final RouterItem locationsRoute =
      RouterItem(path: '/locations', name: 'locations');
  static final RouterItem emergenciesRoute =
      RouterItem(path: '/emergencies', name: 'emergencies');
      static final RouterItem contactsRoute =
      RouterItem(path: '/contacts', name: 'contacts');
static List<RouterItem> allRoutes = [
    loginRoute,
    dashboardRoute,
    locationsRoute,
    emergenciesRoute,
    contactsRoute,
  ];

  static RouterItem getRouteByPath(String fullPath) {
    return allRoutes.firstWhere((element) => element.path == fullPath);
  }
}
