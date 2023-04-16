import 'package:fpdart/fpdart.dart';
import 'package:taqyeemi/core/types/failure.dart';

typedef FutureEither<T> = Future<Either<Failure, T>>;
typedef FutureVoid = FutureEither<void>;