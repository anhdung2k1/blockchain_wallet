import 'package:block_chain/UI/LogIn/google_sign_in/google_sign_in.dart';
import 'package:block_chain/widgets/home_page.dart';
import 'package:block_chain/routes/RouteGenerator.dart';
import 'package:block_chain/widgets/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => GoogleSignInProvider(),
        child: MaterialApp(
          title: 'Flutter App_Emotion_Detection',
          debugShowCheckedModeBanner: false,
          theme: theme(),
          home: const HomePage(),
          onGenerateRoute: RouteGenerator().onGenerateRoute,
        ),
      );
}
