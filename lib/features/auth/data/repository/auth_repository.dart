import 'package:appwrite/models.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/errors/base_app_exception.dart';
import '../../../../core/errors/server_exceptions.dart';
import '../../../../core/services/database_services/api/dio/auth_services.dart';
import '../models/login_request_model.dart';
import '../models/reset_password_model.dart';
import '../models/signup_model.dart';

abstract class AuthRepo {
  Future<Either<BaseAppException, User>> login({
    required LoginRequestModel loginRequestModel,
  });

  Future<Either<BaseAppException, User>> signUp({
    required SignUpModel signUpModel,
  });

  Future<Either<BaseAppException, String>> sendCode({
    required String email,
  });

  Future<Either<BaseAppException, String>> resetPassword({
    required ResetPasswordModel resetPasswordModel,
  });
}

class AuthRepoImpl implements AuthRepo {
  AuthServices authServices;

  AuthRepoImpl(this.authServices);

  @override
  Future<Either<BaseAppException, User>> login({
    required LoginRequestModel loginRequestModel,
  }) async {
    try {
      final User user = await authServices.login(
        loginRequestModel: loginRequestModel,
      );
      return Right(user);
    } on ServerExceptions catch (error) {
      return Left(error);
    }
  }

  @override
  Future<Either<BaseAppException, User>> signUp({
    required SignUpModel signUpModel,
  }) async {
    try {
      final User user = await authServices.signUp(
        signUpModel: signUpModel,
      );
      return Right(user);
    } on ServerExceptions catch (error) {
      return Left(error);
    }
  }

  @override
  Future<Either<BaseAppException, String>> sendCode({
    required String email,
  }) async {
    // Todo: implement sendCode
    throw UnimplementedError();
  }

  @override
  Future<Either<BaseAppException, String>> resetPassword({
    required ResetPasswordModel resetPasswordModel,
  }) async {
    // TODO: implement resetPassword
    throw UnimplementedError();
  }
}
