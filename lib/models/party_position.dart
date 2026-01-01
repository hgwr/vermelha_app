enum PartyPosition {
  forward,
  middle,
  rear,
}

PartyPosition? partyPositionFromDb(Object? value) {
  if (value == null) {
    return null;
  }
  if (value is! int) {
    return null;
  }
  if (value < 0 || value >= PartyPosition.values.length) {
    return null;
  }
  return PartyPosition.values[value];
}
