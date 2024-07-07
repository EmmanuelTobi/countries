import 'package:countries/models/country_data_model.dart';
import 'package:countries/utils/colors.dart';
import 'package:countries/utils/decorator.dart';
import 'package:countries/utils/extensions.dart';
import 'package:countries/utils/inputs_field.dart';
import 'package:countries/utils/navigator_handler.dart';
import 'package:countries/utils/text.dart';
import 'package:countries/views/countries_home/countries_home_view_model.dart';
import 'package:countries/views/countries_home/country_details_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked/stacked.dart';

class CountriesHome extends StatelessWidget {
  const CountriesHome({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CountriesHomeViewModel>.reactive(
        viewModelBuilder: () => CountriesHomeViewModel(),
        onViewModelReady: (model) => model.initialise(),
        builder: (context, model, child) {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  CountriesHeaderView(
                    onSearchInput: (s) {
                      model.getCountriesFiltered(s: s!);
                    },
                    onFilterTap: () {

                    },
                    onLanguageTap: () {

                    },
                  ),
                  const SizedBox(height: 15,),
                  ...List.generate(model.letters!.length, (index) {

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        NormalText(
                          text: model.letters![index],
                          textColor: XColors.textColor(),
                          fontSize: 14,
                        ),

                        ...List.generate(model.getCountriesAlphabetically(letter: model.letters![index])!.length, (i) {

                          return CountriesListBuild(
                            image: model.getCountriesAlphabetically(letter: model.letters![index])![i].flag,
                            country: model.getCountriesAlphabetically(letter: model.letters![index])![i].name ?? 'Country',
                            capital: model.getCountriesAlphabetically(letter: model.letters![index])![i].capital!.isNotEmpty ? model.getCountriesAlphabetically(letter: model.letters![index])![i].capital![0] : '',
                            onCountryTap: () {
                              model.updateCurrentCountryModal(cmodel: model.getCountriesAlphabetically(letter: model.letters![index])![i]);
                              navigate(context, CountryDetailsView(countriesHomeViewModel: model,));
                            },
                          );

                        }),

                      ],
                    );

                  }),

                ],
              ),
            ),
          );
        },
    );
  }
}

class CountriesListBuild extends ViewModelWidget<CountriesHomeViewModel> {

  const CountriesListBuild({
    super.key,
    this.image,
    this.country,
    this.capital,
    this.onCountryTap
  });

  final String? image;
  final String? country;
  final String? capital;
  final Function? onCountryTap;

  @override
  Widget build(BuildContext context, viewModel) {
    return GestureDetector(
      onTap: () => onCountryTap!(),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Row(children: [
          if(image != null) ... [
            ClipRRect(
              borderRadius: BorderRadius.circular(7),
              child: SizedBox(
                height: 40,
                width: 50,
                child: SvgPicture.network(
                  image!,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ],
          const SizedBox(width: 15,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            NormalText(
              text: country,
              textColor: XColors.textColor(),
              fontSize: 14,
            ),
            NormalText(
              text: capital,
              textColor: XColors.textColor().withOpacity(0.3),
              fontSize: 14,
            )
          ],),
        ],),
      ),
    );
  }

}

class CountriesHeaderView extends ViewModelWidget<CountriesHomeViewModel> {

  const CountriesHeaderView({
    super.key,
    this.onSearchInput,
    this.onLanguageTap,
    this.onFilterTap
  });

  final Function(String? s)? onSearchInput;
  final Function? onLanguageTap;
  final Function? onFilterTap;

  @override
  Widget build(BuildContext context, viewModel) {
    return Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
        SizedBox(
          width: 110,
          child: SvgPicture.asset(
            'explore'.toSVG(),
            fit: BoxFit.contain,
          ),
        ),
        const SizedBox(height: 10,),
        Center(
          child: SizedBox(
            height: 24,
            width: 24,
            child: SvgPicture.asset(
              'light'.toSVG(),
              fit: BoxFit.contain,
            ),
          ),
        ),
      ],),
      const SizedBox(height: 15,),
      MainInputField(
        hint: "Search Country",
        isEnabled: true,
        onChanged: onSearchInput!,
      ),
      const SizedBox(height: 15,),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
        Container(
          height: 40,
          width: 73,
          decoration: BoxDecorators.containerDecoration(
              hasOutline: true,
              outlineWidth: 1,
              radius: 4,
              outlineColor: XColors.textColor().withOpacity(0.1)
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 24,
                width: 24,
                child: SvgPicture.asset(
                  'language'.toSVG(),
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(width: 10,),
              NormalText(
                text: 'EN',
                textColor: XColors.textColor(),
                fontSize: 12,
              )
            ],
          ),
        ),
        Container(
          height: 40,
          width: 86,
          decoration: BoxDecorators.containerDecoration(
              hasOutline: true,
              outlineWidth: 1,
              radius: 4,
              outlineColor: XColors.textColor().withOpacity(0.1)
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 24,
                width: 24,
                child: SvgPicture.asset(
                  'filter'.toSVG(),
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(width: 10,),
              NormalText(
                text: 'Filter',
                textColor: XColors.textColor(),
                fontSize: 12,
              )
            ],
          ),
        ),
      ],),
    ],);
  }

}

class OnFilterSelectionView extends ViewModelWidget<CountriesHomeViewModel> {

  const OnFilterSelectionView({
    super.key,
    this.onFilterSelected
  });

  final Function(String? s)? onFilterSelected;

  @override
  Widget build(BuildContext context, CountriesHomeViewModel viewModel) {
    return Column(children: [

    ],);
  }

}

class ExpandingContainer extends StatefulWidget {

  ExpandingContainer({
    super.key,
    this.context,
    this.title,
    this.actualHeight,
    this.expandedHeight,
    this.expand = false,
    this.body
  });

  final BuildContext? context;
  final Widget? title;
  final Widget? body;
  final bool? expand;
  double? actualHeight = 20;
  final double? expandedHeight;

  @override
  State<ExpandingContainer> createState() => _ExpandingContainerState();
}

class _ExpandingContainerState extends State<ExpandingContainer> {

  ValueNotifier<bool>? containerExpandedState;

  @override
  void initState() {
    containerExpandedState = ValueNotifier(widget.expand!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: containerExpandedState!,
        builder: (context, dynamic value, child) {
          return AnimatedContainer(
            color: XColors.background(),
            height: widget.actualHeight,
            curve: Curves.fastOutSlowIn,
            duration: const Duration(seconds: 1),
            child: Column(children: [
              GestureDetector(
                onTap: () {
                  if(value == true) {
                    containerExpandedState!.value = false;
                    widget.actualHeight = 50;
                  } else {
                    containerExpandedState!.value = true;
                    widget.actualHeight = widget.expandedHeight;
                  }
                },
                child: Row(
                  children: [
                    Expanded(
                      child: widget.title!,
                    ),
                    Icon(Icons.keyboard_arrow_down_rounded, size: 26, color: XColors.textColor(),),
                  ],
                ),
              ),
              const SizedBox(height: 15,),
              containerExpandedState!.value != false ? Flexible(child: widget.body!) : Container(),
            ],),
          );
        }
    );
  }
}

