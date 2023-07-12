import 'package:flutter/material.dart';

 Widget myTextFormField({
  required TextEditingController Controller ,
  required Icon icon ,
   required String label,
   required Function ontap ,
   required TextInputType type ,

})  => TextFormField(
   controller: Controller ,
   validator: (value) {
    if(value!.isEmpty){
      return 'this field can\’t be empty' ;
    }else{
      return null ;
    } ;
   },
   onTap: () {
     ontap();
   },
   keyboardType: type,
   autovalidateMode: AutovalidateMode.onUserInteraction,
   decoration: InputDecoration(
     label: Padding(
       padding: const EdgeInsets.all(8.0),
       child: Text(label),
     ),
     labelStyle: TextStyle(backgroundColor: Colors.white,
     color: Colors.black,
     ),
     filled: true,
      fillColor: Colors.white,
       prefixIconColor: Colors.black45,
       prefixIcon: Padding(
         padding: const EdgeInsets.symmetric(vertical: 2),
         child: icon,
       ),
       focusedBorder:OutlineInputBorder(
           borderRadius: BorderRadius.circular(15),
           borderSide: BorderSide(
             color:Colors.black,
             style: BorderStyle.solid,
           )
       ),

       enabledBorder: OutlineInputBorder(
           borderRadius: BorderRadius.circular(15),
           borderSide: BorderSide(
             color:Colors.black,
             style: BorderStyle.solid,
           )
       ),

       border: OutlineInputBorder(
         borderRadius: BorderRadius.circular(15),
         borderSide: BorderSide(
           color:Colors.black,
           style: BorderStyle.solid,),
         gapPadding: 10,
       )),
   style: TextStyle(
       fontSize: 20,
       color: Colors.black,
       fontWeight: FontWeight.w600
   ),
 );
