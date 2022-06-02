import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/feature/domain/entities/person_entities.dart';
import 'package:rick_and_morty/feature/presentation/bloc/person_list_cubit/person_list_cubit.dart';
import 'package:rick_and_morty/feature/presentation/bloc/person_list_cubit/person_list_state.dart';
import 'package:rick_and_morty/feature/presentation/widgets/person_card.dart';


class PersonsList extends StatelessWidget {
   PersonsList({ Key? key }) : super(key: key);
  final scrollController = ScrollController();

  void setupScrollController(BuildContext context){
    scrollController.addListener(() {
      if(scrollController.position.atEdge){
        if(scrollController.position.pixels != 0){
          context.read<PersonListCubit>().loadPerson();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {  
    setupScrollController(context);
    return BlocBuilder<PersonListCubit, PersonState>(
      builder: (context, state){

        List<PersonEntity> persons = [];
        bool isLoading = false;

        if(state is PersonLoading && state.isFirstFetch){
          return _loadingIndicator();
        }
        else if(state is PersonLoading){
          persons = state.oldPersonList;
          isLoading = true;
        }
        else if(state is PersonLoaded){
          persons = state.personList;
        }else if(state is PersonError){
          return Center(
            child: Text(state.message, style: const TextStyle(fontSize: 25),),
          );
        }
        return ListView.separated(
          controller: scrollController,
          itemBuilder: (BuildContext context, index){
            if(index < persons.length){
            return PersonCard(person: persons[index]);
            } else{
              Timer(
                const Duration(milliseconds: 100),
                 (){
                   scrollController.jumpTo(scrollController.position.maxScrollExtent);
                 }
                 );
              return _loadingIndicator();
            }

          },
           separatorBuilder: (BuildContext context, index){
             return Divider(
               color: Colors.grey[400],
             );
           },
            itemCount: persons.length + (isLoading ? 1 : 0)
            );
      },
    );
  }

  Widget _loadingIndicator(){
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}