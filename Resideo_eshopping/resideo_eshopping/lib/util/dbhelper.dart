import 'package:resideo_eshopping/model/product.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:async';

class Dbhelper
{

  static final Dbhelper _helper=Dbhelper.private();

  int _dbversion=1; 
  String _dbname="eshoppingdb.db";
  String _tblname='product';
  String _colid="id";
  String _coltitle="title";
  String _colsDesc="s_desc";
  String _colimg="img";
  String _colprice="price";
  String _colquantity="quantity";
  String _collDesc="l_desc";
  String _colcategory="category";
  String _colrating="rating";
  String _colreview="review";
  String _colthumbnail="thumbnail";
  String _colfaq="faq";
  String _colpVideo="pVideo";

  Dbhelper.private();

  factory Dbhelper()
  {
    return _helper;
  }

  Database _db;

  Future<Database> get db async{
     if(_db==null || !_db.isOpen) 
     _db=await initializedb();
     return _db;
  }

  Future<Database> initializedb() async
  {
    var eshoppingdb;
    try{
    Directory dir= await getApplicationDocumentsDirectory();
    String path=dir.path+_dbname;
    eshoppingdb=await openDatabase(path, version: _dbversion, onCreate: _createdb);
    }catch(e){
      print("Exception Occured:$e");
    }
    return eshoppingdb;
  }

  void _createdb(Database db,int newversion) async
  {
    try{
     return await db.execute('CREATE TABLE $_tblname($_colid INTEGER PRIMARY KEY,$_coltitle TEXT,$_colsDesc TEXT,$_colimg TEXT,$_colprice INTEGER,$_colquantity INTEGER,$_collDesc TEXT,$_colcategory TEXT,$_colrating INTEGER,$_colreview TEXT,$_colthumbnail TEXT,$_colfaq TEXT,$_colpVideo TEXT)');
    }catch(e){
      print("Exception Occured:$e");
    }
  }
  
  Future<int> _addProduct(Database db,Product pd) async{
    var result;
    try{
    result=await db.insert(_tblname, pd.toJson());
    }catch(e){
      print("Exception Occured:$e");
    }
    return result;
  }

  void addAllProduct(List<Product> pd) async{
    Database db=await this.db;
    int count=pd.length;
    for(int i=0;i<count;i++){
    await _addProduct(db,pd[i]);
    }
    close();
  }

  

  Future<List> getProductListDb() async{
    Database db=await this.db;
    var result;
    try{
    result=await db.rawQuery('SELECT * FROM $_tblname');
    }catch(e){
      print("Exception Occured:$e");
    }
    close();
    return result;
  }

 

  Future<List> getProductById(int id) async{
    Database db=await this.db;
    var result;
    try{
    result= await db.rawQuery('SELECT * FROM $_tblname WHERE $_colid = $id');
    }catch(e){
      print("Exception Occured:$e");
    }
    close();
    return result;
  }

  // void truncateProductTable() async{
  //   Database db= await this.db;
  //   db.rawDelete("DELETE FROM $_tblname");
  // }

  // Future<int> getCount() async{
  //   Database db=await this.db;
  //   var result=Sqflite.firstIntValue(
  //     await db.rawQuery('SELECT Count(*) FROM $tblname')
  //   );
  //   return result;
  // }

  Future<int> updateInventoryById(int id,int newInventoryValue) async{
    Database db=await this.db;
    var result;
    try{
    result =await db.rawUpdate("UPDATE $_tblname SET $_colquantity = $newInventoryValue WHERE $_colid = $id");
    }catch(e){
      print("Exception Occured:$e");
    }
    close();
    return result;
  }

  Future close() async{
    Database db=await this.db;
    try{
    await db.close();
    }catch(e){
      print("Exception Occured:$e");
    }
  }

  // Future<int> updatedb(Product pd) async{
  //   Database db= await this.db;
  //   var result = db.update(tblname, pd.tomap(),where: "$colid= ?",whereArgs: [pd.id]);
  //   return result;
  // }

  // Future<int> deletedb(int id) async{
  //   Database db= await this.db;
  //   var result=db.rawDelete('DELETE FROM $tblname WHERE $colid = $id');
  //   return result;
  // }
}