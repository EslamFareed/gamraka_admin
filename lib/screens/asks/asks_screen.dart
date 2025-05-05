import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamraka_admin/core/utils/app_functions.dart';

import '../../core/utils/app_colors.dart';
import 'cubit/asks_cubit.dart';

class AsksScreen extends StatelessWidget {
  const AsksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AsksCubit.get(context).getAsks();
    return Scaffold(
      appBar: AppBar(title: Text("Asks")),
      body: BlocBuilder<AsksCubit, AsksState>(
        builder: (context, state) {
          if (state is LoadingAsksState) {
            return Center(child: CircularProgressIndicator());
          }

          final asks = AsksCubit.get(context).asks;
          return ListView.builder(
            padding: EdgeInsets.all(24),
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  title: Text(
                    """
Name : ${asks[index].user.name}
Phone : ${asks[index].user.phone}
idNumber : ${asks[index].user.idNumber}
Questions : ${asks[index].question}
Answer : ${asks[index].answer.isEmpty ? "No answer yet" : asks[index].answer}""",
                    style: TextStyle(fontSize: 13),
                  ),
                  trailing:
                      asks[index].answer.isNotEmpty
                          ? Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 20,
                            ),
                          )
                          : IconButton(
                            onPressed: () {
                              final globalKey = GlobalKey<FormState>();
                              final answerController = TextEditingController();
                              showModalBottomSheet(
                                context: context,
                                builder: (_) {
                                  return BottomSheet(
                                    onClosing: () {},
                                    builder: (_) {
                                      return Form(
                                        key: globalKey,
                                        child: Padding(
                                          padding: const EdgeInsets.all(24),
                                          child: Column(
                                            children: [
                                              //! ------------------- Answer ------------------!
                                              Row(children: [Text("Answer")]),
                                              SizedBox(height: 5),
                                              TextFormField(
                                                controller: answerController,
                                                decoration: InputDecoration(
                                                  hintText: "",
                                                  filled: true,
                                                  fillColor:
                                                      Colors.grey.shade200,
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          10,
                                                        ),
                                                    borderSide: BorderSide.none,
                                                  ),
                                                ),
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return "Answer is required";
                                                  }
                                                  return null;
                                                },
                                              ),
                                              SizedBox(
                                                height:
                                                    context.screenHeight * .05,
                                              ),

                                              BlocConsumer<
                                                AsksCubit,
                                                AsksState
                                              >(
                                                listener: (context, state) {
                                                  if (state
                                                      is ErrorReplyAsksState) {
                                                    context.showErrorSnack(
                                                      "Error, Please login again",
                                                    );
                                                  } else if (state
                                                      is SuccessReplyAsksState) {
                                                    context.showSuccessSnack(
                                                      "Replied Successfully",
                                                    );

                                                    Navigator.pop(context);
                                                  }
                                                },
                                                builder: (context, state) {
                                                  return state
                                                          is LoadingReplyAsksState
                                                      ? Center(
                                                        child:
                                                            CircularProgressIndicator(),
                                                      )
                                                      : MaterialButton(
                                                        onPressed: () {
                                                          if (globalKey
                                                              .currentState!
                                                              .validate()) {
                                                            AsksCubit.get(
                                                              context,
                                                            ).replyAsk(
                                                              asks[index].id,
                                                              answerController
                                                                  .text,
                                                            );
                                                          }
                                                        },
                                                        minWidth:
                                                            context.screenWidth,
                                                        height: 50,
                                                        color:
                                                            AppColors.primary,
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                4,
                                                              ),
                                                        ),
                                                        child: Text(
                                                          "Answer to ask",
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      );
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              );
                            },
                            icon: Icon(Icons.message),
                          ),
                  subtitle: Text(
                    asks[index].answer.isEmpty
                        ? "No answer yet"
                        : asks[index].answer,
                  ),
                ),
              );
            },
            itemCount: asks.length,
          );
        },
      ),
    );
  }
}
