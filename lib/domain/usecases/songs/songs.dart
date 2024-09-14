
import 'package:dartz/dartz.dart';
import 'package:spotify_bloc/core/usecase/usecase.dart';
import 'package:spotify_bloc/data/repositories/songs/song_repo_impl.dart';

import '../../../service_locator.dart';

class GetNewSongsUsecases implements UseCase<Either,dynamic>{
  @override
  Future<Either> call({params}) async{
    return await sl<SongRepositoryImpl>().getNewSongs();
  }
}