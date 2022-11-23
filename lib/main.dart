import 'package:cbs_test/features/home/presentation/bloc/census_bloc/census_bloc.dart';
import 'package:cbs_test/features/home/presentation/bloc/drop_down_bloc/drop_down_bloc.dart';
import 'package:cbs_test/features/home/presentation/pages/home_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cbs_test/injection_container.dart' as di;
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'injection_container.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  await EasyLocalization.ensureInitialized();
  runApp(
      EasyLocalization(
      supportedLocales: const [Locale('ne'),Locale('en')],
      path: 'assets/translations',
      startLocale: const Locale('en'),
      fallbackLocale: const Locale('en'),
      child: const MainApp()));
}

class MainApp extends StatefulWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=> sl<CensusBloc>()),
        BlocProvider(create: (context)=>sl<DropDownBloc>())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        home: const HomeScreen(),
        theme: ThemeData(
          scaffoldBackgroundColor: const Color(0XFFF5F5F5)
        ),
      ),
    );
  }
}
