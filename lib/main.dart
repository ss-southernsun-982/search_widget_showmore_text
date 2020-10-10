import 'package:flutter/material.dart';
import 'package:search_view/search_view_widget.dart';
import 'package:search_view/show_more_widget.dart';

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

class _MyHomePageState extends State<MyHomePage> {

  GlobalKey<SearchViewWidgetState> _searchKey =  GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      backgroundColor: Colors.green,
      body: GestureDetector(
        onTap: (){
          _searchKey.currentState.closeSearch();
        },
        child: SingleChildScrollView(
          controller: ScrollController()..addListener(() {
            _searchKey.currentState.closeSearch();
          }),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                Container(
                  height: 200,
                  color: Colors.red,
                ),
                SearchViewWidget(
                  searchKey: _searchKey,
                ),
                ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => ShowMoreWidget(
                    lorium1,
                    trimLines: 3,
                  ),
                  separatorBuilder: (context, index) => SizedBox(
                    height: 20,
                  ),
                  itemCount: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

String lorium1 = 'Lorem Ipsum is simply dummy text of the printing '
    'and typesetting industry. Lorem Ipsum has been the '
    'industry\'s standard dummy text ever since the 1500s, '
    'when an unknown printer took a galley of type and '
    'scrambled it to make a type specimen book. '
    'It has survived not only five centuries, '
    'but also the leap into electronic typesetting, '
    'remaining essentially unchanged. '
    'It was popularised in the 1960s with the release '
    'of Letraset sheets containing '
    'Lorem Ipsum passages, and more recently with desktop '
    'publishing software like Aldus PageMaker including '
    'versions of Lorem Ipsum.';
