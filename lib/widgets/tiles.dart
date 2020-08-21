import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:user/Models/categorytitle.dart';

class Tiles extends StatelessWidget {
  final int index;
  Tiles(this.index);

  MainAxisAlignment mainAixsAlignment(bool isMedicine,String  title,int index){
    if (isMedicine && index!=5){
      return MainAxisAlignment.start;
    }
    else if(!isMedicine && index!=5){
      return MainAxisAlignment.end;
    }
    else{
      return MainAxisAlignment.center;
    }
  }
  @override
  Widget build(BuildContext context) {
    bool isMedicine = categoryItems[index].title=="Medicine"?true:false;
    return Card(
      elevation: 40,
      color: Colors.white,
        shadowColor: Colors.black,
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () {
            print('Card tapped.');
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20)
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: mainAixsAlignment(isMedicine,categoryItems[index].title,index),
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                index!=5?Image.asset(categoryItems[index].imgpath,height:isMedicine?170:130,width: isMedicine?170:130,):SizedBox(height:1,width:10),
                Text(isMedicine?categoryItems[index].title:"\n"+categoryItems[index].title,style: TextStyle(fontSize: 17,fontWeight: FontWeight.w800,color: Colors.black45)),
                isMedicine?SizedBox(height: 1,):SizedBox(height: 8,)
              ],
            )
          ),
        ),
    );
  }
}
