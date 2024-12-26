class FlagMode {
  String? code;
  String? name;
  String? country;
  String? countryCode;
  String? flag;

  FlagMode({this.code, this.name, this.country, this.countryCode, this.flag});

  FlagMode.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    name = json['name'];
    country = json['country'];
    countryCode = json['countryCode'];
    flag = json['flag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['name'] = this.name;
    data['country'] = this.country;
    data['countryCode'] = this.countryCode;
    data['flag'] = this.flag;
    return data;
  }
}
