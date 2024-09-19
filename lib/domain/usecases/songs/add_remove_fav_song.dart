import 'package:dartz/dartz.dart';

import '../../../core/usecase/usecase.dart';
import '../../../service_locator.dart';
import '../../repositories/songs/songs.dart';

class AddRemoveFavoriteSongsUseCase implements UseCase<Either,String>{
  @override
  Future<Either> call({String ? params}) async{
    return await sl<SongsRepository>().addRemoveFavSong(params!);
  }
}