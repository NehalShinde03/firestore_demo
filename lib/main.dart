import 'package:firebase_core/firebase_core.dart';
import 'package:firestore_demo/firebase_options.dart';
import 'package:firestore_demo/view/add_data/add_data_view.dart';
import 'package:firestore_demo/view/home/home_view.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: HomeView.routeName,
      routes: route,
    );
  }

  Map<String, WidgetBuilder> get route => <String, WidgetBuilder>{
        HomeView.routeName: HomeView.builder,
        AddDataView.routeName: AddDataView.builder
      };
}
