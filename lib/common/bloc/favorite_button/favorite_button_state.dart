abstract class FavouriteButtonState{}

class FavouriteButtonInitalState extends FavouriteButtonState{}
class FavouriteButtonUpdatedState extends FavouriteButtonState{
  final bool isFavourite;

  FavouriteButtonUpdatedState({required this.isFavourite}); 
}