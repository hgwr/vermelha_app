import 'dart:async';

import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [])
class AppDatabase extends _$AppDatabase {
  AppDatabase._internal()
      : super(
          driftDatabase(
            name: 'vermelha_database',
            web: DriftWebOptions(
              sqlite3Wasm: Uri.parse('sqlite3.wasm'),
              driftWorker: Uri.parse('drift_worker.js'),
              onResult: _logWebResult,
            ),
            native: DriftNativeOptions(
              databasePath: () async {
                final dir = await getApplicationDocumentsDirectory();
                return p.join(dir.path, 'vermelha_database.db');
              },
            ),
          ),
        );

  static final AppDatabase _instance = AppDatabase._internal();

  factory AppDatabase() => _instance;

  @override
  int get schemaVersion => 1;
}

void _logWebResult(WasmDatabaseResult result) {
  if (!kDebugMode || result.missingFeatures.isEmpty) {
    return;
  }
  debugPrint(
    'drift web storage: ${result.chosenImplementation} (missing '
    '${result.missingFeatures.join(', ')})',
  );
}
