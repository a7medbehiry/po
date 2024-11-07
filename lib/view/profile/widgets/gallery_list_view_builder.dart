import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pet_app/view/profile/data/models/get_all_pets_model/get_all_pets_model.dart';
import 'package:pet_app/view/profile/manager/add_gallery_cubit/add_gallery_cubit.dart';

class GalleryListViewBuilder extends StatefulWidget {
  const GalleryListViewBuilder({
    super.key,
    this.getAllPetsModel,
    this.onPetSelected,
    this.onSelected,
    this.selectedIndex = 0,
  });

  final GetAllPetsModel? getAllPetsModel;
  final Function(int petId)? onPetSelected;
  final Function(int index)? onSelected;
  final int selectedIndex;

  @override
  State<GalleryListViewBuilder> createState() => _GalleryListViewBuilderState();
}

class _GalleryListViewBuilderState extends State<GalleryListViewBuilder> {
  late int selectedIndex;
  List<File> galleryImages = [];

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.selectedIndex;
  }

  @override
  void didUpdateWidget(covariant GalleryListViewBuilder oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedIndex != widget.selectedIndex) {
      setState(() {
        selectedIndex = widget.selectedIndex;
      });
    }
  }

  Future<void> _addImageToGallery() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      final File selectedImage = File(image.path);

      final pet = widget.getAllPetsModel?.data?.pets?[selectedIndex];
      if (pet != null) {
        AddGalleryCubit.get(context).uploadGalleryPic(
          pic: selectedImage,
          id: pet.id!,
        );

        setState(() {
          galleryImages.add(selectedImage);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final pets =
        widget.getAllPetsModel?.data?.pets?[selectedIndex].petgallery ?? [];

    return ListView.builder(
      itemCount: pets.length + galleryImages.length + 1,
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        if (index == pets.length + galleryImages.length) {
          return GestureDetector(
            onTap: _addImageToGallery,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  width: 131,
                  height: 145,
                  color: const Color(0xFFE2E2E2),
                  child: const Center(
                    child: Icon(
                      Icons.add,
                      size: 30,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          );
        }

        if (index < pets.length) {
          final pet = pets[index];

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
                widget.onPetSelected?.call(pet.petId!);
                widget.onSelected?.call(index);
              });
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: SizedBox(
                  width: 131,
                  height: 145,
                  child: pet.image != null
                      ? Image.network(
                          'https://pet-app.webbing-agency.com/storage/app/public/${pet.image}',
                          fit: BoxFit.fill,
                        )
                      : const Icon(Icons.error),
                ),
              ),
            ),
          );
        }

        final imageIndex = index - pets.length;
        if (imageIndex < galleryImages.length) {
          final galleryImage = galleryImages[imageIndex];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: SizedBox(
                width: 131,
                height: 145,
                child: Image.file(
                  galleryImage,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          );
        }

        return Container();
      },
    );
  }
}
