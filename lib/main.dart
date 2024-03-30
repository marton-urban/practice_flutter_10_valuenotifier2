// left core_state.dart like in practice_flutter_10_changenotifier
// (in practice_flutter_10_valuenotifier core_state.dart was deleted)

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
    final state = CoreNotifier(const CoreState());
    return ListenableBuilder(
        listenable: state,
        builder: (BuildContext context, Widget? child) => MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Valuenotifier',
              theme: ThemeData(
                scaffoldBackgroundColor: state.value.backgroundColor,
                primaryColor: Colors.white,
              ),
              home: MainPage(state),
            ));
  }
}

class MainPage extends StatelessWidget {
  const MainPage(
    this.state, {
    super.key,
  });

  final CoreNotifier state;

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
            ListenableBuilder(
                listenable: state,
                builder: (BuildContext context, Widget? child) => Text(
                      '${state.value.counter}',
                      style: const TextStyle(fontSize: 100),
                    )),
            const SizedBox(height: 47),
            ButtonWidget(
              text: 'Change Color',
              onClicked: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => ColorPage(state),
                ),
              ),
            ),
            const SizedBox(height: 24),
            ButtonWidget(
              text: 'Change Counter',
              onClicked: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => CounterPage(state),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
