import 'package:auth_app/Work/PostData.dart';
import 'package:auth_app/common.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../GET/controller.dart';
import '../Work/Calulate distance.dart';
import '../Work/Tree.dart';

Future<List<Pair<double, postData>>> PostIds(String Cuid) async {
  //List<Pair<String, double>> userIds = [];
  List<Pair<double,postData>> posts=[];
  List<Pair<double,postData>> pp=[];
  List<String> postseen=[];
  //List<String>pp=[];
  int count=0;
  try{
    CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');
    QuerySnapshot querySnapshot = await usersCollection.where('userId', isEqualTo: Cuid).get();
    if (querySnapshot.docs.isNotEmpty) {
      DocumentSnapshot document = querySnapshot.docs.first;
      Map<String, dynamic> userData = (await document.data()) as Map<String, dynamic>;
      postseen=List<String>.from(userData['PostSeen']);
    }
  }catch(e){
    print("ERROR AT THE TIME OF POSTSEEN $e");

  }

  try {
    final Controller cont = Get.find();
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('post').get();


    for (QueryDocumentSnapshot doc in querySnapshot.docs) {

      String userId = doc.id;
      print(userId);
      int index=postseen.indexOf(userId);
      //print('p1                          p1                            p1');
      if(index==-1){
        //pp.add(userId);
        //print('p1                          p1                            p1');
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        //print('p1                          p1                            p1');
        String name=data['name'];
        String dt=data['data'];
        //print('p1                          p1                            p1');
        //String dT=data['TimeStamp'];

        String DT='10-10-10';
        double dis = calculateDistance(cont.lt.latitude, cont.lt.longitude, data['lat'], data['lang']);
        String img='https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png';
        print(img);
        if(data['image']!=null){

          img=data['image'];
        }
        print(img);
        String uid = data['userId'];
        //print('p1                          p1                            p1');
        postData po=postData(userId, name, DT, dt,img,uid);

        posts.add(Pair(dis, po));
        //print('p1                          p1                            p1');

      }

    }
    posts.sort((a, b) => a.first.compareTo(b.first));
    print('4333333333333333333333                333333333333333333333333                 3333333333333333 ');
    int fd=7;
    if(posts.length<7){
      fd=posts.length;
    }
    for(int i=0;i<fd;i++){
      String ud=posts[i].second.Uid;
      postseen.add(ud);
      pp.add(posts[i]);
    }
    print('4333333333333333333333                333333333333333333333333                 3333333333333333 ');
    print(postseen);
    cont.postseen=postseen;
    print('4333333333333333333333                333333333333333333333333                 3333333333333333 ');
    try{
      DocumentReference docRef = FirebaseFirestore.instance.collection('users').doc(cont.CusID);
      docRef.set({
        'PostSeen':postseen
      },SetOptions(merge: true));
    }catch(e){
        print('4333333333333333333333                333333333333333333333333                 3333333333333333 ');
    }
    //userIds.sort((a, b) => a.second.compareTo(b.second));
  } catch (e) {
    print('Error fetching user IDs in post: $e');
  }

  return pp;
}