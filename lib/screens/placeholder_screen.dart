import 'package:flutter/material.dart';
import 'package:vermelha_app/l10n/app_localizations.dart';

class PlaceholderScreen extends StatelessWidget {
  const PlaceholderScreen({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Text(l10n.notImplemented),
      ),
    );
  }
}
