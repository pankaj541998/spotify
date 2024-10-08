import '../../../core/usecase/usecase.dart';
import '../../../service_locator.dart';
import '../../repositories/songs/songs.dart';

class IsFavouriteSongUsecase implements UseCase<bool,String>{
  @override
  Future<bool> call({String ? params}) async{
    return await sl<SongsRepository>().isFavouriteSong(params!);
  }
}