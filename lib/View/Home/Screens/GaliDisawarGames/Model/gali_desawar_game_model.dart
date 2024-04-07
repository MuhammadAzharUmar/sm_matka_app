class GaliDesawarGameBid {
  final String gameId;
  final String gameType;
  final String session;
  final String bidPoints;
  final String leftDigit;
  final String rightDigit;

  GaliDesawarGameBid({
    required this.gameId,
    required this.gameType,
    required this.session,
    required this.bidPoints,
    required this.leftDigit,
    required this.rightDigit,
  });

  factory GaliDesawarGameBid.fromJson(Map<String, dynamic> json) {
    return GaliDesawarGameBid(
      gameId: json['game_id'],
      gameType: json['game_type'],
      session: json['session'],
      bidPoints: json['bid_points'],
      leftDigit: json['left_digit'],
      rightDigit: json['right_digit'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'game_id': gameId,
      'game_type': gameType,
      'session': session,
      'bid_points': bidPoints,
      'left_digit': leftDigit,
      'right_digit': rightDigit,
    };
  }
}
