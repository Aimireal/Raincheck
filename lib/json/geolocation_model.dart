/*
class GeolocationModel {
  String name;
  LocalNames localNames;
  double lat;
  double lon;
  String country;

  GeolocationModel(
    {
      this.name = "", 
      this.localNames, 
      this.lat = 0.0, 
      this.lon = 0.0, 
      this.country = "",
    }
  );

  GeolocationModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    localNames = (json['local_names'] != null
        ? new LocalNames.fromJson(json['local_names'])
        : null)!;
    lat = json['lat'];
    lon = json['lon'];
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    if (this.localNames != null) {
      data['local_names'] = this.localNames.toJson();
    }
    data['lat'] = this.lat;
    data['lon'] = this.lon;
    data['country'] = this.country;
    return data;
  }
}

class LocalNames {
  String ar;
  String ascii;
  String az;
  String bg;
  String de;
  String el;
  String en;
  String fa;
  String featureName;
  String fi;
  String fr;
  String he;
  String id;
  String ja;
  String lt;
  String mk;
  String nl;
  String no;
  String pl;
  String ro;
  String ru;
  String sr;
  String tr;

  LocalNames(
    {
      this.ar,
      this.ascii,
      this.az,
      this.bg,
      this.de,
      this.el,
      this.en,
      this.fa,
      this.featureName,
      this.fi,
      this.fr,
      this.he,
      this.id,
      this.ja,
      this.lt,
      this.mk,
      this.nl,
      this.no,
      this.pl,
      this.ro,
      this.ru,
      this.sr,
      this.tr
    }
  );

  LocalNames.fromJson(Map<String, dynamic> json) {
    ar = json['ar'];
    ascii = json['ascii'];
    az = json['az'];
    bg = json['bg'];
    de = json['de'];
    el = json['el'];
    en = json['en'];
    fa = json['fa'];
    featureName = json['feature_name'];
    fi = json['fi'];
    fr = json['fr'];
    he = json['he'];
    id = json['id'];
    ja = json['ja'];
    lt = json['lt'];
    mk = json['mk'];
    nl = json['nl'];
    no = json['no'];
    pl = json['pl'];
    ro = json['ro'];
    ru = json['ru'];
    sr = json['sr'];
    tr = json['tr'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ar'] = this.ar;
    data['ascii'] = this.ascii;
    data['az'] = this.az;
    data['bg'] = this.bg;
    data['de'] = this.de;
    data['el'] = this.el;
    data['en'] = this.en;
    data['fa'] = this.fa;
    data['feature_name'] = this.featureName;
    data['fi'] = this.fi;
    data['fr'] = this.fr;
    data['he'] = this.he;
    data['id'] = this.id;
    data['ja'] = this.ja;
    data['lt'] = this.lt;
    data['mk'] = this.mk;
    data['nl'] = this.nl;
    data['no'] = this.no;
    data['pl'] = this.pl;
    data['ro'] = this.ro;
    data['ru'] = this.ru;
    data['sr'] = this.sr;
    data['tr'] = this.tr;
    return data;
  }
}
*/