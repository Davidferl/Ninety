import 'package:bonne_reponse/src/places/domain/suggestion.dart';
import 'package:bonne_reponse/src/places/infra/places_api.dart';

class PlacesService {
  final PlacesApi _placesApi;

  PlacesService(this._placesApi);

  Future<List<Suggestion>> getAutocompleteSuggestion() {
    return _placesApi.getAutocompleteSuggestion();
  }
}
