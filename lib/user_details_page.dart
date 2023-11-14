// import 'package:flutter/material.dart';
// import 'package:softronces_api/home_page.dart';

// class UserDetailsPage extends StatefulWidget {
//   final int userId;

//   const UserDetailsPage({Key? key, required this.userId}) : super(key: key);

//   @override
//   State<UserDetailsPage> createState() => _UserDetailsPageState();
// }

// class
 
// _UserDetailsPageState
 
// extends
 
// State<UserDetailsPage> {
//   User user = User(id: 0, firstName: '', lastName: '', picture: '');
//   bool isLoading = true;
//   bool isInternetAvailable = false;

//   @override
//   void initState() {
//     super.initState();
//     checkInternetConnection();
//     if (isInternetAvailable) {
//       fetchUserDetails();
//     }
//   }

//   // checkInternetConnection() async