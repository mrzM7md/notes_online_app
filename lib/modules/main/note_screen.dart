import 'dart:io';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:notes_online_app/models/notes_model.dart';
import 'package:notes_online_app/modules/main/widgets/custom_build_image.dart';
import 'package:notes_online_app/modules/main/widgets/custom_simple_appbar.dart';
import 'package:notes_online_app/shared/style/colors.dart';
import 'package:notes_online_app/shared/texts/routes.dart';

import '../../shared/app_organization.dart';
import '../../shared/components/customButton.dart';
import '../../shared/components/custom_build_input.dart';
import '../../shared/components/custom_title.dart';
import '../../shared/components/helper_methods.dart';
import '../../shared/cubit/cubit.dart';
import '../../shared/cubit/states.dart';

class NoteScreen extends StatelessWidget {
  const NoteScreen({
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<AppCubit, AppStates>(
          listener: (BuildContext context, AppStates state) {
            if(state is AddEditNotesSuccessState){
              getToast(message: state.message,
                  bkgColor: Colors.greenAccent,
                  textColor: Colors.black
              );
              navigateTo(context, NOTES_ROUTE);
            }
            else if(state is AddEditNotesFailState){
              getToast(message:state.message,
                  bkgColor: Colors.red,
                  textColor: Colors.white
              );
            }
          },

          builder: (BuildContext context, AppStates state) {
            TextEditingController
            titleController = TextEditingController(),
                contentController = TextEditingController();

            var cubit = AppCubit.get(context);
            var formKey = GlobalKey<FormState>();
            bool isDark = AppOrganization.aoIsDarkMode;

            Note currentNote = cubit.getCurrentNote();

            int? id = currentNote.id;
            String? title = currentNote.title;
            String? content = currentNote.content;
            String? image = currentNote.image;

            titleController.text = title!;
            contentController.text = content!;

            return Scaffold(
              appBar: CustomSimpleAppBar(
                context: context,
                isDark: isDark,
                title: title.isEmpty ? "*_-" : title,
              ),
              body: Container(
                height: double.infinity,
                color: isDark ? primaryDarkModeColor : primaryLightModeColor,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.all(20.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 50,
                          ),
                          CustomTitle(
                            title: title.isEmpty ? "New Note !" : "Edit Note !",
                          ),
                          // not add `const`, then will not work !!
                          const SizedBox(
                            height: 20,
                          ),

                          CustomBuildImage(
                            image: cubit.getImage(),
                            onTap: (){
                              showModalBottomSheet(
                                  context: context,
                                  builder: (context) => Container(
                                    color: isDark ? primaryDarkModeColor : primaryLightModeColor ,
                                    child: SizedBox(
                                      height: 165.0,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsetsDirectional.only(start: 10.0),
                                              child: Text("Choose an Image From",
                                                  style: TextStyle(
                                                    fontSize: 22.0,
                                                    color: isDark ? secondaryDarkModeColor : secondaryLightModeColor
                                                  ),
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: MaterialButton(
                                                      onPressed: () async {
                                                        XFile? xFile = await ImagePicker()
                                                            .pickImage(
                                                            source: ImageSource.camera);
                                                        File imageFile = File(xFile!.path);
                                                        cubit.setImage(imageFile);
                                                      },

                                                    height: 120.0,
                                                    child: Icon(
                                                        Icons.camera_alt_rounded,
                                                      color: isDark ? secondaryDarkModeColor : secondaryLightModeColor,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: MaterialButton(
                                                    onPressed: () async {
                                                      XFile? xFile = await ImagePicker()
                                                          .pickImage(
                                                          source: ImageSource.gallery);
                                                      File imageFile = File(xFile!.path);
                                                      cubit.setImage(imageFile);
                                                    },
                                                    height: 120.0,
                                                    child: Icon(
                                                        Icons.image,
                                                      color: isDark ? secondaryDarkModeColor : secondaryLightModeColor,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                              );
                            },
                          ),

                          const SizedBox(
                            height: 20,
                          ),
                          CustomBuildInput(
                            textTitle: "",
                            controller: titleController,
                            inputType: TextInputType.text,
                            hintInput: "note title",
                            prefixInputIcon: Icons.title_outlined,
                            validate: (value) =>
                                getFieldErrorMessage("$value"),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomBuildInput(
                            textTitle: "",
                            controller: contentController,
                            inputType: TextInputType.multiline,
                            hintInput: "note content",
                            prefixInputIcon: FontAwesomeIcons.a,
                            validate: (value) =>
                                getFieldErrorMessage("$value"),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          ConditionalBuilder(
                              condition: state is AddEditNotesLoadingState,
                              builder: (ctx) => const Center(child: CircularProgressIndicator()),
                              fallback: (ctx) =>  CustomButton(
                                  text: title.isEmpty ? "Add" : "Update",
                                  onPressed: () {
                                    if (isEveryFieldsValidated(formKey)) {
                                      String currentTitle = titleController.text;
                                      String currentContent = contentController.text;
                                      if(title == currentTitle && currentContent == content && cubit.getImage() is String){
                                        back(context);
                                      }
                                      else {
                                        cubit.setNote(title: currentTitle, content: currentContent, lastImageName: image!.isEmpty ? "^" : image  ,  id: id ?? -1);
                                      }
                                    }
                                  },
                              ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
