class TaskStatusCountModel {
  String? _status;
  List<Data>? _data;

  TaskStatusCountModel({String? status, List<Data>? data}) {
    if (status != null) {
      _status = status;
    }
    if (data != null) {
      _data = data;
    }
  }

  String? get status => _status;
  set status(String? status) => _status = status;
  List<Data>? get data => _data;
  set data(List<Data>? data) => _data = data;

  TaskStatusCountModel.fromJson(Map<String, dynamic> json) {
    _status = json['status'];
    if (json['data'] != null) {
      _data = <Data>[];
      json['data'].forEach((v) {
        _data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = _status;
    if (_data != null) {
      data['data'] = _data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? _sId;
  int? _sum;

  Data({String? sId, int? sum}) {
    if (sId != null) {
      _sId = sId;
    }
    if (sum != null) {
      _sum = sum;
    }
  }

  String? get sId => _sId;
  set sId(String? sId) => _sId = sId;
  int? get sum => _sum;
  set sum(int? sum) => _sum = sum;

  Data.fromJson(Map<String, dynamic> json) {
    _sId = json['_id'];
    _sum = json['sum'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = _sId;
    data['sum'] = _sum;
    return data;
  }
}
