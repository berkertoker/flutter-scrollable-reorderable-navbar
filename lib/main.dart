import 'package:flutter/material.dart';
import 'package:nav_bar/scrollable_reorderable_navbar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
     
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const BottomNavBarPage(),
    );
  }
}

class BottomNavBarPage extends StatefulWidget {
  const BottomNavBarPage({Key? key}) : super(key: key);

  @override
  _BottomNavBarPageState createState() => _BottomNavBarPageState();
}

class _BottomNavBarPageState extends State<BottomNavBarPage> {
  int _selectedIndex = -1;
  String currentImage = "images/apps2.png";

  List<NavBarItem> _items = [
    NavBarItem(widget: Image.asset("images/phone-call.png",height: 30,), name: 'Phone Call'),
    NavBarItem(widget: Image.asset("images/envelope.png",height: 30,), name: 'Mail'),
    NavBarItem(widget: Image.asset("images/heart.png",height: 30,), name: 'Fav'),
    NavBarItem(widget: Image.asset("images/home.png",height: 30,), name: 'Home'),
    NavBarItem(widget: Image.asset("images/marker.png",height: 30,), name: 'Location'),    
    NavBarItem(widget: Image.asset("images/user.png",height: 30,), name: 'User'),
    NavBarItem(widget: Image.asset("images/youtube.png",height: 30,), name: 'Youtube'),
    NavBarItem(widget: Image.asset("images/twitter.png",height: 30,), name: 'Twitter'),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: const Text("Bottom Navigation Bar")),
      bottomNavigationBar: ScrollableReorderableNavBar(
        centerWidget: GestureDetector(
            onTap: (){                         
              _selectedIndex = -1;
              setState(() {
                if(currentImage == "images/apps2.png"){
                  currentImage = "images/apps1.png";
                }             
              });
            },
            child: Image.asset(currentImage),          
          ),
        
        onItemTap: (arg) {
          setState(() {
            _selectedIndex = arg;
            currentImage = "images/apps2.png";
          });
        },
        onReorder: (oldIndex, newIndex) {
          final currItem = _items[_selectedIndex];
          if (oldIndex < newIndex) newIndex -= 1;
          final newItems = [..._items], item = newItems.removeAt(oldIndex);
          newItems.insert(newIndex, item);
          setState(() {
            _items = newItems;
            _selectedIndex = _items.indexOf(currItem);
          });
        },
        items: _items,
        selectedIndex: _selectedIndex,
        onDelete: (index) => setState(() => _items.removeAt(index)),
        deleteIndicationWidget: Container(
          padding: const EdgeInsets.only(bottom: 100),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              direction: Axis.vertical,
              children: [
                Text("Tap on nav item to delete it.",
                    style: Theme.of(context).textTheme.bodyText1,
                    textAlign: TextAlign.center),
                TextButton(onPressed: () {}, child: const Text("DONE"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}