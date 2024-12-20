import 'package:dartz/dartz.dart';
import 'package:flutter_restapi/app/functions.dart';
import 'package:flutter_restapi/data/network/failure.dart';
import 'package:flutter_restapi/data/request/request.dart';
import 'package:flutter_restapi/data/responses/responses.dart';
import 'package:flutter_restapi/domain/model/model.dart';
import 'package:flutter_restapi/domain/repository/repository.dart';
import 'package:flutter_restapi/domain/usecase/base_usecase.dart';

class LoginUseCase
    implements BaseUseCase<LoginUseCaseInput, Authentication> {
  Repository _repository;

  LoginUseCase(this._repository);


  @override
  Future<Either<Failure, Authentication>> execute(LoginUseCaseInput input) async {
    DeviceInfo deviceInfo = await getDeviceDetails();

    return await _repository.login(LoginRequest(
        input.email, input.password, "", ""));
  }
}

class LoginUseCaseInput {
  String email;
  String password;

  LoginUseCaseInput(this.email, this.password);
}


