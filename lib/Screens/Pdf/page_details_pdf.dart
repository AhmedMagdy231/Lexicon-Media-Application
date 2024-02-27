import 'package:education_application/Components/Text/text.dart';
import 'package:education_application/Cubits/App%20Cubit/app_cubit.dart';
import 'package:education_application/Cubits/App%20Cubit/app_cubit.dart';
import 'package:education_application/Screens/Pdf/view_pdf.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../Components/components.dart';
import '../../Constant/Colors/colors.dart';
import '../Play Audio/play_audio_screen.dart';

class PdfScreens extends StatelessWidget {
  const PdfScreens({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Scaffold(

          body: cubit.pageDetailsModel!.data!.downloadablePagesFiles!.length ==0?
          buildNoItem(
            width,
            height,
            name: 'assets/icons/pdf.svg',
            text: 'لا يوجد ملفات بعد',

          ): Column(
            children: [

              buildContainerStack(height: height, width: width, context: context, text: 'الملفات'),
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisExtent: height * 0.26,
                      crossAxisCount: 2,
                      crossAxisSpacing: width*0.03,
                      mainAxisSpacing: 2
                  ),
                  itemCount: cubit.pageDetailsModel!.data!.downloadablePagesFiles!.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        navigateTo(
                          context,
                            PDFViewerScreen(
                              pdfPath: cubit.pageDetailsModel!.data!.downloadablePagesFiles![index].pagesfileFilename!,
                            ),
                        );
                      },
                      child: buildItem(width, height, cubit, index),
                    );
                  },

                ),
              ),
            ],
          ),
        );
      },
    );
  }
  Padding buildItem(double width, double height, AppCubit cubit, int index) {
    return Padding(
      padding: EdgeInsets.all(width * 0.02),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: height * 0.15,
              width: width * 0.3,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: SvgPicture.asset(
                'assets/icons/pdf.svg',
                width: width*0.35,
                color: Colors.red,
              ),

            ),
            SizedBox(
              height: height * 0.02,
            ),
            BuildText(
              text: cubit.pageDetailsModel!.data!.downloadablePagesFiles![index].pagesfileTitle!,
              size: 13,
              bold: true,
              center: true,
            ),
          ],
        ),
      ),
    );
  }
}
