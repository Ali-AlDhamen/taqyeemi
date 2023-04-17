import 'package:fpdart/fpdart.dart';
import '../../../core/core.dart';

typedef FutureEither<T> = Future<Either<Failure, T>>;
typedef FutureVoid = FutureEither<void>;