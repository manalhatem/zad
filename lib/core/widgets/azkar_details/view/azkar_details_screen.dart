import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:zad/core/utils/colors.dart';
import 'package:zad/core/utils/my_navigate.dart';
import 'package:zad/core/utils/size.dart';
import 'package:zad/core/widgets/azkar_details/view/widgets/counter.dart';
import 'package:zad/core/widgets/azkar_details/view/widgets/text_container.dart';
import 'package:zad/core/widgets/custom_app_bar.dart';
import 'package:zad/core/widgets/custom_loading.dart';
import 'package:zad/core/widgets/orange_row.dart';

import '../../../../screens/azkar_sub/model/azkar_model.dart';
import '../../../../screens/supplications/model/supplications_model.dart';
import '../../../../screens/supplications/views/supplications_view.dart';
import '../../../local/app_cached.dart';
import '../../../local/cache_helper.dart';
import '../../../utils/base_state.dart';
import '../../../utils/dark_image.dart';
import '../../../utils/images.dart';
import '../controller/azkar_details_cubit.dart';
import 'widgets/next_widget.dart';

class AzkarDetailsScreen extends StatelessWidget {

  final String title;
 final bool? fromAzkar;
 final List<SupplicationData> list;
 final List<Azkar> listAzkar;
  final bool isFav;
  final int id;
  final ValueChanged? fun;

  const AzkarDetailsScreen({super.key, required this.title, this.fromAzkar, required this.list, required this.listAzkar, required this.isFav, required this.id, this.fun,});
  @override
  Widget build(BuildContext context) {
    int indexCount=0;
    return BlocProvider(
        create: (ctx) => AzkarDetailsCubit()..fetchFav(fav: isFav),
        child: BlocBuilder<AzkarDetailsCubit, BaseStates>(
        builder: (context, state) {
      final cubit = AzkarDetailsCubit.get(context);
         return   Scaffold(
         body: PopScope(
           canPop: true,
           onPopInvoked: (x)async{
             fun?.call('');
           },
           child: LayoutBuilder(
              builder: (ctx, constraints) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomAppBar(text: title.toString(),endWidget:
                    fromAzkar==true? state is DuhrLoadingState?
                    const CustomLoading(fullScreen: false,):
                    InkWell(
                      onTap: ()async{
                        cubit.toggleFav(id: id);
                      },
                      child:SvgPicture.asset(
                          cubit.isFav == true ? AppImages.fav:
                          CacheHelper.getData(key: AppCached.theme) == AppCached.darkTheme?
                          DarkAppImages.nofavDark:
                          AppImages.noFav,width: width()*0.09),
                    ):
                    SizedBox(width: width()*0.07),
                      onTap: (){
                      fromAzkar==true?
                          navigatorPop():
                      navigateAndReplace(widget: const SupplicationsScreen());
                    },),
                    Expanded(
                        child:PageView(
                            controller: cubit.pageViewController,
                            onPageChanged:(val){
                              cubit.pageChanged(i: val);
                              indexCount=val;
                              cubit.counter=0.0;
                            },
                            children: List.generate(
                              fromAzkar==true? listAzkar.length:
                              list.length,
                                  (index) => SingleChildScrollView(
                                    padding: EdgeInsets.symmetric(horizontal: width()*0.02),
                                physics: const BouncingScrollPhysics(),
                                child: ConstrainedBox(
                                  constraints: BoxConstraints(minHeight: height()*0.8),
                                  child: IntrinsicHeight(
                                    child: Column(
                                      children: [
                                        SizedBox(height: height()*0.02,),
                                        OrangeRow(
                                          originalFont: (){cubit.originalFont();},
                                            aPlusOnTap: (){cubit.plusFont();},
                                            aMinusOnTap: (){cubit.minusFont();},
                                            text:fromAzkar==true? listAzkar[index].text.toString(): list[index].name.toString()),
                                        TextContainer(text:
                                        fromAzkar==true? listAzkar[index].text.toString():
                                        list[index].name.toString(), fontSize: cubit.fontSize,
                                       ),
                                         Align(
                                           alignment: AlignmentDirectional.topStart,
                                           child: Text(
                                             fromAzkar==true? listAzkar[index].subDescription ?? '':
                                             list[index].source.toString(),
                                               style: TextStyle(
                                                   color: AppColors.greenColor,
                                                   fontSize: AppFonts.t18,fontFamily: "Amiri"
                                               ),),
                                         ),
                                        const Spacer(),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ))

                    ),
                    NextWidget(controller: cubit.pageViewController, currentIndex: cubit.currentIndex,
                        length: fromAzkar==true? listAzkar.length: list.length),
                    SizedBox(height: width()*0.01),
                    if(fromAzkar==true)
                    Center(
                             child: CounterAzkar(
                             count: listAzkar[indexCount].count!,
                             percent: cubit.counter,
                             onTap: (){cubit.addCounter(listAzkar[indexCount].count!);},
                             )),
                    SizedBox(height: width()*0.06),
                  ],
                );
              }
                   ),
         ),
      );}));



  }
}
