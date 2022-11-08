import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import '../data/message_dao.dart';
import '../data/user_dao.dart';
import 'ui/message_list.dart';
import 'ui/login.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // This provides UserDao to other screens.
        ChangeNotifierProvider<UserDao>(
          lazy: false,
          create: (_) => UserDao(),
        ),
        Provider<MessageDao>(
          lazy: false,
          create: (_) => MessageDao(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'RayChat',
        theme: ThemeData(
          primaryColor: const Color(0xFF3D814A),
        ),
        // You want a Consumer of a UserDao.
        home: Consumer<UserDao>(
          // In the builder, you are passed in an instance of UserDao.
          builder: (
            context,
            userDao,
            child,
          ) {
            // Check to see if the user is logged in. If so, show the
            // MessageList otherwise show the login screen.
            if (userDao.isLoggedIn()) {
              return const MessageList();
            } else {
              return const Login();
            }
          },
        ),
      ),
    );
  }
}
