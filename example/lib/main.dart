import 'package:flutter/material.dart';
import 'package:titled_nav_bar/titled_nav_bar.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.green),
      title: 'Titled Bar',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<TitledNavBarItem> items = [
    TitledNavBarItem(title: Text('Home'), logo: Icon(Icons.home)),
    TitledNavBarItem(title: Text('Search'), logo: Icon(Icons.search)),
    TitledNavBarItem(
        title: Text('Fire hydrant'), logo: Icon(Icons.fire_hydrant)),
    TitledNavBarItem(title: Text('Profile'), logo: Icon(Icons.person)),
  ];

  bool navBarMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Titled Bottom Bar"),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text("Reversed mode:"),
            Switch(
              value: navBarMode,
              onChanged: (v) {
                setState(() => navBarMode = v);
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: TitledBottomNavBar(
        onTap: (index) => print("Selected Index: $index"),
        reverse: navBarMode,
        curve: Curves.easeInBack,
        items: items,
        activeColor: Colors.green,
        inactiveColor: Colors.blueGrey,
      ),
    );
  }
}
