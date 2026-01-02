import 'package:vermelha_app/models/party_position.dart';
import 'package:vermelha_app/models/player_character.dart';

class Party {
  final Map<PartyPosition, int?> positions;

  const Party({required this.positions});

  factory Party.empty() {
    return Party(
      positions: {
        PartyPosition.forward: null,
        PartyPosition.middle: null,
        PartyPosition.rear: null,
      },
    );
  }

  factory Party.fromRoster(List<PlayerCharacter> roster) {
    final positions = <PartyPosition, int?>{
      for (final position in PartyPosition.values) position: null,
    };
    for (final member in roster) {
      final position = member.partyPosition;
      if (position != null) {
        positions[position] = member.id;
      }
    }
    return Party(positions: positions);
  }
}
