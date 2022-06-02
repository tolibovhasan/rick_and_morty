import 'package:rick_and_morty/core/error/exaption.dart';
import 'package:rick_and_morty/core/platform/network_info.dart';
import 'package:rick_and_morty/feature/data/datasources/person_local_data_sources.dart';
import 'package:rick_and_morty/feature/data/datasources/person_remote_data_source.dart';
import 'package:rick_and_morty/feature/data/models/person_model.dart';
import 'package:rick_and_morty/feature/domain/entities/person_entities.dart';
import 'package:rick_and_morty/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:rick_and_morty/feature/domain/repository/person_repository.dart';

class PersonRepositoryImpl implements PersonRepository{
  final PersonRemoteDataSource remoteDataSource;
  final PersonLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  PersonRepositoryImpl(this.remoteDataSource, this.localDataSource, this.networkInfo);

  @override
  Future<Either<Failure, List<PersonEntity>>> getAllPersons(int page) async {
    return _getPersons(() {
      return remoteDataSource.getAllPersons(page);
    });
  }

  @override
  Future<Either<Failure, List<PersonEntity>>> searchPerson(String query) async {
     return _getPersons(() {
      return remoteDataSource.searchPerson(query);
    });
  }

  // ignore: unused_element
  Future<Either<Failure, List<PersonModel>>> _getPersons(Future<List<PersonModel>> Function() _getPersons) async {
    if(await networkInfo.isConnercted){
      try{
        final remotePerson = await _getPersons();
      localDataSource.personsToCache(remotePerson);
      return Right(remotePerson);
      } on ServerException{
        return Left(ServerFailure());
      }
    }else{
      try{
        final locationPerson = await localDataSource.getLastPersonsFromCache();
        return Right(locationPerson);
      } on CacheException{
        return Left(CacheFailure());
      }
    }
  }
  
}