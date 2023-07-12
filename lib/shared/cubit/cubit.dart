import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todoapp/shared/cubit/states.dart';
import '../../moduals/archiev page/archiev page.dart';
import '../../moduals/done page/done page.dart';
import '../../moduals/tasks page/tasks page.dart';

class AppCubit extends Cubit<Appstate> {
  AppCubit() : super(initialState());
  static AppCubit get(context) => BlocProvider.of(context);
  int page = 0 ;
  bool open = true ;
  List screens = [
    tasks(),
    done(),
    archiev(),
  ];
  List title = [
    'tasks',
    'done',
    'archiev',
  ];
  changeindex(int index){
    page = index ;
    emit(changeindexstate());
  }
  changebottomstate({
    required bool isopen
}){
    open = isopen ;
    emit(changeopenstate());
  }



  List<Map> newtask = [] ;
  List<Map> donetask = [] ;
  List<Map> archevtask = [] ;
  late Database database ;
  void creatdatabase(){
    openDatabase(
     'toodoo.db',
     version: 1,
     onCreate: (database, version) {
       database.execute('''
                   CREATE TABLE "tasks" (
                  "id"	INTEGER UNIQUE,
                  "title"	TEXT,
                  "date"	TEXT,
                  "time"	TEXT,
                  "status"	TEXT,
                  PRIMARY KEY("id")
                );

    ''').then((value) {
         print('table created');
       },).catchError((e){
         print(e);
       });
       print('database created');
     },
     onOpen: (database) {
       readData(database);
       print('database opend');

     },
   ).then((value){
    database = value ;
     emit(creatdatastate());
   });
  }
  insertTodata({
    required String title,
    required String date,
    required String time ,
}
      )async{
    await database.transaction((txn) {
      txn.rawInsert("INSERT INTO tasks(title,date,time,status) VALUES ('${title}','${date}','${time}','new')").then((value) {
        print("insert succes");
        emit(insertdatastate());
        readData(database);
      }).catchError((e){
        print(e);
      });
      return Future(() => null);
    });


}
void readData(database) {
    newtask = [];
    archevtask = [] ;
    donetask = [] ;
     database.rawQuery("SELECT * FROM tasks").then((value){

       value.forEach((element) {
         if(element['status'] == 'new'){
           newtask.add(element) ;
         }else if(element['status'] == 'done'){
           donetask.add(element) ;
         }else{
           archevtask.add(element) ;
         }
       });
       emit(readdatastate());
     });
}
  void updateData({
    required String status ,
    required int ID

  })  {
     database.rawUpdate(
         'UPDATE tasks SET status = ? WHERE id = ?',
        ['$status', ID]).then((value) {
       readData(database);
       emit(updatedatastate());
    });
  }
  void dleteData({required int ID}) {
     database.rawDelete('DELETE FROM tasks WHERE id = ?', [ID]).then((value){
       readData(database);
       emit(deletdatastate());
     });

  }
}