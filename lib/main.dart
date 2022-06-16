import 'package:favo_link/screens/page/home/home.dart';
import 'package:favo_link/screens/page/login/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainWidget());
}

class MainWidget extends StatelessWidget {
  const MainWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      theme: ThemeData(
        // textButtonTheme: TextButtonThemeData(
        //   style: TextButton.styleFrom(
        //     backgroundColor: Colors.pink
        //   )
        // )
      ),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(
        body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, state) {
            if(state.connectionState == ConnectionState.waiting){
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            } else if(state.hasData){
              return const HomePage();
            } else{
              return const LoginWidget();
            }
          }
        ),
      ),
    );
  }
}
