import 'dart:math';

import 'package:bloc_pattern_base/blocs/counter/counter_bloc.dart';
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
    return BlocProvider(
      create: (context) => ThemeCubit(),
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'Event Payload',
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

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Theme'),
      ),
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              final int randInt = Random().nextInt(10);
              debugPrint('randInt = $randInt');
              context.read<ThemeCubit>().changeTheme(randInt);
              // context
              //     .read<ThemeBloc>()
              //     .add(ChangedThemeEvent(randInt: randInt));
            },
            child: const Text(
              'Change Theme',
              style: TextStyle(fontSize: 24.0),
            )),
      ),
    );
  }
}

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
