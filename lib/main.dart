import 'package:bloc_pattern_base/blocs/counter/counter_bloc.dart';
import 'package:bloc_pattern_base/blocs/theme/theme_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
//  Bloc.observer = AppBlocObserver();  ///Bloc observer implementation

  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: kIsWeb
          ? HydratedStorage.webStorageDirectory
          : await getApplicationDocumentsDirectory());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CounterBloc>(create: (context) => CounterBloc()),
        BlocProvider<ThemeBloc>(create: (context) => ThemeBloc())
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'Hydrated Bloc',
            debugShowCheckedModeBanner: false,
            theme: state.appTheme == AppTheme.light
                ? ThemeData.light()
                : ThemeData.dark(),
            home: const MyHomePage(),
          );
        },
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Text(
        '${context.watch<CounterBloc>().state.counter}',
        style: const TextStyle(fontSize: 64.0),
      )),
      floatingActionButton:
          Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        FloatingActionButton(
          onPressed: () {
            context.read<ThemeBloc>().add(ToggleThemeEvent());
          },
          heroTag: 'SwitchTheme',
          child: const Icon(Icons.brightness_6),
        ),
        const SizedBox(
          width: 5.0,
        ),
        FloatingActionButton(
          onPressed: () {
            context.read<CounterBloc>().add(IncrementCounterEvent());
          },
          heroTag: 'Increment',
          child: const Icon(Icons.add),
        ),
        const SizedBox(
          width: 5.0,
        ),
        FloatingActionButton(
          onPressed: () {
            context.read<CounterBloc>().add(DecrementCounterEvent());
          },
          heroTag: 'Decrement',
          child: const Icon(Icons.remove),
        ),
        const SizedBox(
          width: 5.0,
        ),
        FloatingActionButton(
          onPressed: () {
            HydratedBloc.storage.clear();
          },
          heroTag: 'ClearStorage',
          child: const Icon(Icons.delete_forever),
        )
      ]),
    );
  }
}

/// -- Event Transformer implementation -- ///
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => CounterBloc(),
//       child: MaterialApp(
//         title: 'Event Transformer',
//         debugShowCheckedModeBanner: false,
//         theme: ThemeData(primarySwatch: Colors.blue),
//         home: const MyHomePage(),
//       ),
//     );
//   }
// }

// class MyHomePage extends StatelessWidget {
//   const MyHomePage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Text(
//           '${context.watch<CounterBloc>().state.counter}',
//           style: const TextStyle(fontSize: 54.0),
//         ),
//       ),
//       floatingActionButton: Row(
//         mainAxisAlignment: MainAxisAlignment.end,
//         children: [
//           FloatingActionButton(
//             onPressed: () {
//               context.read<CounterBloc>().add(IncrementEvent());
//             },
//             heroTag: 'Increment',
//             child: const Icon(Icons.add),
//           ),
//           const SizedBox(
//             width: 10.0,
//           ),
//           FloatingActionButton(
//             onPressed: () {
//               context.read<CounterBloc>().add(DecrementEvent());
//             },
//             heroTag: 'Decrement',
//             child: const Icon(Icons.remove),
//           )
//         ],
//       ),
//     );
//   }
// }
/// -- Bloc Access - Anonymous,Named and Generated routes --///

// class MyApp extends StatefulWidget {
//   const MyApp({super.key});

//   @override
//   State<MyApp> createState() => _MyAppState();
// }
// class _MyAppState extends State<MyApp> {
//   final CounterCubit counterCubit = CounterCubit();

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Bloc Access',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(primarySwatch: Colors.blue),

//       ///-- Named Route Access --///
//       // routes: {
//       //   '/': (context) => BlocProvider.value(
//       //         value: counterCubit,
//       //         child: const MyHomePage(),
//       //       ),
//       //   '/counter': (context) => BlocProvider.value(
//       //         value: counterCubit,
//       //         child: const ShowMeCounter(),
//       //       )
//       // },
//       onGenerateRoute: (settings) {
//         switch (settings.name) {
//           case '/':
//             return MaterialPageRoute(
//                 builder: ((context) => BlocProvider.value(
//                       value: counterCubit,
//                       child: const MyHomePage(),
//                     )));
//           case '/counter':
//             return MaterialPageRoute(
//                 builder: ((context) => BlocProvider.value(
//                       value: counterCubit,
//                       child: const ShowMeCounter(),
//                     )));
//           default:
//             return null;
//         }
//       },

//       /// -- Anonymous routes -- ///
//       // home: BlocProvider<CounterCubit>(
//       //   create: (context) => CounterCubit(),
//       //   child: const MyHomePage(),
//       // ),
//     );
//   }

//   @override
//   void dispose() {
//     counterCubit.close();
//     super.dispose();
//   }
// }

// class MyHomePage extends StatelessWidget {
//   const MyHomePage({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ElevatedButton(
//                 onPressed: () {
//                   Navigator.pushNamed(context, '/counter');

//                   /// -- Anonymous route -- ///
//                   // Navigator.push(context, MaterialPageRoute(builder: (_) {
//                   //   return BlocProvider.value(
//                   //     value: context.read<CounterCubit>(),
//                   //     child: const ShowMeCounter(),
//                   //   );
//                   // }));
//                 },
//                 child: const Text(
//                   'Show Me Counter',
//                   style: TextStyle(fontSize: 20.0),
//                 )),
//             ElevatedButton(
//                 onPressed: () {
//                   BlocProvider.of<CounterCubit>(context).incrementCounter();
//                 },
//                 child: const Text(
//                   'Increment Counter',
//                   style: TextStyle(fontSize: 20.0),
//                 ))
//           ],
//         ),
//       ),
//     );
//   }
// }

///-- Bloc Access --///
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key}) : super(key: key);

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => CounterCubit(),
//       child: Builder(
//         builder: (context) {
//           return Scaffold(
//             appBar: AppBar(
//               title: const Text('Bloc Access'),
//             ),
//             body: Center(
//                 child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   '${context.watch<CounterCubit>().state.counter}',
//                   style: const TextStyle(fontSize: 32.0),
//                 ),
//                 const SizedBox(
//                   height: 10.0,
//                 ),
//                 ElevatedButton(
//                     onPressed: () {
//                       context.read<CounterCubit>().incrementCounter();
//                     },
//                     child: const Text(
//                       'Increment',
//                       style: TextStyle(fontSize: 12.0),
//                     ))
//               ],
//             )),
//           );
//         },
//       ),
//     );
//   }
// }

///-- Bloc to bloc communication using stream subscription and bloc listener --///
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocProvider(
//       providers: [
//         BlocProvider(create: (context) => ColorBloc()),
//         BlocProvider(
//             create: (context) =>
//                 CounterBloc(colorBloc: context.read<ColorBloc>())),
//       ],
//       child: MaterialApp(
//         title: 'Cubit to Cubit',
//         debugShowCheckedModeBanner: false,
//         theme: ThemeData(primarySwatch: Colors.blue),
//         home: const MyHomePage(),
//       ),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key}) : super(key: key);

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int incrementSize = 1;
//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<ColorBloc, ColorState>(
//       listener: (context, state) {
//         if (state.color == Colors.red) {
//           incrementSize = 1;
//         } else if (state.color == Colors.green) {
//           incrementSize = 10;
//         } else if (state.color == Colors.blue) {
//           incrementSize = 100;
//         } else if (state.color == Colors.black) {
//           incrementSize = -100;
//           context
//               .read<CounterBloc>()
//               .add(ChangedCounterEvent(incrementSize: incrementSize));
//         }
//       },
//       child: Scaffold(
//         backgroundColor: context.watch<ColorBloc>().state.color,
//         appBar: AppBar(title: const Text('Cubit2Cbuit')),
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               ElevatedButton(
//                   onPressed: () {
//                     context.read<ColorBloc>().add(ChangedColorEvent());
//                   },
//                   child: const Text(
//                     'Change color',
//                     style: TextStyle(fontSize: 24.0),
//                   )),
//               const SizedBox(
//                 height: 20.0,
//               ),
//               Text(
//                 '${context.watch<CounterBloc>().state.counter}',
//                 style: const TextStyle(
//                     fontSize: 52.0,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white),
//               ),
//               ElevatedButton(
//                   onPressed: () {
//                     context
//                         .read<CounterBloc>()
//                         .add(ChangedCounterEvent(incrementSize: incrementSize));
//                   },
//                   child: const Text(
//                     'Increment Counter',
//                     style: TextStyle(fontSize: 24.0),
//                   ))
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

/// -- Bloc to bloc using stream subscription --///
// class _MyHomePageState extends State<MyHomePage> {
//   int incrementSize = 1;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: context.watch<ColorBloc>().state.color,
//       appBar: AppBar(title: const Text('Cubit2Cbuit')),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ElevatedButton(
//                 onPressed: () {
//                   context.read<ColorBloc>().add(ChangedColorEvent());
//                 },
//                 child: const Text(
//                   'Change color',
//                   style: TextStyle(fontSize: 24.0),
//                 )),
//             const SizedBox(
//               height: 20.0,
//             ),
//             Text(
//               '${context.watch<CounterBloc>().state.counter}',
//               style: const TextStyle(
//                   fontSize: 52.0,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white),
//             ),
//             ElevatedButton(
//                 onPressed: () {
//                   context.read<CounterBloc>().add(ChangedCounterEvent());
//                 },
//                 child: const Text(
//                   'Increment Counter',
//                   style: TextStyle(fontSize: 24.0),
//                 ))
//           ],
//         ),
//       ),
//     );
//   }
// }

///--Cubit to Cubit--//
// class _MyHomePageState extends State<MyHomePage> {
//   int incrementSize = 1;
//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<ColorCubit, ColorState>(
//       listener: (context, state) {
//         if (state.color == Colors.red) {
//           incrementSize = 1;
//         } else if (state.color == Colors.green) {
//           incrementSize = 10;
//         } else if (state.color == Colors.blue) {
//           incrementSize = 100;
//         } else if (state.color == Colors.black) {
//           context.read<CounterCubit>().changeCounter(incrementSize: -100);
//           incrementSize = -100;
//         }
//       },
//       child: Scaffold(
//         backgroundColor: context.watch<ColorCubit>().state.color,
//         appBar: AppBar(title: const Text('Cubit2Cbuit')),
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               ElevatedButton(
//                   onPressed: () {
//                     context.read<ColorCubit>().changeColor();
//                   },
//                   child: const Text(
//                     'Change color',
//                     style: TextStyle(fontSize: 24.0),
//                   )),
//               const SizedBox(
//                 height: 20.0,
//               ),
//               Text(
//                 '${context.watch<CounterCubit>().state.counter}',
//                 style: const TextStyle(
//                     fontSize: 52.0,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white),
//               ),
//               ElevatedButton(
//                   onPressed: () {
//                     context
//                         .read<CounterCubit>()
//                         .changeCounter(incrementSize: incrementSize);
//                   },
//                   child: const Text(
//                     'Increment Counter',
//                     style: TextStyle(fontSize: 24.0),
//                   ))
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// -- Theme feature using bloc and cubit --//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => ThemeCubit(),
//       child: BlocBuilder<ThemeCubit, ThemeState>(
//         builder: (context, state) {
//           return MaterialApp(
//             title: 'Event Payload',
//             debugShowCheckedModeBanner: false,
//             theme: state.appTheme == AppTheme.light
//                 ? ThemeData.light()
//                 : ThemeData.dark(),
//             home: const MyHomePage(),
//           );
//         },
//       ),
//     );
//   }
// }

//Extension function implementation//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => ThemeBloc(),
//       child: Builder(builder: (context) {
//         return MaterialApp(
//           title: 'Event Payload',
//           debugShowCheckedModeBanner: false,
//           theme: context.watch<ThemeBloc>().state.appTheme == AppTheme.light
//               ? ThemeData.light()
//               : ThemeData.dark(),
//           home: const MyHomePage(),
//         );
//       }),
//     );
//   }
// }
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => ThemeBloc(),
//       child: BlocBuilder<ThemeBloc, ThemeState>(
//         builder: (context, state) {
//           return MaterialApp(
//             title: 'Event Payload',
//             debugShowCheckedModeBanner: false,
//             theme: state.appTheme == AppTheme.light
//                 ? ThemeData.light()
//                 : ThemeData.dark(),
//             home: const MyHomePage(),
//           );
//         },
//       ),
//     );
//   }
// }

// class MyHomePage extends StatelessWidget {
//   const MyHomePage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Theme'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//             onPressed: () {
//               final int randInt = Random().nextInt(10);
//               debugPrint('randInt = $randInt');
//               context.read<ThemeCubit>().changeTheme(randInt);
//               // context
//               //     .read<ThemeBloc>()
//               //     .add(ChangedThemeEvent(randInt: randInt));
//             },
//             child: const Text(
//               'Change Theme',
//               style: TextStyle(fontSize: 24.0),
//             )),
//       ),
//     );
//   }
// }

//////-- Bloc implementation --//////
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider<CounterBloc>(
//       create: (context) => CounterBloc(),
//       child: MaterialApp(
//         title: 'MyCounter Bloc',
//         debugShowCheckedModeBanner: false,
//         theme: ThemeData(
//           colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//           useMaterial3: true,
//         ),
//         home: const MyHomePage(),
//       ),
//     );
//   }
// }

// class MyHomePage extends StatelessWidget {
//   const MyHomePage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: BlocListener<CounterBloc, CounterState>(
//         listener: (context, state) {
//           if (state.counter == 3) {
//             showDialog(
//                 context: context,
//                 builder: (context) {
//                   return AlertDialog(
//                     content: Text('Counter is ${state.counter}'),
//                   );
//                 });
//           } else if (state.counter == -1) {
//             Navigator.push(context,
//                 MaterialPageRoute(builder: (context) => const OtherPage()));
//           }
//         },
//         child: Center(
//           child: Text(
//             '${context.watch<CounterBloc>().state.counter}',
//             style: const TextStyle(fontSize: 52.0),
//           ),
//         ),
//       ),
//       floatingActionButton: Row(
//         mainAxisAlignment: MainAxisAlignment.end,
//         children: [
//           FloatingActionButton(
//             heroTag: "increment",
//             onPressed: () {
//               BlocProvider.of<CounterBloc>(context).add(IncrementEvent());
//             },
//             child: const Icon(Icons.add),
//           ),
//           const SizedBox(
//             width: 10.0,
//           ),
//           FloatingActionButton(
//             heroTag: "decrement",
//             onPressed: () {
//               context.read<CounterBloc>().add(DecrementEvent());
//             },
//             child: const Icon(Icons.remove),
//           )
//         ],
//       ),
//     );
//   }
// }

//////-- Cubit implementation --//////

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider<CounterCubit>(
//       create: (context) => CounterCubit(),
//       child: MaterialApp(
//         title: 'MyCounter Cubit',
//         debugShowCheckedModeBanner: false,
//         theme: ThemeData(
//           colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//           useMaterial3: true,
//         ),
//         home: const MyHomePage(),
//       ),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key});

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: BlocConsumer<CounterCubit, CounterState>(
//         listener: (context, state) {
//           if (state.counter == 3) {
//             showDialog(
//                 context: context,
//                 builder: (context) {
//                   return AlertDialog(
//                     content: Text('counter is ${state.counter}'),
//                   );
//                 });
//           } else if (state.counter == -1) {
//             Navigator.push(context, MaterialPageRoute(builder: (context) {
//               return const OtherPage();
//             }));
//           }
//         },
//         builder: (context, state) {
//           return Center(
//               child: Text(
//             '${state.counter}',
//             style: const TextStyle(fontSize: 52.0),
//           ));
//         },
//       ),
//       // body: BlocListener<CounterCubit, CounterState>(
//       //   listener: (context, state) {
//       //     if (state.counter == 3) {
//       //       showDialog(
//       //           context: context,
//       //           builder: (context) {
//       //             return AlertDialog(
//       //               content: Text('counter is ${state.counter}'),
//       //             );
//       //           });
//       //     } else if (state.counter == -1) {
//       //       Navigator.push(context, MaterialPageRoute(builder: (context) {
//       //         return const OtherPage();
//       //       }));
//       //     }
//       //   },
//       //   child: BlocBuilder<CounterCubit, CounterState>(
//       //     builder: (context, state) {
//       //       return Center(
//       //           child: Text(
//       //         '${state.counter}',
//       //         style: const TextStyle(fontSize: 52.0),
//       //       ));
//       //     },
//       //   ),
//       // ),
//       floatingActionButton: Row(
//         mainAxisAlignment: MainAxisAlignment.end,
//         children: [
//           FloatingActionButton(
//             onPressed: () {
//               context.read<CounterCubit>().increment();
//               //BlocProvider.of<CounterCubit>(context).increment();
//             },
//             heroTag: 'Increment',
//             child: const Icon(Icons.add),
//           ),
//           const SizedBox(width: 10.0),
//           FloatingActionButton(
//             onPressed: () {
//               context.read<CounterCubit>().decrement();
//               //BlocProvider.of<CounterCubit>(context).decrement();
//             },
//             heroTag: 'Decrement',
//             child: const Icon(Icons.remove),
//           ),
//         ],
//       ),
//     );
//   }
// }
