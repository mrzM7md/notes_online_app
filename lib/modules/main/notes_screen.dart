import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_online_app/models/notes_model.dart';
import 'package:notes_online_app/modules/main/widgets/custom_build_note_item.dart';
import 'package:notes_online_app/modules/main/widgets/custom_search_button.dart';
import 'package:notes_online_app/shared/app_organization.dart';
import 'package:notes_online_app/shared/components/custom_build_appbar.dart';
import 'package:notes_online_app/shared/components/custom_title.dart';
import 'package:notes_online_app/shared/components/helper_methods.dart';
import 'package:notes_online_app/shared/cubit/cubit.dart';
import 'package:notes_online_app/shared/cubit/states.dart';
import 'package:notes_online_app/shared/style/colors.dart';
import 'package:notes_online_app/shared/texts/routes.dart';

class NotesScreen extends StatelessWidget {
  const NotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: BlocConsumer<AppCubit, AppStates>(
            listener: (BuildContext context, AppStates state) {
              if(state is DeleteNotesSuccessState){
                getToast(message: state.message,
                    bkgColor: Colors.greenAccent,
                    textColor: Colors.black
                );
              }
              else if(state is DeleteNotesFailState){
                getToast(message: state.message,
                    bkgColor: Colors.red,
                    textColor: Colors.black
                );
              }
            },
            builder: (BuildContext context, state) {
              var cubit = AppCubit.get(context);
              return Scaffold(
                  body: Container(
                      height: double.infinity,
                      padding: const EdgeInsetsDirectional.symmetric(
                          horizontal: 15.0),
                      color: AppOrganization.aoIsDarkMode
                          ? primaryDarkModeColor
                          : primaryLightModeColor,
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
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  CustomBuildAppbar(
                                    clickMode: () {
                                      cubit.changeAppMode();
                                    },
                                  ),
                                  const SizedBox(
                                    height: 50,
                                  ),
                                  CustomTitle(
                                    title: "ALL NOTES",
                                  ),
                                  // not add `const`, then will not work !!
                                  // const SizedBox(
                                  //   height: 20,
                                  // ),
                                  //
                                  // CustomSearchButton(
                                  //   onClick: () {
                                  //     navigateTo(context, SEARCH_ROUTE);
                                  //   },
                                  // ),

                                  const SizedBox(
                                    height: 20,
                                  ),
                                  FutureBuilder(
                                    future: cubit.getAllUserNotes(),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState == ConnectionState.waiting){
                                        return const Center(child: SingleChildScrollView());
                                      }
                                      else if(snapshot.hasError)
                                        return const Text("error");
                                      else if(snapshot.data == null)
                                        return const Text("Empty");
                                      else{
                                        List? data = snapshot.data;
                                        return
                                          ListView.separated(
                                              scrollDirection: Axis.vertical,
                                              shrinkWrap: true /* When i want to scroll as apart from screen.. */,
                                              itemCount: data!.length,
                                              separatorBuilder: (BuildContext context, int index) => const SizedBox(
                                                height: 15.0,
                                              ),
                                              physics: const NeverScrollableScrollPhysics(),
                                              itemBuilder:(BuildContext context, int index) {

                                                Note currentData = Note.view(data: {
                                                  "id": data[index]['id'],
                                                  "title": data[index]['title'],
                                                  "content": data[index]['content'],
                                                  "image": data[index]['image'],
                                                });

                                                return Dismissible(
                                                  key: ValueKey<int>(index),
                                                  direction: DismissDirection.endToStart,
                                                  confirmDismiss: (direction) async {
                                                    final bool res = await showDialog(
                                                        context: context,
                                                        builder: (BuildContext context) {
                                                          return AlertDialog(
                                                            content: Text("هل أنت متأكد أنك تريد حذف العنصر؟"),
                                                            actions: <Widget>[
                                                              MaterialButton(
                                                                child: Text(
                                                                  "إلغاء",
                                                                  style: TextStyle(color: Colors.black),
                                                                ),
                                                                onPressed: () {
                                                                  Navigator.of(context).pop(false);
                                                                },
                                                              ),
                                                              MaterialButton(
                                                                child: Text(
                                                                  "حذف",
                                                                  style: TextStyle(color: Colors.red),
                                                                ),
                                                                onPressed: () {
                                                                  Navigator.of(context).pop(true);
                                                                  cubit.deleteNote(noteId: data[index]['id'], noteImage: data[index]["image"]);
                                                                },
                                                              ),
                                                            ],
                                                          );
                                                        });
                                                    return res;
                                                  },
                                                  background: Container(
                                                    height: double.infinity,
                                                    color: Colors.red,
                                                    padding: const EdgeInsetsDirectional.only(end: 20.0),
                                                    alignment: AlignmentDirectional.centerEnd,
                                                    child: Icon(Icons.delete, color: Colors.white,),
                                                  ),
                                                  child: CustomBuildNoteItem(
                                                    note: currentData,
                                                    onTap: (){
                                                      cubit.setCurrentNote(currentData);
                                                      cubit.setImage(data[index]['image']);
                                                      navigateTo(context, UPDATE_NOTE_ROUTE);
                                                    },
                                                  ),

                                                );
                                              }


                                          );
                                      }

                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsetsDirectional.symmetric(
                                vertical: 20.0),
                            child: FloatingActionButton.extended(
                              label: const Text("New"),
                              icon: const Icon(CupertinoIcons.add),
                              onPressed: () {
                                cubit.setCurrentNote(null, isNewNode: true);
                                cubit.setImage("");
                                navigateTo(context, ADD_NOTE_ROUTE);
                              },
                            ),
                          )
                        ],
                      )));
            }));
  }
}
