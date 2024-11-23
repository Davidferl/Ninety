import 'package:bonne_reponse/src/domain/places/suggestion.dart';
import 'package:bonne_reponse/src/infra/places/places_api.dart';

class PlacesService {
  final PlacesApi _placesApi;

  PlacesService(this._placesApi);

  Future<List<Suggestion>> getAutocompleteSuggestion() {
    return _placesApi.getAutocompleteSuggestion();
  }
}
