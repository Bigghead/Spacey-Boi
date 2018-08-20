import 'package:scoped_model/scoped_model.dart';

class GalleryData extends Model {

  Map _gallery = {};


  bool hasData( String date ) {
    return _gallery[date] == null ? false : true;
  }

  
  void addData( String date, Map data ) {
    _gallery[date] = data;
  }


  getData( String date ) {
    return Map.from(_gallery[date]);
  }
}