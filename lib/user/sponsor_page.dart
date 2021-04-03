import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SponsorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Поддержать проекты')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Заработайте награду, оказав поддержку проектам сайта Azan.kz, ведь это садака-джария, то есть непрерывная милостыня для Вас и Ваших родных, перечислив на указанные карты любую сумму.',
              style: TextStyle(height: 1.6),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: const [
                    Text(
                      '5132 2305 0082 5313',
                      style: TextStyle(fontSize: 26),
                    ),
                    Text(
                      'MasterCard',
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
                Builder(
                  builder: (context) => IconButton(
                    padding: const EdgeInsets.only(top: 5),
                    alignment: Alignment.topCenter,
                    onPressed: () async {
                      await FlutterClipboard.copy('5132230500825313');
                      Scaffold.of(context).showSnackBar(
                          const SnackBar(content: Text('Номер скопирован.')));
                    },
                    icon: Icon(
                      Icons.copy,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: const [
                    Text(
                      '4042 4289 0804 4105',
                      style: TextStyle(fontSize: 26),
                    ),
                    Text(
                      'Visa',
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
                Builder(
                  builder: (context) => IconButton(
                    alignment: Alignment.topCenter,
                    padding: const EdgeInsets.only(top: 5),
                    onPressed: () async {
                      await FlutterClipboard.copy('4042428908044105');
                      Scaffold.of(context).showSnackBar(
                          const SnackBar(content: Text('Номер скопирован.')));
                    },
                    icon: Icon(
                      Icons.copy,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
