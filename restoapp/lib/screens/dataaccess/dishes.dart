import 'package:flutter/material.dart';
import 'package:restoapp/colors.dart';
import 'package:restoapp/screens/dataaccess/apiaccess.dart';
import 'package:restoapp/screens/dataaccess/dishdetails.dart';
import 'package:restoapp/screens/dataaccess/sectors.dart';

class Dishes extends StatefulWidget {
  const Dishes({Key? key}) : super(key: key);

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
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Dishdetails()));
        },
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

class _DistrictsState extends State<Dishes> {
  final List<String> districts = <String>[
    'Belly Restaraunts',
    'Rw Restaurant',
    'Umurava Restaurants'
  ];
  Icon customIcon = const Icon(Icons.search);
  Widget customSearchBar = Text('Dishes in Restaurant');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black,
      appBar: AppBar(
        title: customSearchBar,
        centerTitle: true,
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                  onTap: () {},
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        if (customIcon.icon == Icons.search) {
                          // Perform set of instructions.
                          customIcon = const Icon(Icons.cancel);
                          customSearchBar = const ListTile(
                            leading: Icon(
                              Icons.search,
                              color: Colors.white,
                              size: 28,
                            ),
                            title: TextField(
                              decoration: InputDecoration(
                                hintText: 'Dishes...',
                                hintStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontStyle: FontStyle.italic,
                                ),
                                border: InputBorder.none,
                              ),
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          );
                        } else {
                          customIcon = const Icon(Icons.search);
                          customSearchBar = const Text('Dishes in Restaurant');
                        }
                      });
                    },
                    icon: customIcon,
                  ))),
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {},
                child: Icon(Icons.more_vert),
              )),
        ],
      ),
      body: ApiDish(),
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
