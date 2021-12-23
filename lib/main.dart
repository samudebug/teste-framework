import 'package:authentication_repository/authentication_repository.dart';
import 'package:cart_repository/cart_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firestore_repository/firestore_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pdf_repository/pdf_repository.dart';
import 'package:products_repository/products_repository.dart';
import 'package:realtime_database_repository/realtime_database_repository.dart';
import 'package:teste_framework/blocs/auth_bloc/auth_bloc.dart';
import 'package:teste_framework/blocs/cart_bloc/cart_bloc.dart';
import 'package:teste_framework/blocs/product_bloc/products_bloc.dart';
import 'package:teste_framework/firebase_options.dart';
import 'package:teste_framework/ui/pages/home_page.dart';
import 'package:teste_framework/ui/pages/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final FirestoreRepository firestoreRepository =
      FirestoreRepository(Firebase.apps[0]);
  final ProductsRepository productsRepository =
      ProductsRepository(firestoreRepository);
  final RealtimeDatabaseRepository realtimeDatabaseRepository =
      RealtimeDatabaseRepository(Firebase.apps[0]);
  final CartRepository cartRepository =
      CartRepository(realtimeDatabaseRepository);
  final AuthenticationRepository authRepository = AuthenticationRepository();
  final PDFRepository pdfRepository = PDFRepository();
  runApp(MyApp(
    productsRepository: productsRepository,
    cartRepository: cartRepository,
    authRepository: authRepository,
    pdfRepository: pdfRepository,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
    required this.productsRepository,
    required this.cartRepository,
    required this.authRepository,
    required this.pdfRepository,
  }) : super(key: key);
  final IProductsRepository productsRepository;
  final ICartRepository cartRepository;
  final IAuthenticationRepository authRepository;
  final IPDFRepository pdfRepository;
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider(create: (_) => productsRepository),
          RepositoryProvider(create: (_) => cartRepository),
          RepositoryProvider(create: (_) => authRepository),
          RepositoryProvider(create: (_) => pdfRepository)
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
                create: (context) =>
                    ProductsBloc(context.read<IProductsRepository>())),
            BlocProvider(
                create: (context) => CartBloc(context.read<ICartRepository>(),
                    context.read<IPDFRepository>())),
            BlocProvider(
                create: (context) =>
                    AuthBloc(context.read<IAuthenticationRepository>()))
          ],
          child: MaterialApp(
            title: 'Teste Framework',
            theme: ThemeData(
              primarySwatch: Colors.purple,
            ),
            home: BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                if (state is Authorized) {
                  return const HomePage();
                }
                return LoginPage();
              },
            ),
          ),
        ));
  }
}
