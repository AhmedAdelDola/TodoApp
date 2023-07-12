import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todoapp/shared/componantes/componants.dart';
import 'package:todoapp/shared/cubit/cubit.dart';
import 'package:todoapp/shared/cubit/states.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
 var Scaffoldkey = GlobalKey<ScaffoldState>();
 var formdkey = GlobalKey<FormState>();
 var tasktitle = TextEditingController() ;
 var time = TextEditingController() ;
 var date = TextEditingController() ;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (BuildContext context) => AppCubit()..creatdatabase(),
        child: BlocConsumer<AppCubit,Appstate>(
            listener: (BuildContext context,Appstate state) {},
            builder: (BuildContext context,Appstate state) {
              return Scaffold(
                key: Scaffoldkey,
                floatingActionButton:FloatingActionButton(
                  child: AppCubit.get(context).open?  Icon(Icons.edit):Icon(Icons.add)  ,
                  onPressed: () {
                    if(AppCubit.get(context).open == true){
                      Scaffoldkey.currentState?.showBottomSheet(
                              (context) => Container(
                            height: 300,width: double.infinity,color: Colors.blue,
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Form(
                                    key: formdkey,
                                    child: SingleChildScrollView(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          myTextFormField(
                                              ontap: (){},
                                              Controller: tasktitle,
                                              icon: Icon(Icons.note_add),
                                              label: 'title', type: TextInputType.text),
                                          SizedBox(height: 20,),
                                          myTextFormField(
                                              ontap: (){
                                                showTimePicker(context: context,
                                                  initialTime: TimeOfDay.now(),
                                                ).then((value){
                                                    time.text = value!.format(context).toString() ;
                                                });
                                              },
                                              Controller: time,
                                              icon: Icon(Icons.watch_later),
                                              label: 'time',
                                              type: TextInputType.text),
                                          SizedBox(height: 20,),
                                          myTextFormField(
                                            Controller: date,
                                            ontap: (){
                                              showDatePicker(context: context,
                                                  initialDate: DateTime.now(),
                                                  firstDate: DateTime.now(),
                                                  lastDate: DateTime.parse('2024-12-30')).then((value) {
                                                  date.text =  DateFormat.yMMMd().format(value!);
                                              } );
                                            },
                                            icon: Icon(Icons.date_range),
                                            label: 'date',
                                            type: TextInputType.datetime,
                                          ),

                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ));
                         // setState(() {
                          AppCubit.get(context).changebottomstate(isopen: false);
                          //});
                        }
                        else{
                          if(formdkey.currentState!.validate()) {
                            Get.back();
                            AppCubit.get(context).changebottomstate(isopen: true);
                            AppCubit.get(context).insertTodata(title: tasktitle.text, time: time.text, date: date.text);
                          }}},
                    ),

                    bottomNavigationBar: BottomNavigationBar(
                        type: BottomNavigationBarType.fixed,
                        currentIndex: AppCubit.get(context).page,
                        onTap: (value) {
                          AppCubit.get(context).changeindex(value);
                        },
                        items: [
                          BottomNavigationBarItem(icon: Icon(Icons.menu),label: 'tasks'),
                          BottomNavigationBarItem(icon: Icon(Icons.done),label: 'done'),
                          BottomNavigationBarItem(icon: Icon(Icons.archive),label: 'archive'),
                        ]
                    ),
                    appBar: AppBar(
                      centerTitle: true,
                      title: Text(AppCubit.get(context).title[AppCubit.get(context).page]),
                    ),
                    body: AppCubit.get(context).screens[AppCubit.get(context).page],
                  );
                } ),
          )
        );
      }
    }
