import 'package:spotify_bloc/domain/repositories/auth/auth_repo.dart';
import 'package:dartz/dartz.dart';

import '../../../core/usecase/usecase.dart';
import '../../../service_locator.dart';

class GetProfileUsecase extends UseCase<Either,dynamic> {
  @override
  Future<Either> call({params})async {
    return sl<AuthRepository>().getUser();
  }
}