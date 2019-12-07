import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'pages_provider.dart';

void main() => runApp(
      ChangeNotifierProvider(
        create: (context) => CartModel(),
        child: MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  TabController _controller;
  List<String> pages = ["First Tab"];
  int selectedIndex = 0, index = 0;
  

  @override
  void initState() {
    super.initState();
    // _addItems();
    // pages = [
    //   "Tab 1",
    //   "Tab 2",
    //   "Tab 3",
    //   "Tab 4",
    //   "Tab 5",
    //   "Tab 6",
    //   "Tab 7",
    //   "Tab 8",
    //   "Tab 9",
    //   "Tab 10",
    //   "Tab 11",
    // ];
    _controller = new TabController(vsync: this, length: pages.length);
    _controller.animateTo(0);
  }

  Widget buildTab(String theme) {
    return new Tab(
      key: ValueKey("pagetabs${pages.indexOf(theme)}"),
      text: theme.toUpperCase(),
    );
  }

  Widget buildTop() {
    return TabBar(
      isScrollable: true,
      indicatorWeight: 2.0,
      labelColor: Colors.white,
      labelStyle:
          new TextStyle(fontWeight: FontWeight.w700, color: Colors.white),
      unselectedLabelStyle: new TextStyle(fontWeight: FontWeight.w400),
      unselectedLabelColor: Colors.white54,
      indicatorSize: TabBarIndicatorSize.tab,
      indicatorColor: Colors.red.withOpacity(0.7),
      indicatorPadding: EdgeInsets.only(bottom: 2.0),
      controller: _controller,
      tabs: pages.map((node) {
        return buildTab(node);
      }).toList(),
    );
  }

  Widget buildBody() {
    return Center(
      child: Text(pages[selectedIndex]),
    );
  }

  void _changeTab() async {
    // setState(() {
      // if (pages.length < 12) {
      // pages.addAll(["New Tab $selectedIndex", "New Tab $selectedIndex"]);
      // _controller = new TabController(vsync: this, length: pages.length);
      // }
      if (selectedIndex >= (pages.length - 1)) {
        selectedIndex = 0;
      } else {
        selectedIndex++;
      }
    // });
    // await Future.delayed(Duration(milliseconds: 500));
    _controller.animateTo(selectedIndex);
  }

  void _addItems() {
    // setState(() {
    //   pages.addAll(["New Tab 1", "New Tab 2"]);
    //   _controller = new TabController(vsync: this, length: pages.length);
    // });
    // final cart = CartModel();
    index++;
    // cart.add("Tab $index");
    Provider.of<CartModel>(context, listen: false).add("Tab $index");
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CartModel>(
      builder: (context, cart, child) {
        print(cart.pages);
        pages = cart.pages;
        _controller = new TabController(vsync: this, length: pages.length);
        return Scaffold(
          appBar: AppBar(
            title: buildTop(),
          ),
          body: buildBody(),
          floatingActionButton: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              FloatingActionButton(
                onPressed: _changeTab,
                child: Icon(Icons.change_history),
              ),
              FloatingActionButton(
                onPressed: _addItems,
                child: Icon(Icons.add),
              ),
            ],
          ),
        );
      },
    );
  }
}
