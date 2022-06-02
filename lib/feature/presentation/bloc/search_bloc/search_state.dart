import 'package:equatable/equatable.dart';
import 'package:rick_and_morty/feature/domain/entities/person_entities.dart';

abstract class PersonSeachState extends Equatable{
  const PersonSeachState();

  @override
  List<Object?> get props => [];
}


class PersonSearchEmpty extends PersonSeachState{}

class PersonSearchLoading extends PersonSeachState{}

class PersonSearchLoaded extends PersonSeachState{
  final List<PersonEntity> persons;

  const PersonSearchLoaded({required this.persons});

  @override
  List<Object?> get props => [persons];
}


class PersonSearchError extends PersonSeachState{
  final String message;

  const PersonSearchError({required this.message});
}