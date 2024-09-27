
//
// import 'package:sqflite/sqflite.dart';
//
// class DbHelper{
//   static DbHelper dbHelper = DbHelper._();
//   DbHelper._();
//
//   get database => null;
//   Future<List<Map<String, Object?>>> selectcategoty(String category) async {
//     Database?  db =await database;
//     String sql =" SELECT * FROM  budget  WHERE category LIKE '%$category%' ";
//     return await db!.rawQuery(sql,);
//   }
// }