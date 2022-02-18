import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'user.dart';
import 'user_id.dart';

class Contacts extends StatefulWidget {
  const Contacts({Key? key}) : super(key: key);

  @override
  _ContactsState createState() => _ContactsState();
}

class _ContactsState extends State<Contacts> {
  late Future<List<User>> userlist;
  @override
  void initState() {
    super.initState();
    userlist = getUserList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Now(),
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.assignment_return),
            tooltip: 'Go to the next page',
            onPressed: () => Navigator.pop(context),
          ),
        ],


        title: const Text('Контакты'),
      ),
      body: FutureBuilder<List<User>>(
        future: userlist,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text('Имя: ${snapshot.data![index].name}'),
                      subtitle: Text('Email: ${snapshot.data![index].email}'),
                      leading: Text('ID: ${snapshot.data![index].id}'),
                      onTap: () async {
                        UserID uid = UserID(
                            snapshot.data![index].id,
                            '${snapshot.data![index].name}',
                            '${snapshot.data![index].username}',
                            '${snapshot.data![index].email}',
                            '${snapshot.data![index].address!.street}',
                            '${snapshot.data![index].address!.suite}',
                            '${snapshot.data![index].address!.city}',
                            '${snapshot.data![index].address!.zipcode}',
                            '${snapshot.data![index].address!.geo!.lat}',
                            '${snapshot.data![index].address!.geo!.lng}',
                            '${snapshot.data![index].phone}',
                            '${snapshot.data![index].website}',
                            '${snapshot.data![index].company!.name}',
                            '${snapshot.data![index].company!.catchPhrase}',
                            '${snapshot.data![index].company!.bs}');
                        Navigator.pushNamed(context, '/ users',
                            arguments: uid);
                      },
                    ),
                  );
                });
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Future<List<User>> getUserList() async {
    List<User> prodList = [];
    const url = 'https://jsonplaceholder.typicode.com/users';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var jsonList = jsonDecode(response.body);
      for (var prod in jsonList) {
        prodList.add(User.fromJson(prod));
      }
      return prodList;
    } else {
      throw Exception('Error: ${response.reasonPhrase}');
    }

  }

}

class Now extends StatelessWidget {
  const Now({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment(0, -1),
                end: Alignment(0, 0),
                colors: [
                  Colors.red,
                  Colors.redAccent,
                  Colors.red,
                ],
              ),
            ),
            child: Image(image: AssetImage('assets/Mortal_kombat_logo.png'))
          ),
          ListTile(
            leading: const Icon(
              Icons.album_sharp,
              color: Colors.red,
            ),
            title: Text('Хоббиты'),
            onTap: () {},
          ),
          Divider(
            thickness: 2,
          ),
          ListTile(
            leading: const Icon(
              Icons.album_sharp,
              color: Colors.black,
            ),
            title: Text('Гномы'),
            onTap: () {},
          ),
          Divider(
            thickness: 2,
          ),


          ListTile(
            leading: const Icon(
              Icons.album_sharp,
              color: Colors.blue,
            ),
            title: Text('Эльфы'),
            onTap: () {},
          )
        ],
        ),
     );
     }
}
