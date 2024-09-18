
import 'package:dartz/dartz.dart';
import 'package:spotify_bloc/core/usecase/usecase.dart';
// import 'package:spotify_bloc/data/repositories/songs/song_repo_impl.dart';

import '../../../service_locator.dart';
import '../../repositories/songs/songs.dart';

class GetPlayListUsecases implements UseCase<Either,dynamic>{
  @override
  Future<Either> call({params}) async{
    return await sl<SongsRepository>().getPlayList();
  }
}