import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'thing.dart';
import 'my_database_provider.dart';
import 'my_thing_form.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _things = <Thing>[];
  final _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (context) => MyThingForm())); },
        tooltip: 'Add Thing',
        child: Icon(Icons.add),
        key: Key('add new thing'),
      ),
    );
  }

  Widget _buildList() {
    return new FutureBuilder(
      key: Key('list'),
      future: getThings(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return Text('no connection state');
          case ConnectionState.active:
            return Text('connection active...');
          case ConnectionState.waiting:
            return Text('connection waiting...');
          case ConnectionState.done:
            if (snapshot.hasError) return Text("Error: ${snapshot.error}");
            _things = snapshot.data;
            return _buildThings();
        }
      },
    );
  }

  Widget _buildThings() {
    return ListView.separated(
      padding: const EdgeInsets.all(16.0),
      itemCount: _things.length,
      itemBuilder: (context, i) {
        final Thing thing = _things[i];

        return _buildRow("${thing.id}: ${thing.name}, ${thing.number}");
      },
      separatorBuilder: (_context, _i) { return Divider(); },
    );
  }

  Widget _buildRow(String stuff) {
    return ListTile(title: Text(stuff, key: Key('list entry'), style:_biggerFont));
  }
}
