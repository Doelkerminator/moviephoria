
class Cast {
  String? name;
  String? profile_path;
  String? character;

  Cast({
    this.name,
    this.profile_path,
    this.character
  });

  factory Cast.fromMap(Map<String, dynamic> map) {
    return Cast(
      name: map['name'],
      profile_path: map['profile_path'] ?? '',
      character: map['character']
    );
  }

  Map<String, dynamic> toMap() {
    return{
      'name' : name,
      'profile_path' : profile_path,
      'character' : character
    };
  }
}

