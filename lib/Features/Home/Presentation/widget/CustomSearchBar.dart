import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parkingapp/Core/Shared_Widgets/TextInput.dart';
import 'package:parkingapp/Features/Home/Presentation/Manager/HomeCubit.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Textinput(
      hinttext: 'Search for a garage...',
      prefixicon: const Icon(Icons.search),
      onChanged: (query) {
        context.read<HomeCubit>().searchGarages(query);
      },
    );
  }
}
