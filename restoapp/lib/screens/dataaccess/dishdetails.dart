import 'package:flutter/material.dart';
import 'package:restoapp/colors.dart';
import 'package:restoapp/screens/dataaccess/sectors.dart';

class Dishdetails extends StatefulWidget {
  const Dishdetails({Key? key}) : super(key: key);

  @override
  _DistrictsState createState() => _DistrictsState();
}

//stateless class for the dihes

class ItemTile extends StatelessWidget {
  final int itemNo;

  const ItemTile(
    this.itemNo,
  );

  @override
  Widget build(BuildContext context) {
    final Color color = Colors.primaries[itemNo % Colors.primaries.length];
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        tileColor: color.withOpacity(0.3),
        onTap: () {},
        leading: Container(
          width: 50,
          height: 30,
          color: color.withOpacity(0.5),
          child: Placeholder(
            color: color,
          ),
        ),
        title: Text(
          'Dish $itemNo',
          key: Key('text_$itemNo'),
        ),
      ),
    );
  }
}

class _DistrictsState extends State<Dishdetails> {
  final List<String> districts = <String>[
    'Belly Restaraunts',
    'Rw Restaurant',
    'Umurava Restaurants'
  ];
  Icon customIcon = const Icon(Icons.search);
  //  customSearchBar = Text('Dish Details');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Dish Details'),
        centerTitle: true,
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {},
                child: Icon(Icons.more_vert),
              )),
        ],
      ),
      body: Padding(
          padding: EdgeInsets.all(10),
          child: GridView.builder(
            itemCount: 1,
            itemBuilder: (context, index) => ItemTile(index),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              childAspectRatio: 1,
            ),
          )),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black12,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Colors.black,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.restaurant,
              color: Colors.black,
            ),
            label: 'Restaurants',
          ),
        ],
      ),
    );
  }
}
