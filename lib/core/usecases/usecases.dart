import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_weather_app/core/errors/errors.dart';

abstract class UseCase<Type, Params> {
  const UseCase();
  Future<Either<Failure, Type>> call(Params params);
}

abstract class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}
