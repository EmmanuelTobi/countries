import 'package:countries/utils/button.dart';
import 'package:countries/utils/colors.dart';
import 'package:countries/utils/expanding_view.dart';
import 'package:countries/utils/text.dart';
import 'package:countries/views/countries_home/countries_home_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

void modalBottomSheetMenu({
  required BuildContext context,
  double? radius,
  Widget? child,
  bool? isDismissible,
  double? height,
  Color? color}) {
  showModalBottomSheet(
      isDismissible: isDismissible ?? true,
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(radius ?? 10),
              topRight: Radius.circular(radius ?? 10)
          )
      ),
      backgroundColor: XColors.white(),
      builder: (builder) {
        return SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: height,
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: child,
          ),
        );
      }
  );
}

void listHelperPicker({
  required List<String?> listString,
  List<String?>? listString2,
  List<String?>? selectedListString,
  List<String?>? selectedListString2,
  ValueNotifier<List<String>>? valueNotifier,
  String? title,
  Function(String? selected, String? type)? selected,
  double? height,
  BuildContext? context,
  CountriesHomeViewModel? countriesHomeViewModel
}) {

  modalBottomSheetMenu(
    context: context!,
    child: SingleChildScrollView(
      child: ListDisplayView(
          listString: listString,
          listString2: listString2,
          selectedListString: selectedListString,
          selectedListString2: selectedListString2,
          valueNotifier: valueNotifier,
          title: title,
          selected: selected,
          height: height,
          countriesHomeViewModel: countriesHomeViewModel,
      ),
    ),
  );
}

class ListDisplayView extends StatelessWidget {

  ListDisplayView({
    super.key,
    this.listString,
    this.listString2,
    this.selectedListString,
    this.selectedListString2,
    this.valueNotifier,
    this.title,
    this.selected,
    this.height,
    this.context,
    this.countriesHomeViewModel,
  });

  List<String?>? listString;
  List<String?>? listString2;
  List<String?>? selectedListString;
  List<String?>? selectedListString2;
  ValueNotifier<List<String>>? valueNotifier;
  String? title;
  Function(String? selected, String? type)? selected;
  double? height;
  CountriesHomeViewModel? countriesHomeViewModel;
  BuildContext? context;

  @override
  Widget build(BuildContext context) {
    return Container(
      //height: 550,
      color: Colors.transparent,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              NormalText(
                text: title,
                fontWeight: FontWeight.w700,
                textColor: XColors.textColor(),
                fontSize: 15,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(Icons.close_rounded, size: 24,),
              )
            ],
          ),
          const SizedBox(height: 20),
          ExpandingContainer(
            context: context,
            actualHeight: 60,
            expandedHeight: 400,
            expand: false,
            title: NormalText(
              text: 'Continent',
              textColor: XColors.textColor(),
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
            body: ViewModelBuilder<CountriesHomeViewModel>.reactive(
                viewModelBuilder: () => countriesHomeViewModel ?? CountriesHomeViewModel(),
                disposeViewModel: false,
                builder: (context, model, child) {
                return SizedBox(
                  child: ListView.builder(
                    itemCount: listString!.length,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, index) {
                      return Padding(
                        padding:
                        const EdgeInsets.only(left: 0, top: 5, bottom: 0),
                        child: InkWell(
                          onTap: () {
                            selected!(listString![index], 'region');
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              NormalText(
                                text: listString![index],
                                textColor:  XColors.textColor().withOpacity(0.7),
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                              Checkbox(
                                activeColor: XColors.textColor(),
                                focusColor: XColors.textColor().withOpacity(0.3),
                                value: selectedListString!.contains(listString![index]),
                                onChanged: (bool? value) {
                                  selected!(listString![index], 'region');
                                },
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              }
            ),
          ),
          if(listString2!.isNotEmpty) ... [
            ExpandingContainer(
              context: context,
              actualHeight: 60,
              expandedHeight: 450,
              expand: false,
              title: NormalText(
                text: 'Timezone',
                textColor: XColors.textColor(),
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
              body: ViewModelBuilder<CountriesHomeViewModel>.reactive(
                  viewModelBuilder: () => countriesHomeViewModel ?? CountriesHomeViewModel(),
                  disposeViewModel: false,
                  builder: (context, model, child) {
                  return SizedBox(
                    child: ListView.builder(
                      itemCount: listString2!.length,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, index) {
                        return Padding(
                          padding:
                          const EdgeInsets.only(left: 0, top: 5, bottom: 0),
                          child: InkWell(
                            onTap: () {
                              selected!(listString2![index], 'gmt');
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                NormalText(
                                  text: listString2![index],
                                  textColor: XColors.textColor().withOpacity(0.7),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                                Checkbox(
                                  activeColor: XColors.textColor(),
                                  focusColor: XColors.textColor().withOpacity(0.3),
                                  value: selectedListString2!.contains(listString2![index]),
                                  onChanged: (bool? value) {
                                    selected!(listString2![index], 'gmt');
                                  },
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }
              ),
            ),
          ],
          const SizedBox(height: 10),
          Row(
            children: [
            XButton(
              onPressed: () {

              },
              text: 'Reset',
              isOutline: true,
              radius: 5,
              textColor: XColors.textColor(),
              height: 45,
              buttonColor: XColors.textColor(),
              width: 110,
            ),
            const SizedBox(width: 20,),
            Expanded(
              child: XButton(
                onPressed: () {

                },
                text: 'Show results',
                radius: 5,
                height: 45,
                buttonColor: Colors.deepOrangeAccent,
                width: 110,
              ),
            ),
          ],),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
