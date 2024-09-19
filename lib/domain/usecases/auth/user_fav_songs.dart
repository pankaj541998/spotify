import 'package:dartz/dartz.dart';
import 'package:spotify_bloc/domain/repositories/songs/songs.dart';

import '../../../core/usecase/usecase.dart';
import '../../../service_locator.dart';

class GetUserFavouriteUsecase extends UseCase<Either,dynamic> {
  @override
  Future<Either> call({params})async {
    return sl<SongsRepository>().getUserFavouriteSong();
  }
}