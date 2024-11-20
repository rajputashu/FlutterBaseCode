import 'package:apps_architecture/di/injections_container.dart';
import 'package:apps_architecture/modules/login/login_bloc.dart';
import 'package:apps_architecture/modules/login/ui/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDi();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Architecture',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: const AppMainPage(title: 'Flutter Demo Home Page'),
      home: MultiBlocProvider(providers: [
        BlocProvider<LoginBloc>(create: (context) => locator<LoginBloc>()),
        // BlocProvider<AccountBloc>(create: (context)=>AccountBloc())
      ], child: const AppMainPage(title: 'Flutter Demo Home Page')),
    );
  }
}

class AppMainPage extends StatefulWidget {
  const AppMainPage({super.key, required this.title});

  final String title;

  @override
  State<AppMainPage> createState() => _AppMainPageState();
}

class _AppMainPageState extends State<AppMainPage> {
  // ApiService apiService = GetIt.I<ApiService>();
  // final postDao = locator<PostDao>();
  // final loginRepo = locator<LoginRepository>();

  Future<void> _callAPI() async {
    /* var result = await apiService.fetchList();
    print(result);

    var dbResult = await postDao.fetchAllPosts();
    print(dbResult); */
    /* var dbResult = await loginRepo.fetchPostsFromDB();
    List<Map<String, dynamic>> jsonResult =
        dbResult.map((dto) => dto.toJson()).toList();
    print(jsonResult); */
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: const LoginScreen());
  }
}
