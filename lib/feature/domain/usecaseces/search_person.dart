import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:rick_and_morty/core/error/failure.dart';
import 'package:rick_and_morty/core/usecaseces/usecase.dart';
import 'package:rick_and_morty/feature/domain/entities/person_entities.dart';
import 'package:rick_and_morty/feature/domain/repository/person_repository.dart';


class SearchPerson extends UseCase<List<PersonEntity>, SearchPersonParams>{
  final PersonRepository personRepository;

  SearchPerson(this.personRepository);

 @override
  Future<Either<Failure, List<PersonEntity>>> call(SearchPersonParams params) async {
   return await personRepository.searchPerson(params.query);
 }
}


class SearchPersonParams extends Equatable{
  final String query;

  const SearchPersonParams({required this.query});
  @override
  List<Object?> get props => [query];
  
}