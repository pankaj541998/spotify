abstract class FavoriteButtonState{}

class FavoriteButtonInitalState extends FavoriteButtonState{}
class FavoriteButtonUpdatedState extends FavoriteButtonState{
  final bool isFavorite;

  FavoriteButtonUpdatedState({required this.isFavorite}); 
}