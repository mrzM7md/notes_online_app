import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_online_app/models/notes_model.dart';
import 'package:notes_online_app/modules/main/widgets/custom_build_note_item.dart';
import 'package:notes_online_app/modules/main/widgets/custom_simple_appbar.dart';
import 'package:notes_online_app/shared/app_organization.dart';
import 'package:notes_online_app/shared/components/custom_build_input.dart';
import 'package:notes_online_app/shared/components/helper_methods.dart';
import 'package:notes_online_app/shared/cubit/cubit.dart';
import 'package:notes_online_app/shared/cubit/states.dart';
import 'package:notes_online_app/shared/style/colors.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final FocusNode _searchFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {

    return SafeArea(
        child: BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, AppStates state) {

    },
    builder: (BuildContext context, state) {
          bool isDark = AppOrganization.aoIsDarkMode;
          TextEditingController searchContrller = TextEditingController();

          return Scaffold(
            appBar: CustomSimpleAppBar(context:context, isDark:isDark, title: 'Search For Note',),
            body: Container(
              height: double.infinity,
              color: isDark ? primaryDarkModeColor : primaryLightModeColor,
              child: Padding(
                padding: const EdgeInsetsDirectional.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomBuildInput(
                      textTitle: "",
                      focusNode: _searchFocusNode,
                      controller: searchContrller,
                      inputType: TextInputType.text,
                      hintInput: "Any litters you remember..",
                      prefixInputIcon: CupertinoIcons.search,
                      validate: (value) => getFieldErrorMessage("$value"),
                    ),
                    Expanded(
                      child: ListView.separated(
                        padding: const EdgeInsetsDirectional.only(top: 15.0),
                        scrollDirection: Axis.vertical,
                        physics: const BouncingScrollPhysics(),
                        separatorBuilder: (BuildContext context, int index) => const SizedBox(
                          height: 15.0,
                        ),
                        itemCount: 22,
                        itemBuilder:(BuildContext context, int index) => CustomBuildNoteItem(note: Note.view(data: {"title": "Title", "content": "Content"})),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
    }
    )
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _searchFocusNode.requestFocus());
  }

  @override
  void dispose() {
    _searchFocusNode.dispose();
    super.dispose();
  }

}
