import 'package:bonne_reponse/src/places/domain/suggestion.dart';

class PlacesApi {
  Future<List<Suggestion>> getAutocompleteSuggestion() {
    return Future.value([
      Suggestion(
        postalCode: '12345',
        address: '1234 Main St',
        country: 'US',
        state: 'CA',
      ),
      Suggestion(
        postalCode: '54321',
        address: '4321 Main St',
        country: 'US',
        state: 'NY',
      ),
    ]);
  }
}
