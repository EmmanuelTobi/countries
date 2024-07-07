import 'package:countries/utils/colors.dart';
import 'package:countries/utils/text.dart';
import 'package:countries/views/countries_home/countries_home_view_model.dart';
import 'package:flutter/material.dart';
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
          body: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [

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
