// ignore_for_file: constant_identifier_names
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/core/error/failure.dart';
import 'package:rick_and_morty/feature/domain/usecaseces/search_person.dart';
import 'package:rick_and_morty/feature/presentation/bloc/search_bloc/search_events.dart';
import 'package:rick_and_morty/feature/presentation/bloc/search_bloc/search_state.dart';

const SERVER_FAILURE_MESSAGE = 'Server Failure';
const CACHED_FAILURE_MESSAGE = 'Cache Failure';

class PersonSearchBloc extends Bloc<PersonSearchEvent, PersonSeachState> {
  final SearchPerson searchPerson;

  PersonSearchBloc({required this.searchPerson}) : super(PersonSearchEmpty()) {
    on<SearchPersons>((event, emit) async {
      emit(PersonSearchLoading());

      final failureOrPerson =
          await searchPerson(SearchPersonParams(query: event.personsQuery));
      emit(
        failureOrPerson.fold(
            (failure) =>
                PersonSearchError(message: _mapFailureToMessage(failure)),
            (person) => PersonSearchLoaded(persons: person)),
      );
    });
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHED_FAILURE_MESSAGE;
      default:
        return 'Unexpected Error';
    }
  }
}
