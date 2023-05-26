import 'dart:math';

import 'package:bloc_pattern_base/blocs/counter/counter_bloc.dart';
import 'package:bloc_pattern_base/cubits/color/color_cubit.dart';
import 'package:bloc_pattern_base/cubits/counter/counter_cubit.dart';
import 'package:bloc_pattern_base/cubits/theme/theme_cubit.dart';
import 'package:bloc_pattern_base/other_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ColorCubit()),
        BlocProvider(create: (context) => CounterCubit()),
      ],
      child: MaterialApp(
        title: 'Cubit to Cubit',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int incrementSize = 1;
  @override
  Widget build(BuildContext context) {
    return BlocListener<ColorCubit, ColorState>(
      listener: (context, state) {
        if (state.color == Colors.red) {
          incrementSize = 1;
        } else if (state.color == Colors.green) {
          incrementSize = 10;
        } else if (state.color == Colors.blue) {
          incrementSize = 100;
        } else if (state.color == Colors.black) {
          context.read<CounterCubit>().changeCounter(incrementSize: -100);
          incrementSize = -100;
        }
      },
      child: Scaffold(
        backgroundColor: context.watch<ColorCubit>().state.color,
        appBar: AppBar(title: const Text('Cubit2Cbuit')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    context.read<ColorCubit>().changeColor();
                  },
                  child: const Text(
                    'Change color',
                    style: TextStyle(fontSize: 24.0),
                  )),
              const SizedBox(
                height: 20.0,
              ),
              Text(
                '${context.watch<CounterCubit>().state.counter}',
                style: const TextStyle(
                    fontSize: 52.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              ElevatedButton(
                  onPressed: () {
                    context
                        .read<CounterCubit>()
                        .changeCounter(incrementSize: incrementSize);
                  },
                  child: const Text(
                    'Increment Counter',
                    style: TextStyle(fontSize: 24.0),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}





















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
