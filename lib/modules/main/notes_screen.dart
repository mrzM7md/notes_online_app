import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_online_app/modules/main/widgets/custom_build_note_item.dart';
import 'package:notes_online_app/modules/main/widgets/custom_search_button.dart';
import 'package:notes_online_app/shared/app_organization.dart';
import 'package:notes_online_app/shared/components/custom_build_appbar.dart';
import 'package:notes_online_app/shared/components/custom_title.dart';
import 'package:notes_online_app/shared/cubit/cubit.dart';
import 'package:notes_online_app/shared/cubit/states.dart';
import 'package:notes_online_app/shared/style/colors.dart';

class NotesScreen extends StatelessWidget {
  const NotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: BlocConsumer<AppCubit, AppStates>(
          listener: (BuildContext context, AppStates state) {

          },
          builder: (BuildContext context, state) {
            var controller = AppCubit.get(context);
            return Scaffold(
                body: Container(
                height: double.infinity,
                padding: const EdgeInsetsDirectional.symmetric(horizontal: 15.0),
                color: AppOrganization.aoIsDarkMode ? primaryDarkModeColor : primaryLightModeColor,
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    SizedBox(
                      height: double.infinity,
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 15,),
                            CustomBuildAppbar(
                              clickMode: (){
                                controller.changeAppMode();
                              },
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                            CustomTitle(title: "ALL NOTES",), // not add `const`, then will not work !!
                            const SizedBox(
                              height: 20,
                            ),

                            CustomSearchButton(),

                            const SizedBox(
                              height: 20,
                            ),
                            ListView.separated(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true /* When i want to scroll as apart from screen.. */,
                              separatorBuilder: (BuildContext context, int index) => const SizedBox(
                                height: 15.0,
                              ),
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: 2,
                              itemBuilder:(BuildContext context, int index) => CustomBuildNoteItem(),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsetsDirectional.symmetric(vertical: 20.0),
                      child: FloatingActionButton.extended(
                        label: const Text("New"),
                        icon: const Icon(CupertinoIcons.add),
                        onPressed: (){

                        },
                      ),
                    )
                  ],
                )
              )
            );
          }

    )
    );
  }

}
