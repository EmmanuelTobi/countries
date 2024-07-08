import 'package:countries/utils/colors.dart';
import 'package:countries/utils/decorator.dart';
import 'package:countries/utils/text.dart';
import 'package:countries/views/countries_home/countries_home_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stacked/stacked.dart';

class CountryDetailsView extends StatelessWidget {
  const CountryDetailsView({
    super.key,
    this.countriesHomeViewModel
  });

  final CountriesHomeViewModel? countriesHomeViewModel;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CountriesHomeViewModel>.reactive(
        viewModelBuilder: () => countriesHomeViewModel ?? CountriesHomeViewModel(),
        disposeViewModel: false,
        builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(model.currentPickedData!.name!),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(22.0),
              child: Column(
                children: [

                  Stack(
                    children: [
                      Container(
                        height: 230,

                        child: PageView(
                          controller: model.pageController,
                          onPageChanged: model.onPageChanged,
                          children: model.pages(
                              img1: model.currentPickedData!.flag,
                              img2: model.currentPickedData!.coatOfArms,
                              img3: ''
                          )!,
                        ),
                      ),
                      Positioned(
                        top: 10,
                        bottom: 10,
                        left: 10,
                        right: 10,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                          GestureDetector(
                            onTap: (){
                              model.onPageChangeWithUserTap(action: 'back');
                            },
                            child: Container(
                                decoration: BoxDecorators.containerDecoration(
                                    outlineWidth: 1,
                                    radius: 34,
                                    color: XColors.textColor().withOpacity(0.3),
                                    outlineColor: XColors.textColor().withOpacity(0.1)
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(Icons.arrow_back_ios_new_rounded, size: 16,),
                                )
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              model.onPageChangeWithUserTap(action: 'forward');
                            },
                            child: Container(
                                decoration: BoxDecorators.containerDecoration(
                                    outlineWidth: 1,
                                    color: XColors.textColor().withOpacity(0.3),
                                    radius: 34,
                                    outlineColor: XColors.textColor().withOpacity(0.1)
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(Icons.arrow_forward_ios_rounded, size: 16,),
                                )
                            ),
                          ),
                        ],),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20,),
                  Column(children: [
                    DisplayLineInfo(
                      title: 'Population:',
                      text: model.currentPickedData!.population.toString(),
                    ),
                    DisplayLineInfo(
                      title: 'Region:',
                      text: model.currentPickedData!.region,
                    ),
                    DisplayLineInfo(
                      title: 'Capital:',
                      text: model.currentPickedData!.capital!.isNotEmpty ? model.currentPickedData!.capital![0] : '',
                    ),
                    const DisplayLineInfo(
                      title: 'Motto:',
                      text: '',
                    )
                  ],),
                  const SizedBox(height: 30,),
                  Column(children: [
                    DisplayLineInfo(
                      title: 'Official language:',
                      text: model.currentPickedData!.languages!.lang ?? '',
                    ),
                    const DisplayLineInfo(
                      title: 'Ethic group:',
                      text: '',
                    ),
                    const DisplayLineInfo(
                      title: 'Religion:',
                      text: '',
                    ),
                    const DisplayLineInfo(
                      title: 'Government:',
                      text: '',
                    )
                  ],),
                  const SizedBox(height: 30,),
                  Column(children: [
                    const DisplayLineInfo(
                      title: 'Independence:',
                      text: '',
                    ),
                    DisplayLineInfo(
                      title: 'Area:',
                      text: model.currentPickedData!.area.toString(),
                    ),
                    const DisplayLineInfo(
                      title: 'Currency:',
                      //text: model.currentPickedData!.currencies[(model.currentPickedData!.currencies).key]['name'],
                      //text: model.currentPickedData!.currencies.toString(),
                      text: ''
                    ),
                    const DisplayLineInfo(
                      title: 'GDP:',
                      text: '',
                    )
                  ],),
                  const SizedBox(height: 30,),
                  Column(children: [
                    DisplayLineInfo(
                      title: 'Time zone:',
                      text: model.currentPickedData!.timezones!.last,
                    ),
                    const DisplayLineInfo(
                      title: 'Date format:',
                      text: 'dd/mm/yy',
                    ),
                    DisplayLineInfo(
                      title: 'Dialling code:',
                      text: model.currentPickedData!.callingcode,
                    ),
                    DisplayLineInfo(
                      title: 'Driving side:',
                      text: model.currentPickedData!.car!.side,
                    )
                  ],),

                ],
              ),
            ),
          ),
        );
      }
    );
  }
}

class DisplayLineInfo extends StatelessWidget {

  const DisplayLineInfo({
    super.key,
    this.title,
    this.text
  });

  final String? title;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      NormalText(
        text: title,
        textColor: XColors.textColor(),
        fontSize: 16,
      ),
      const SizedBox(width: 10,),
      NormalText(
        text: text,
        textColor: XColors.textColor().withOpacity(0.5),
        fontSize: 16,
      )
    ],);
  }

}
