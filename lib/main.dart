// left core_state.dart like in practice_flutter_10_changenotifier
// (in practice_flutter_10_valuenotifier core_state.dart was deleted)
// instead of  home: MainPage(stateNotifier), we added it to child parameter,
// so MainPage doesn't actually get rebuilt every time the bgColor changes
// edit: unlike in practice_flutter_10_valuenotifier, MainPage does get rebuilt,
// because counter and bgColor are not separated due to using CoreState

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'model/core_state.dart';
import 'page/color_page.dart';
import 'page/counter_page.dart';
import 'widget/button_widget.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static const String title = 'Valuenotifier';

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final stateNotifier = CoreNotifier();
    return ValueListenableBuilder(
      valueListenable: stateNotifier,
      builder: (BuildContext context, CoreState state, Widget? child) =>
          MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Valuenotifier',
        theme: ThemeData(
          scaffoldBackgroundColor: state.backgroundColor,
          primaryColor: Colors.white,
        ),
        home: child,
      ),
      child: MainPage(stateNotifier),
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage(
    this.stateNotifier, {
    super.key,
  });

  final CoreNotifier stateNotifier;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Valuenotifier'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ValueListenableBuilder(
                valueListenable: stateNotifier,
                builder:
                    (BuildContext context, CoreState state, Widget? child) =>
                        Text(
                          '${state.counter}',
                          style: const TextStyle(fontSize: 100),
                        )),
            const SizedBox(height: 47),
            ButtonWidget(
              text: 'Change Color',
              onClicked: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => ColorPage(stateNotifier),
                ),
              ),
            ),
            const SizedBox(height: 24),
            ButtonWidget(
              text: 'Change Counter',
              onClicked: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => CounterPage(stateNotifier),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
