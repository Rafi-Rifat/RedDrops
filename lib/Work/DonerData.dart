import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../Databases/TakeData.dart';

class DonerData {
  final String Uid;
  final String name;
  final String email;
  final String bl;
  final bool IsOnline = false;
  final String img;
  final DonerLatLang;

  const DonerData(this.Uid, this.name,this.DonerLatLang, this.email, this.bl, this.img);
}

Future<DonerData> peopleToDoner(String uid) async {
  try {
    Map<String, dynamic> data = await getUserData(uid) as Map<String, dynamic>;
    String name = data['name'];
    LatLng lt=LatLng(data['lat'], data['lang']);
    String em=data['email'];
    String bl=data['bl'];
    String img='images/blood.jpg';
    if(data['image']!=null){
      img=data['image'];
    }
    DonerData d = DonerData(uid, name,lt,em,bl,img);
    return d;
  } catch (error) {
    print('Error: $error');
    throw Exception('Error: $error');
  }
}

// Example of how to use the async function:
