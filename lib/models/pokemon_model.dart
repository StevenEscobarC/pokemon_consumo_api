class Pokemon {
  final int id;
  final String num;
  final String name;
  final String img;
  final List<String> type;
  final List<String> weaknesses;

  Pokemon(
      {required this.id,
      required this.num,
      required this.name,
      required this.img,
      required this.type,
      required this.weaknesses});

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
        id: json['id'],
        num: json['num'],
        name: json['name'],
        img: json['img'],
        type: List<String>.from(json['type']),
        weaknesses: List<String>.from(json['weaknesses']));
  }
}
