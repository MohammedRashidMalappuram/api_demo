
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<User> users = [];
  bool isLoading = true;
  bool isInternetAvailable = true;

  @override
  void initState() {
    super.initState();
    checkInternetConnection();
    if (isInternetAvailable) {
      fetchUsers();
    }
  }

  void checkInternetConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty) {
        setState(() {
          isInternetAvailable = true;
        });
      }
    } on SocketException catch (_) {
      setState(() {
        isInternetAvailable = false;
      });
    }
  }

  Future<void> fetchUsers() async {
    final headers = {'app-id': '61dbf9b1d7efe0f95bc1e1a6'};
    try {
      final response = await http.get(
          Uri.parse('https://dummyapi.io/data/v1/user?limit=10'),
          headers: headers);
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final userList = jsonData['data'] as List;
        users = userList.map((user) => User.fromJson(user)).toList();
        setState(() {
          isLoading = false;
        });
      }
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User list"),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : isInternetAvailable
              ? ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    final user = users[index];
                    return ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UserDetailsPage(user: user,)));
                      },
                      leading:const CircleAvatar(
                        backgroundColor: Colors.black,
                      ),
                      title: Text('${user.firstName} ${user.lastName}'),
                      subtitle: Text(user.email),
                    );
                  },
                )
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('No Internet Connection'),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            checkInternetConnection();
                          });
                        },
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                ),
    );
  }
}

class User {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String picture;

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        firstName = json['firstName'],
        lastName = json['lastName'],
        email = json['email'],
        picture = json['picture'];
}


class UserDetailsPage extends StatelessWidget {
  final User user;

  const UserDetailsPage({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('User Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('ID: ${user.id}'),
            Text('First Name: ${user.firstName}'),
            Text('Last Name: ${user.lastName}'),
          ],
        ),
      ),
    );
  }
}

