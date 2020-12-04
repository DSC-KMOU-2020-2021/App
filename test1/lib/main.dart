import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: '예시코드'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter;
  int _total;
  double _size;
  SharedPreferences _prefs;

  @override
  void initState() {
    _load();
    super.initState();
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
      _total++;
      _prefs.setInt('counter', _counter);
      _prefs.setInt('total', _total);
    });
  }

  void _decrementCounter() {
    setState(() {
      _counter--;
      _total++;
      _prefs.setInt('counter', _counter);
      _prefs.setInt('total', _total);
    });
  }

  void _resetCounter() {
    setState(() {
      _counter = 0;
      _total++;
      _prefs.setInt('counter', _counter);
      _prefs.setInt('total', _total);
    });
  }

  void _bigger() {
    setState(() {
      _size++;
      _prefs.setDouble('size', _size);
    });
  }

  void _smaller() {
    setState(() {
      if (_size > 0) {
        _size--;
        _prefs.setDouble('size', _size);
      }
    });
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _load() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _total = (_prefs.getInt('total') ?? 0);
      _counter = (_prefs.getInt('counter') ?? 0);
      _size = (_prefs.getDouble('size') ?? 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Center(
                child: Text(
                  '이게 drawer입니다',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                  ),
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.blueAccent,
              ),
            ),
            ListTile(
              title: Text('서랍 1'),
              subtitle: Text('서랍 1의 설명'),
              onTap: () {},
            ),
            ListTile(
              title: Text('서랍 2'),
              subtitle: Text('서랍 2의 설명'),
              onTap: () {},
            ),
            ListTile(
              title: Text('서랍 3'),
              subtitle: Text('서랍 3의 설명'),
              onTap: () {},
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Stack(
                children: [
                  FlatButton(
                    child: Image.asset('images/puppy.jpg'),
                    onPressed: () {
                      _launchURL('https://www.naver.com');
                    },
                  ),
                  Text(
                    '    네이버',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Stack(
                children: [
                  FlatButton(
                    child: Image.asset('images/puppy2.jpg'),
                    onPressed: () {
                      _launchURL('https://www.daum.net');
                    },
                  ),
                  Text(
                    '    다음',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              Stack(
                children: [
                  FlatButton(
                    child: Image.asset('images/puppy3.jpg'),
                    onPressed: () {
                      _launchURL('https://www.google.com');
                    },
                  ),
                  Text(
                    '    구글',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: _size,
              ),
              FlatButton(
                onPressed: _smaller,
                child: Text('점점 가까워져'),
                color: Colors.black38,
              ),
              SizedBox(
                height: _size,
              ),
              Text(
                '얼마나 눌렀니',
              ),
              SizedBox(
                height: _size,
              ),
              Text(
                '$_total',
                style: Theme.of(context).textTheme.headline4,
              ),
              SizedBox(
                height: _size,
              ),
              Text(
                '지금 숫자는',
              ),
              SizedBox(
                height: _size,
              ),
              Text(
                '$_counter',
                style: Theme.of(context).textTheme.headline4,
              ),
              SizedBox(
                height: _size,
              ),
              FlatButton(
                onPressed: _bigger,
                child: Text('점점 벌어져'),
                color: Colors.black38,
              ),
              SizedBox(
                height: 100,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          FloatingActionButton(
            onPressed: _decrementCounter,
            tooltip: 'decrement',
            child: Icon(Icons.arrow_back),
          ),
          FloatingActionButton(
            onPressed: _resetCounter,
            tooltip: 'reset',
            child: Icon(Icons.circle),
          ),
          FloatingActionButton(
            onPressed: _incrementCounter,
            tooltip: 'Increment',
            child: Icon(Icons.arrow_forward),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          elevation: 5.0,
          items: [
            new BottomNavigationBarItem(
              icon: Icon(Icons.looks_one),
              title: Text('홈 1'),
            ),
            new BottomNavigationBarItem(
              icon: Icon(Icons.looks_two),
              title: Text('홈 2'),
            ),
            new BottomNavigationBarItem(
              icon: Icon(Icons.looks_3),
              title: Text('홈 3'),
            ),
            new BottomNavigationBarItem(
              icon: Icon(Icons.looks_4),
              title: Text('홈 4'),
            ),
          ]),
    );
  }
}
