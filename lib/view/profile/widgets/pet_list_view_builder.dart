import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pet_app/components/constant.dart';
import 'package:pet_app/view/profile/data/models/get_all_pets_model/get_all_pets_model.dart';
import 'package:pet_app/view/profile/widgets/add_pet.dart';

class PetListViewBuilder extends StatefulWidget {
  final GetAllPetsModel? getAllPetsModel;
  final Function(int petId)? onPetSelected;
  final Function(int index)? onSelected;

  const PetListViewBuilder({
    super.key,
    required this.getAllPetsModel,
    this.onPetSelected,
    this.onSelected,
  });

  @override
  State<PetListViewBuilder> createState() => _PetListViewBuilderState();
}

class _PetListViewBuilderState extends State<PetListViewBuilder> {
  int _selectedIndex = 0;

  @override

  Widget build(BuildContext context) {
    final pets = widget.getAllPetsModel?.data?.pets ?? [];

    return ListView.builder(
      itemCount: pets.length + 1,
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        if (index == pets.length) {
          return GestureDetector(
            onTap: _addPet,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color(0xFFE2E2E2),
                    width: 0.0,
                  ),
                ),
                child: const Center(
                  child: Icon(
                    Icons.add,
                    size: 30,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          );
        }

        if (index < pets.length) {
          final pet = pets[index];
          bool isSelected = _selectedIndex == index;

          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedIndex = index;
                widget.onPetSelected?.call(pet.id!);
                widget.onSelected?.call(index);
              });
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected ? primaryColor : Colors.transparent,
                    width: isSelected ? 4.0 : 0.0,
                  ),
                ),
                child: ClipOval(
                  child: pet.picture != null
                      ? Image.network(
                          'https://pet-app.webbing-agency.com/storage/app/public/${pet.picture!}',
                          fit: BoxFit.fill,
                        )
                      : Image.asset('assets/images/default.jpg'),
                ),
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }

  void _addPet() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AddPet(),
      ),
    );
  }
}
