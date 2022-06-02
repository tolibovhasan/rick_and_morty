import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/feature/domain/entities/person_entities.dart';
import 'package:rick_and_morty/feature/domain/usecaseces/search_person.dart';
import 'package:rick_and_morty/feature/presentation/bloc/search_bloc/search_bloc.dart';
import 'package:rick_and_morty/feature/presentation/bloc/search_bloc/search_events.dart';
import 'package:rick_and_morty/feature/presentation/bloc/search_bloc/search_state.dart';
import 'package:rick_and_morty/feature/presentation/widgets/search_result.dart';

class CustomSearchDelegate extends SearchDelegate{
  CustomSearchDelegate():super(searchFieldLabel: 'Search for characters...');
  
  // ignore: unused_field
  final _suggestions = [
    'Rick',
    'Morty',
    'Summer',
    'Beth',
    'Jerry'
  ];

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: (){
        query = '';
        showSuggestions(context);
      },
       icon: const Icon(Icons.clear),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      onPressed: () => close(context, null),
     icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // ignore: avoid_single_cascade_in_expression_statements
    BlocProvider.of<PersonSearchBloc>(context, listen: false)..add(SearchPersons(query));
    return BlocBuilder<PersonSearchBloc, PersonSeachState>(
      builder: (context, state){
        if(state is PersonSearchLoading){
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if(state is PersonSearchLoaded){
          final person = state.persons;
          if(person.isEmpty){
            return _showErrorText('No characters with that name found');
          }
          // ignore: avoid_unnecessary_containers
          return Container(
            child: ListView.builder(
              itemCount: person.isNotEmpty ? person.length : 0,
              itemBuilder: (context, index){
                PersonEntity result = person[index];
                return SearchResult(personResult: result);
              }
              ),
          );
        }else if(state is PersonSearchError){
          return _showErrorText(state.message);
        } else{
          return const Center(
            child: Icon(Icons.now_wallpaper),
          );
        }
      }
      );
  }

  Widget _showErrorText(String errorMessage){
    return Container(
      color: Colors.black,
      child: Text(
        errorMessage,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // ignore: prefer_is_empty
    if(query.length > 0){
      return Container();
    }
    return ListView.separated(
      padding: const EdgeInsets.all(10),
      itemBuilder: (context, index){
        return Text(
          _suggestions[index],
          style: const TextStyle(
            fontSize: 16
          ),
        );
      },
       separatorBuilder: (context, index){
         return const Divider();
       },
        itemCount: _suggestions.length
        );
  }
  
}