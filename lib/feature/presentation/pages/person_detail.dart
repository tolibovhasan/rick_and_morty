import 'package:flutter/material.dart';
import 'package:rick_and_morty/common/app_colors.dart';
import 'package:rick_and_morty/feature/domain/entities/person_entities.dart';
import 'package:rick_and_morty/feature/presentation/widgets/person_cachedimage.dart';

class PersonDetailPage extends StatelessWidget {
  const PersonDetailPage({Key? key, required this.person}) : super(key: key);
  final PersonEntity person;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Character'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 25,
            ),
            Text(
              person.name,
              style: const TextStyle(
                fontSize: 25,
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            // ignore: avoid_unnecessary_containers
            Container(
              child: PersonCacheImage(
                width: 260,
                height: 260,
                imageUrl: person.image,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                      color: person.status == 'Alive' ? Colors.green : Colors.red,
                      borderRadius: BorderRadius.circular(8),
                      ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  person.status,
                   style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
                maxLines: 1,
                )
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            if(person.type.isNotEmpty) ...buildText('Type:', person.type),
            ...buildText('Gender:', person.gender),
            ...buildText('Number of episode:', person.episode.length.toString()),
            ...buildText('Species:', person.species),
            ...buildText('Last know location:', person.location.name),
            ...buildText('Origin:', person.origin.name),
      
          ],
        ),
      ),
    );
  }
  List<Widget> buildText(String text, String value){
    return [
        Text(
            text,
             style: const TextStyle(
            color: AppColors.greyColor,
          ),
          ),
           const SizedBox(
            height: 4,
          ),
          Text(
            value,
             style: const TextStyle(
            color: Colors.white,
          ),
          ),
           const SizedBox(
            height: 12,
          ),
    ];
  }
}
