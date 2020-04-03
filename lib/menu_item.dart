class MenuItem {
  String type;
  String group;
  int priority;
  int categoryId;
  String categoryName;
  String categoryIcon;
  int categorySize;
  // List<Service> serviceProducts;

  MenuItem({
    this.type,
    this.group,
    this.priority,
    this.categoryId,
    this.categoryName,
    this.categoryIcon,
    this.categorySize,
    // this.serviceProducts,
  });

  factory MenuItem.fromJson(Map<String, dynamic> parsedJson) {
    // var serviceProducts = parsedJson['service_products'] as List;
   // return parsedJson.map<MenuItem>((json)=>MenuItem.fromJson(json)).toList();
    return MenuItem(
      type: parsedJson['type'],
      group: parsedJson['group'],
      priority: parsedJson['priority'],
      categoryId: parsedJson['category_id'],
      categoryName: parsedJson['category_name'],
      categoryIcon: parsedJson['category_icon'] ??
          'https://firebasestorage.googleapis.com/v0/b/okbabe-production-cluster.appspot.com/o/assets%2Fmenu_icon%2FPulsa%20Ponsel%20line.png?alt=media&token=fbfbb569-9263-430c-89b2-2ddf80762157',
      categorySize: parsedJson['category_size'],
      // serviceProducts: serviceProducts.map((i) => Service.fromJson(i)).toList(),
    );
 }
}

class Service {
  int id;
  String name;
  String icon;
  String type;
  String endpointUrl;
  String prodCode;

  Service({
    this.id,
    this.name,
    this.icon,
    this.type,
    this.endpointUrl,
    this.prodCode,
  });

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      id: json['id'],
      name: json['name'],
      icon: json['icon'],
      type: json['type'],
      endpointUrl: json['endpoint_url'],
      prodCode: json['prod_code'],
    );
  }
}
