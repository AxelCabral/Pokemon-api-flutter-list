class Pokemon {
  late final String _id;
  String _name;
  final String _imageUrl;
  final String _type;

  static int _countId = 0;
  static final Map<String, Pokemon> pokemons = {};

  Pokemon(this._name, this._imageUrl, this._type){
    _id = _countId.toString();
    _countId++;
    _name = formatName(_name);
    pokemons[_id] = this;
  }

  String get id{
    return _id;
  }

  String get name{
    return _name;
  }

  String get imageUrl{
    return _imageUrl;
  }

  String get type{
    return _type;
  }

  set name(String name){
    _name = formatName(name);
  }

  formatName(String name){
    return name[0].toUpperCase()+name.substring(1);
  }
}