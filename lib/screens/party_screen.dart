import 'package:flutter/material.dart';

import '../providers/screen_provider.dart';
import '../widgets/bottom_bar_widget.dart';

class PartyScreen extends StatelessWidget {
  const PartyScreen({Key? key}) : super(key: key);

  static const routeName = '/party';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Party')),
      body: const Center(
        child: Text('Party'),
      ),
      bottomNavigationBar: const BottomBarWidget(
        currentScreenIndex: ScreenProvider.partyScreenIndex,
      ),
    );
  }
}
