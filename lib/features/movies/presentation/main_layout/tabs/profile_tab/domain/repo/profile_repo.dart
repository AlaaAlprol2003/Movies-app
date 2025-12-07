import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../../../../../core/errors/errors/failure.dart';
import '../entities/user_profile_entity.dart';

@lazySingleton
abstract class ProfileRepo {

  Future<Either<Failure, UserProfileEntity>> getProfile();
}