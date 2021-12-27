import 'package:flutter/material.dart';
import 'package:restoapp/colors.dart';
import 'package:restoapp/screens/dataaccess/restaurants.dart';

class Sectors extends StatefulWidget {
  const Sectors({Key? key}) : super(key: key);

  @override
  _DistrictsState createState() => _DistrictsState();
}

class _DistrictsState extends State<Sectors> {
  final List<String> districts = <String>['Muhoro', 'Rurinda', 'Karorero'];
  Icon customIcon = const Icon(Icons.search);
  Widget customSearchBar = Text('Rwamagana Sectors');
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
                                hintText: 'Search a sector...',
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
                          customSearchBar = const Text('Rwamagana Sectors');
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
      body: Padding(
        padding: EdgeInsets.all(10),
        child: ListView.separated(
          itemCount: districts.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
                color: backgroundcolor,
                elevation: 100,
                shadowColor: Colors.black,
                child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ListTile(
                      autofocus: true,
                      leading: Image(
                        image: AssetImage('images/map.jpg'),
                        height: 30,
                        width: 30,
                      ),
                      title: Text('${districts[index]}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          )),
                      trailing: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Restaurants()));
                          },
                          label: Text("Restaurants"),
                          icon: Image.asset(
                            'images/iconnext.jpg',
                            height: 20,
                            width: 20,
                          ), //icon data for elevated button

                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(buttonbackcolor),
                              textStyle: MaterialStateProperty.all(
                                TextStyle(fontSize: 15, color: buttonfontcolor),
                              )
                              //label text
                              )),
                    )));
          },
          separatorBuilder: (BuildContext context, int index) => const Divider(
            height: 0,
          ),
        ),
      ),
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
              Icons.account_circle_outlined,
              color: Colors.black,
            ),
            label: 'Logout',
          ),
        ],
      ),
    );
  }
}
