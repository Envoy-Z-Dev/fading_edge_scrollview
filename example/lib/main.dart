import 'package:example/lipsum.dart';
import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter/material.dart';

import 'lipsum.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fading Edge ScrollView Example',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: ExamplesList(),
    );
  }
}

class ExamplesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FadingEdgeScrollView examples"),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            NavigatorButton(text: "ListView", builder: (_) => ListViewScreen()),
            NavigatorButton(text: "PageView", builder: (_) => PageViewScreen()),
            NavigatorButton(
                text: "Long text", builder: (_) => LongTextScreen()),
            NavigatorButton(
                text: "Cities images", builder: (_) => CitiesListView()),
          ],
        ),
      ),
    );
  }
}

class NavigatorButton extends StatelessWidget {
  final String text;
  final WidgetBuilder builder;

  NavigatorButton({
    @required this.text,
    @required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Text(text),
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(builder: builder));
      },
    );
  }
}

class ListViewScreen extends StatelessWidget {
  final _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Example with ListWheelScrollView"),
      ),
      body: Container(
        color: Colors.greenAccent,
        child: FadingEdgeScrollView.fromListWheelScrollView(
          gradientFractionOnStart: 0.3,
          gradientFractionOnEnd: 0.3,
          child: ListWheelScrollView(
            itemExtent: 60,
            perspective: 0.0001,
            controller: _controller,
            children: lipsumText.split(" ").sublist(0,20).map((e) {
              return ListTile(
                  title: Text("Item #$e"),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                        "https://images.freeimages.com/images/large-previews/848/a-cat-1313470.jpg"),
                  ));
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class PageViewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Example with PageView"),
      ),
      body: FadingEdgeScrollView.fromPageView(
        child: PageView(
          children: <Widget>[
            Card(color: Colors.red),
            Card(color: Colors.green),
            Card(color: Colors.blue),
          ],
        ),
        gradientFractionOnStart: 0.05,
        gradientFractionOnEnd: 0.05,
      ),
    );
  }
}

class LongTextScreen extends StatelessWidget {
  final controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Example with long text"),
      ),
      body: FadingEdgeScrollView.fromSingleChildScrollView(
        child: SingleChildScrollView(
          controller: controller,
          child: Padding(padding: EdgeInsets.all(5), child: Text(lipsumText)),
        ),
      ),
    );
  }
}

class CitiesListView extends StatelessWidget {
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Image.asset(
            "assets/world.jpeg",
            fit: BoxFit.fitHeight,
            height: MediaQuery.of(context).size.height,
          ),
          Center(
            child: Container(
              height: 400,
              child: FadingEdgeScrollView.fromScrollView(
                child: ListView(
                  controller: _scrollController,
                  children: [
                    "paris",
                    "rome",
                    "moscow",
                    "tokyo",
                  ]
                      .map((city) => Padding(
                            padding: EdgeInsets.all(12),
                            child: ClipRRect(
                              borderRadius: new BorderRadius.circular(20.0),
                              child: Image.asset("assets/$city.jpeg"),
                            ),
                          ))
                      .toList(),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
