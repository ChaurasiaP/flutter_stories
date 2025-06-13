import 'place.dart';

class StateStory {
  final String state;
  final List<Place> places;

  StateStory({
    required this.state,
    required this.places,
  });

  factory StateStory.fromJson(Map<String, dynamic> json) {
    var placesList = json['places'] as List;
    List<Place> places = placesList.map((i) => Place.fromJson(i)).toList();
    
    return StateStory(
      state: json['state'],
      places: places,
    );
  }
}