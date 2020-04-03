import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'menu_item.dart';


Future<List<MenuItem>> fetchData() async {
  final response = await http
      .get('https://gcp.okbabe.technology/interview/obb-customer/menu');
      
  if (response.statusCode == 200) {
    var jsonBody= json.decode(response.body);
    //jsonBody is list of object
    debugPrint("ollll");
 return   jsonBody['data'].map<MenuItem>((json)=>MenuItem.fromJson(json)).toList();
    //return MenuItem.fromJson(jsonBody['data']);
  }else{
    throw Exception('Failed!');
  }
}

void main() => runApp(MyApp());



class TabView extends StatefulWidget {
  TabView({Key key}) : super(key: key);
  @override
  _TabViewState createState() => _TabViewState();
}

class _TabViewState extends State<TabView> {
    Future<List<MenuItem>> futureMenuItem;
  @override
  void initState(){
    super.initState();
    futureMenuItem = fetchData();
  }
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: DefaultTabController(
            length: 2,
            child: Column(
              children: <Widget>[
                Container(
                  child: TabBar(labelColor: Colors.black, tabs: [
                    Tab(
                      text: "Produk",
                    ),
                    Tab(
                      text: "Empty Tab",
                    ),
                  ]),
                ),
                Expanded(
                    child: TabBarView(children: [
                  Container(
                    color: Colors.black12,
                    child: FutureBuilder<List<MenuItem>>(
                      future: futureMenuItem,
                      builder: (context,snapshot){
                      if (snapshot.hasData){
                      //  debugPrint(snapshot.data);
                        return Center(child: Wrap(
                          children: <Widget>[
                            for (var menuItem in snapshot.data) 
                            
                            Container(
                             // color: Colors.white,
                              constraints: BoxConstraints(
                             //   minHeight: 150
                              ),
                              width: 80.0,
                              
                              margin: EdgeInsets.all(5.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                              //  border: Border.all(
                                //  color:Colors.black12,
                                //  width: 2.0
                              //  )
                              ),
                          //    width: 80,
                              child: Column(
                                children: <Widget>[
                                  IconButton(
                                   icon: Image.network(menuItem.categoryIcon),
                                   iconSize: 60,
                                    onPressed: null
                                    ),
                                    Container(
                                      margin: EdgeInsets.all(5.0),
                                      child: Center(child: Text(
                                        menuItem.categoryName,
                                        textAlign: TextAlign.center,
                                        maxLines: 2,
                                        )))
                                ],
                              ),
                            )
                            
                          ],
                        ));
                      }else if(snapshot.hasError){
                        return Center(child: Text("ERROR :("));
                      }
                      return Center(child: CircularProgressIndicator());
                    }),
                  ),

                  Icon(Icons.offline_bolt),
                  //Icon(Icons.opacity),
                  //   Icon(Icons.open_in_browser),
                ]))
              ],
            )));
  }
}

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          //fontFamily: 'Roboto',

          primarySwatch: Colors.purple,
        ),
        home: Scaffold(
          appBar: AppBar(
            title: Text("HeyBabe"),
            centerTitle: false,
            elevation: 0.0,
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.notifications),
                tooltip: "Notification",
                color: Colors.white,
                onPressed: () {},
              )
            ],
          ),
          body: Column(
            children: <Widget>[
              Container(
                color: Colors.purple,
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.all(10.0),
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      ),
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Icon(
                              Icons.account_balance_wallet,
                              color: Colors.orange,
                            ),
                          ),
                          Text("Rp 5.000.000,00 "),
                          GestureDetector(
                              onTap: () {}, child: Icon(Icons.replay)),
                          Spacer(flex: 1),
                          Icon(
                            Icons.account_circle,
                            color: Colors.orange,
                            // size: 20,
                          ),
                          Text("90"),
                          //
//                                 Padding(padding: EdgeInsets.fromWindowPadding(padding, devicePixelRatio),),
                          //  SizedBox(
                          //   width: 190,
                          // ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                color: Colors.purple,
                padding: EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Image(
                        width: 25, image: AssetImage("assets/ic_Deposit.png")),
                    Image(
                        width: 25, image: AssetImage("assets/ic_Transfer.png")),
                    Image(width: 25, image: AssetImage("assets/ic_Mutasi.png")),
                    Image(width: 25, image: AssetImage("assets/ic_Bantuan.png"))
                  ],
                ),
              ),
              TabView(),
            ],
          ),
        ) //MyHomePage(title: 'Flutter Demo Home Page'),
        );
  }
}
