// import 'dart:ui';
//
// import 'package:admin_portel/Approvals/request.dart';
//
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'HomePage/home_page_container.dart';
// import 'StudentRecords/student_records.dart';
// // import 'add_station.dart';
// import 'auth.dart';
// import 'bus_list.dart';
// import 'manage_routes.dart';
// import 'map_data.dart';
//
// class MyCustomUI extends StatefulWidget {
//   const MyCustomUI({Key? key,required this.auth}) : super(key: key);
//   final Auth auth;
//
//   @override
//   _MyCustomUIState createState() => _MyCustomUIState();
// }
//
// class _MyCustomUIState extends State<MyCustomUI>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _animation;
//   late Animation<double> _animation2;
//
//   @override
//   void initState() {
//     super.initState();
//
//     _controller = AnimationController(
//       vsync: this,
//       duration: Duration(seconds: 1),
//     );
//
//     _animation = Tween<double>(begin: 0, end: 1)
//         .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut))
//       ..addListener(() {
//         setState(() {});
//       });
//
//     _animation2 = Tween<double>(begin: -30, end: 0)
//         .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
//
//     _controller.forward();
//     _controller.forward();
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     double _w = MediaQuery.of(context).size.width;
//     return Scaffold(
//       appBar: AppBar(
//         title:const Text("Home Page"),
//         centerTitle: true,
//
//       ),
//
//       drawer: Drawer(
//         elevation: 0.0,
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
//           child: ListView(
//             children:
//             [
//               ListTile(
//                 onTap: () => confirm(context),
//                 leading: const Text("LogOut"),
//                 trailing: Icon(Icons.logout),
//               ),
//             ],
//           ),
//         ),
//       ),
//
//       backgroundColor: Colors.white,
//
//       body: Stack(
//
//         children: [
//           /// ListView
//           ListView(
//
//             // physics:
//             // BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
//             children: [
//
//
//               homePageCardsGroup(
//                 Color(0xfff37736),
//                 Icons.analytics_outlined,
//                 'Bus Record',
//                 context,
//                 manage_buses(),
//                 Color(0xffFF6D6D),
//                 Icons.all_inclusive,
//                 'Track bus',
//                 track_bus(),
//               ),
//               homePageCardsGroup(
//                   Colors.lightGreen,
//                   Icons.gamepad_outlined,
//                   'Student Record',
//                   context,
//                   student_records(),
//                   Color(0xffffa700),
//                   Icons.article,
//                   'Student Request',
//                    student_request()),
//               homePageCardsGroup(
//                   Color(0xff63ace5),
//                   Icons.ad_units_outlined,
//                   'Drivers Data',
//                   context,
//                   manage_routes(),
//                   Color(0xfff37736),
//                   Icons.article_sharp,
//                   'Manage Routes',
//                   RouteWhereYouGo()),
//
//               SizedBox(height: _w / 20),
//             ],
//           ),
//
//
//         ],
//       ),
//
//     );
//
//   }
//
//   Widget homePageCardsGroup(
//       Color color,
//       IconData icon,
//       String title,
//       BuildContext context,
//       Widget route,
//       Color color2,
//       IconData icon2,
//       String title2,
//       Widget route2) {
//     double _w = MediaQuery.of(context).size.width;
//     return Padding(
//       padding: EdgeInsets.only(bottom: _w / 17),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           homePageCard(color, icon, title, context, route),
//           homePageCard(color2, icon2, title2, context, route2),
//         ],
//       ),
//     );
//   }
//
//   Widget homePageCard(Color color, IconData icon, String title,
//       BuildContext context, Widget route) {
//     double _w = MediaQuery.of(context).size.width;
//     return Opacity(
//       opacity: _animation.value,
//       child: Transform.translate(
//         offset: Offset(0, _animation2.value),
//         child: InkWell(
//           highlightColor: Colors.transparent,
//           splashColor: Colors.transparent,
//           onTap: () {
//             HapticFeedback.lightImpact();
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) {
//                   return route;
//                 },
//               ),
//             );
//           },
//           child: Container(
//             padding: EdgeInsets.all(15),
//             height: _w / 2.2,
//             width: _w / 2.4,
//             decoration: BoxDecoration(
//               color: Colors.white,
//               boxShadow: [
//                 BoxShadow(
//                   color: Color(0xff040039).withOpacity(.15),
//                   blurRadius: 99,
//                 ),
//               ],
//               borderRadius: BorderRadius.all(
//                 Radius.circular(25),
//               ),
//             ),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 SizedBox(),
//                 Container(
//                   height: _w / 8,
//                   width: _w / 8,
//                   decoration: BoxDecoration(
//                     color: color.withOpacity(.1),
//                     shape: BoxShape.circle,
//                   ),
//                   child: Icon(
//                     icon,
//                     color: color.withOpacity(.6),
//                   ),
//                 ),
//                 Text(
//                   title,
//                   maxLines: 4,
//                   softWrap: true,
//                   overflow: TextOverflow.ellipsis,
//                   style: TextStyle(
//                     fontSize: 18,
//                     color: Colors.black.withOpacity(.5),
//                     fontWeight: FontWeight.w700,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//                 SizedBox(),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget blurTheStatusBar(BuildContext context) {
//     double _w = MediaQuery.of(context).size.width;
//     return ClipRRect(
//       child: BackdropFilter(
//         filter: ImageFilter.blur(sigmaY: 5, sigmaX: 5),
//         child: Container(
//           height: _w / 18,
//           color: Colors.transparent,
//         ),
//       ),
//     );
//   }
//
//   signOut(BuildContext context) async{
//     await FirebaseAuth.instance.signOut().catchError((e){
//       print(e);
//     });
//     Navigator.of(context).pop();
//   }
//   void confirm(BuildContext context){
//     showDialog(
//         context: context,
//         builder: (BuildContext context){
//           return  AlertDialog(
//             content:const Text("Are you sure?"),
//             actions: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         minimumSize:const Size(100, 50),
//                       ),
//                       onPressed: (){
//                         Navigator.of(context).pop();
//                       }, child:const Text("Cancel")),
//
//                   const SizedBox(
//                     width: 10.0,
//                   ),
//
//                   ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         minimumSize:const Size(100, 50),
//                       ),
//                       onPressed:() async => await signOut(context), child:const Text("Ok")),
//                 ],
//               ),
//             ],
//           );
//         });
//   }
//   manage_buses() {
//     Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  const BusList()));
//   }
//
//   track_bus() {
//     Navigator.of(context).push(MaterialPageRoute(builder: (context) => const MapData(busNo: '123')));
//   }
//
//
//   manage_routes(){
//     Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ManageRoutes()));
//   }
//
//   student_records(){
//     Navigator.of(context).push(MaterialPageRoute(builder: (context) =>const StudentRecords()));
//   }
//
//   student_request(){
//     Navigator.of(context).push(MaterialPageRoute(builder: (context) => Approvals(auth: Auth(),)));
//
//   }
// }
//
//  class RouteWhereYouGo extends StatelessWidget {
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         brightness: Brightness.light,
//         backgroundColor: Colors.white,
//         elevation: 50,
//         centerTitle: true,
//         shadowColor: Colors.black.withOpacity(.5),
//         title: Text(
//           'EXAMPLE  PAGE',
//           style: TextStyle(
//               color: Colors.black.withOpacity(.7),
//               fontWeight: FontWeight.w600,
//               letterSpacing: 1),
//         ),
//         leading: IconButton(
//           icon: Icon(
//             Icons.arrow_back,
//             color: Colors.black.withOpacity(.8),
//           ),
//           onPressed: () => Navigator.maybePop(context),
//         ),
//       ),
//     );
//   }
//
//
// }
//
