import 'package:equatable/equatable.dart';

abstract class BlocError extends Equatable {
  const BlocError({
    required this.message,
  });

  final String message;

  @override
  List<Object> get props => [message];
}
