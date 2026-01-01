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
    final positions = {
      PartyPosition.forward: _memberIdFor(roster, PartyPosition.forward),
      PartyPosition.middle: _memberIdFor(roster, PartyPosition.middle),
      PartyPosition.rear: _memberIdFor(roster, PartyPosition.rear),
    };
    return Party(positions: positions);
  }

  static int? _memberIdFor(
    List<PlayerCharacter> roster,
    PartyPosition position,
  ) {
    for (final member in roster) {
      if (member.partyPosition == position) {
        return member.id;
      }
    }
    return null;
  }
}
