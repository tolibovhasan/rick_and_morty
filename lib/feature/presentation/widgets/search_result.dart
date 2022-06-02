import 'package:flutter/material.dart';
import 'package:rick_and_morty/feature/domain/entities/person_entities.dart';
import 'package:rick_and_morty/feature/presentation/pages/person_detail.dart';
import 'package:rick_and_morty/feature/presentation/widgets/person_cachedimage.dart';

class SearchResult extends StatelessWidget {
  const SearchResult({Key? key, required this.personResult}) : super(key: key);
  final PersonEntity personResult;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PersonDetailPage(person: personResult),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        elevation: 2.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              height: 300,
              // ignore: avoid_unnecessary_containers
              child: Container(
                child: PersonCacheImage(
                  imageUrl: personResult.image,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                personResult.name,
                style:
                    const TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                personResult.location.name,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
            )
          ],
        ),
      ),
    );
  }
}
