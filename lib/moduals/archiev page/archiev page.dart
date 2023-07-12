import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/cubit/cubit.dart';
import '../../shared/cubit/states.dart';
class archiev extends StatelessWidget {
  const archiev({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,Appstate>(
      listener: (BuildContext context,Appstate state) {

      },
      builder: (BuildContext context,Appstate state) {
        var task = AppCubit.get(context).archevtask ;
        if(task.isNotEmpty){
        return ListView.separated(
            itemBuilder: (context, index) =>ListTile(
              leading: CircleAvatar(
                radius: 31,

                child: Text('${task[index]['time']}',style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold)),),
              title:Text('${task[index]['title']}'),
              subtitle: Text('${task[index]['date']}'),
              trailing: Container(
                width: 150,
                child: Row(
                  children: [
                    IconButton(onPressed: (){
                      AppCubit.get(context).updateData(status: 'archive', ID: task[index]['id']);
                    }, icon: Icon(Icons.archive)),
                    IconButton(onPressed: (){
                      AppCubit.get(context).updateData(status: 'done' , ID: task[index]['id']);
                    }, icon: Icon(Icons.check_box_rounded,color: Colors.green,)),
                    IconButton(onPressed: (){
                      AppCubit.get(context).dleteData(ID: task[index]['id']);
                    }, icon: Icon(Icons.delete,color: Colors.red,))
                  ],
                ),
              ),
            ),
            separatorBuilder: (context, index) => Container(
              width: double.infinity,
              color: Colors.black45,
              height: 1,
            ),
            itemCount: task.length);
        }else{
          return Center(child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
            Icon(Icons.dangerous_outlined,size: 300,color: Colors.grey[300],),
                Text('Archiev Tasks is Empty',style: TextStyle(
                  color: Colors.grey[300],
                  fontSize: 30
                ),)
                
          ]),);
        }
      }, );






  }}
