import 'package:provider/provider.dart';
import 'package:wealthify/db/models/category_model/category_model.dart/category_model.dart';
import 'package:wealthify/db/models/transaction_model/transaction_model.dart';
import 'package:wealthify/provider/add_transaction_provider.dart';
import 'package:wealthify/provider/category_provider.dart';
import 'package:wealthify/provider/category_type_provider.dart';
import 'package:wealthify/provider/income_expense.dart';
import 'package:wealthify/provider/onboarding_screen.dart';
import 'package:wealthify/provider/transaction_provider.dart';
import 'package:wealthify/screens/home/screen_root.dart';
import 'package:wealthify/screens/home/screen_transaction_home.dart';
import 'package:wealthify/screens/introduction_pages/onboarding_screens/onboarding.dart';
import 'package:wealthify/screens/introduction_pages/splash1.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(CategoryTypeAdapter().typeId)) {
    Hive.registerAdapter(CategoryTypeAdapter());
  }
  if (!Hive.isAdapterRegistered(CategoryModelAdapter().typeId)) {
    Hive.registerAdapter(CategoryModelAdapter());
  }
  if (!Hive.isAdapterRegistered(TransactionModelAdapter().typeId)) {
    Hive.registerAdapter(TransactionModelAdapter());
  }

  runApp(const CashTrack());
}

class CashTrack extends StatelessWidget {
  const CashTrack({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.grey,
    ));

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (BuildContext context) => ProviderTransaction(),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => OnBoardingProvider(),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => IncomeAndExpense(),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => CategoryProvider(),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => AddTransactionProvider(),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => CategoryTypeProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const SplashScreen(),
          '/root': (context) => RootPage(),
          '/home': (context) => HomeScreen(),
          '/onboard': (context) => Onboarding(),
        },
      ),
    );
  }
}
