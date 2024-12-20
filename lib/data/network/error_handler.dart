import 'package:dio/dio.dart';
import 'package:flutter_restapi/data/network/failure.dart';

enum DataSource{
  SUCCESS,
  NO_CONTENT,
  BAD_REQUEST,
  FORBIDDEN,
  UNATHORISED,
  NOT_FOUND,
  INTERNAL_SERVER_ERROR,
  CONNECT_TIMEOUT,
  RECEIVE_TIMEOUT,
  CANCEL,
  SEND_TIMEOUT,
  CACHE_ERROR,
  DEFAULT,
  NO_INTERNET_CONNECTION,
  CONNECTION_ERROR,
  BAD_CERTIFICATE
}

class ResponseCode{
  // Api status error
  static const int SUCCESS = 200;
  static const int NO_CONTENT = 201;
  static const int BAD_REQUEST = 400;
  static const int FORBIDDEN = 403;
  static const int UNAUTHORISED = 401;
  static const int NOT_FOUND = 404;
  static const int INTERNAL_SERVER_ERROR = 500;


  //local error
  static const int DEFAULT = -1;
  static const int CONNECT_TIMEOUT = -2;
  static const int CANCEL = -3;
  static const int RECEIVE_TIMEOUT = -4;
  static const int SEND_TIMEOUT = -5;
  static const int CACHE_ERROR = -6;
  static const int NO_INTERNET_CONNECTION = -7;
  static const int CONNECTION_ERROR = -8;
  static const int BAD_CERTIFICATE = -9;


}

class ErrorHandler implements Exception {
  late Failure failure;

  ErrorHandler.handle(dynamic error){
    if (error is DioException) {
      failure = _handlerError(error);
    }
    else {
      failure = DataSource.DEFAULT.getFailure();
    }
    print(error.toString());
  }

    Failure _handlerError(DioException error) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
          return DataSource.CONNECT_TIMEOUT.getFailure();
        case DioExceptionType.sendTimeout:
          return DataSource.SEND_TIMEOUT.getFailure();
        case DioExceptionType.receiveTimeout:
          return DataSource.RECEIVE_TIMEOUT.getFailure();
        case DioExceptionType.badResponse:
          switch (error.response?.statusCode) {
            case ResponseCode.BAD_REQUEST:
              return DataSource.BAD_REQUEST.getFailure();
            case ResponseCode.FORBIDDEN:
              return DataSource.FORBIDDEN.getFailure();
            case ResponseCode.UNAUTHORISED:
              return DataSource.UNATHORISED.getFailure();
            case ResponseCode.NOT_FOUND:
              return DataSource.NOT_FOUND.getFailure();
            case ResponseCode.INTERNAL_SERVER_ERROR:
              return DataSource.INTERNAL_SERVER_ERROR.getFailure();
            default:
              return DataSource.DEFAULT.getFailure();
          }
        case DioExceptionType.cancel:
          return DataSource.CANCEL.getFailure();
        case DioExceptionType.unknown:
          return DataSource.DEFAULT.getFailure();
        case DioExceptionType.badCertificate:
          return DataSource.DEFAULT.getFailure();
        case DioExceptionType.connectionError:
          return DataSource.CONNECTION_ERROR.getFailure();

      }
    }
  }




extension DataSourceExtension on DataSource {
  Failure getFailure() {
    switch (this) {
      case DataSource.BAD_REQUEST:
        return Failure(ResponseCode.BAD_REQUEST, ResponseMessage.BAD_REQUEST);
      case DataSource.FORBIDDEN:
        return Failure(ResponseCode.FORBIDDEN, ResponseMessage.FORBIDDEN);
      case DataSource.UNATHORISED:
        return Failure(ResponseCode.UNAUTHORISED, ResponseMessage.UNATHORISED);
      case DataSource.NOT_FOUND:
        return Failure(ResponseCode.NOT_FOUND, ResponseMessage.NOT_FOUND);
      case DataSource.INTERNAL_SERVER_ERROR:
        return Failure(ResponseCode.INTERNAL_SERVER_ERROR,
            ResponseMessage.INTERNAL_SERVER_ERROR);
      case DataSource.CONNECT_TIMEOUT:
        return Failure(
            ResponseCode.CONNECT_TIMEOUT, ResponseMessage.CONNECT_TIMEOUT);
      case DataSource.CANCEL:
        return Failure(ResponseCode.CANCEL, ResponseMessage.CANCEL);
      case DataSource.RECEIVE_TIMEOUT:
        return Failure(
            ResponseCode.RECEIVE_TIMEOUT, ResponseMessage.RECEIVE_TIMEOUT);
      case DataSource.SEND_TIMEOUT:
        return Failure(ResponseCode.SEND_TIMEOUT, ResponseMessage.SEND_TIMEOUT);
      case DataSource.CACHE_ERROR:
        return Failure(ResponseCode.CACHE_ERROR, ResponseMessage.CACHE_ERROR);
      case DataSource.NO_INTERNET_CONNECTION:
        return Failure(ResponseCode.NO_INTERNET_CONNECTION,
            ResponseMessage.NO_INTERNET_CONNECTION);
      case DataSource.DEFAULT:
        return Failure(ResponseCode.DEFAULT, ResponseMessage.DEFAULT);

      case DataSource.CONNECTION_ERROR:
        return Failure(ResponseCode.CONNECTION_ERROR, ResponseMessage.CONNECTION_ERROR);

      case DataSource.BAD_CERTIFICATE:
        return Failure(ResponseCode.BAD_CERTIFICATE, ResponseMessage.BAD_CERTIFICATE);

      default:
        return Failure(ResponseCode.DEFAULT, ResponseMessage.DEFAULT);
    }
  }
}



class ResponseMessage{
  // Api status error
  static const String SUCCESS = "Success";
  static const String NO_CONTENT = "Success with no content";
  static const String BAD_REQUEST = "Bad Request, Try again later";
  static const String FORBIDDEN = "Forbidden request, try again later";
  static const String UNATHORISED = "User is unauthorized, try again later";
  static const String NOT_FOUND = "Url is not found, try again later";
  static const String INTERNAL_SERVER_ERROR = "Something went wrong, try again later";


  //local error
  static const String DEFAULT = "Something went wrong, try again later";
  static const String CONNECT_TIMEOUT = "Time out error, try again later";
  static const String CANCEL = "Request was cancelled, try again later";
  static const String RECEIVE_TIMEOUT = "time our error, try again later";
  static const String SEND_TIMEOUT = "time out error, try again later";
  static const String CACHE_ERROR = "Cache error, try again later";
  static const String NO_INTERNET_CONNECTION = "Please check your internet connection";
  static const String BAD_CERTIFICATE = "Please check your internet connection";
  static const String CONNECTION_ERROR = "Please check your internet connection";

}

class ApiInternalStatus{
  static const int SUCCESS = 0;
  static const int FAILURE = 1;
}