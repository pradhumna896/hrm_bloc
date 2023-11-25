import 'package:flutter/material.dart';

import '../../core/constants/session_manager.dart';

class AppExceptions implements Exception {
  final _message;
  final _prefix;

  AppExceptions([this._message, this._prefix]);

  @override
  String toString() {
    return "$_prefix$_message";
  }
}

class InternalServerException extends AppExceptions {
  InternalServerException([String? message]) : super(message, "Error: ");
}

class BadRequestException extends AppExceptions {
  BadRequestException([String? message]) : super(message, "Invalid Request: ");
}

class UnauthorizedException extends AppExceptions {
  UnauthorizedException([String? message]) : super(message, '');
}

class NoInternetException extends AppExceptions {
  NoInternetException([String? message]) : super(message, "No Internet: ");
}

class RequestTimeOut extends AppExceptions {
  RequestTimeOut([String? message]) : super(message, "Request Time Out: ");
}

class UnAutherized extends AppExceptions {
    UnAutherized([String? message]) : super(message, "Request Time Out: ");
}
