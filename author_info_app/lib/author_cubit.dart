
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'author_service.dart';

abstract class AuthorEvent extends Equatable {
  const AuthorEvent();

  @override
  List<Object?> get props => [];
}

class GetAuthorInfo extends AuthorEvent {
  final String authorName;

  const GetAuthorInfo(this.authorName);

  @override
  List<Object?> get props => [authorName];
}

abstract class AuthorState extends Equatable {
  const AuthorState();

  @override
  List<Object?> get props => [];
}

class AuthorInitial extends AuthorState {}

class AuthorLoading extends AuthorState {}

class AuthorLoaded extends AuthorState {
  final Map<String, dynamic> authorInfo;

  const AuthorLoaded(this.authorInfo);

  @override
  List<Object?> get props => [authorInfo];
}

class AuthorError extends AuthorState {
  final String errorMessage;

  const AuthorError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}


class AuthorCubit extends Cubit<AuthorState> {
  final AuthorService authorService = AuthorService();

  AuthorCubit() : super(AuthorInitial());

  Future<void> getAuthorInfo(String authorName) async {
    emit(AuthorLoading());

    try {
      final authorInfo = await authorService.getAuthorInfo(authorName);
      emit(AuthorLoaded(authorInfo));
    } catch (error) {
      emit(AuthorError('Failed to load author information'));
    }
  }
}
