//import 'package:ecommerce_flutter/core/class/app_color.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
//import 'package:fluttertoast/fluttertoast.dart';

Widget DefaultButton({
  required String text,
  required final void Function()? function,
  //old code not working Function function, => because null safty
  bool isUperCase = true,
  double width = double.infinity,
  Color background = Colors.blue,
  double radius = 10.0,
}) =>
    Container(
      width: width,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      height: 45,
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: MaterialButton(
        splashColor: Colors.blue,
        onPressed: function,
        child: Text(
          isUperCase ? text.toUpperCase() : text,
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );

Widget ItemArticleBuilder(
  context, {
  required String url,
  required String? img,
  required String title,
  required String? date,
}) =>
    InkWell(
      onTap: () {
        /* Navigator.push(context, MaterialPageRoute(builder: (context) {
          return WebViewScreen(url: '$url');
        }));*/
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    image: DecorationImage(
                        image: img != null
                            ? NetworkImage(
                                '$img',
                              )
                            : NetworkImage(
                                'https://variety.com/wp-content/uploads/2021/04/Avatar.jpg'),
                        fit: BoxFit.cover))),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                height: 120,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                        child: Text(
                      "$title",
                      maxLines: 3,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                      overflow: TextOverflow.ellipsis,
                    )),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      '$date',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

Widget DefaultTextForm({
  required TextEditingController? controller,
  required String? labeltext,
  String? suffxtext,
  String? sufxBtn,
  String? Function(String?)? validate,
  String? Function(String?)? onSubmit,
  String? Function(String?)? onchange, //null-safety
  required TextInputType type,
  IconData? prefix,
  bool isPassword = false,
  IconData? suffixIcon,
  Function()? showPassfunc,
  Function()? onTap,
}) =>
    TextFormField(
      cursorColor: const Color.fromARGB(255, 39, 8, 8),
      style: const TextStyle(
        color: Color.fromARGB(255, 35, 19, 19),
        fontSize: 20,
      ),
      onTap: onTap,
      onChanged: onchange,
      obscureText: isPassword,
      onFieldSubmitted: onSubmit,
      validator: validate,
      textAlign: TextAlign.start,
      controller: controller,
      keyboardType: type,
      decoration: InputDecoration(
        errorStyle: TextStyle(
          color: Colors.red,
        ),
        suffixStyle: const TextStyle(color: Color.fromARGB(255, 39, 17, 17)),
        suffix: TextButton(
            onPressed: showPassfunc,
            child: Text(
              sufxBtn ?? '',
              style: const TextStyle(color: Colors.grey),
            )),
        suffixText: suffxtext,
        labelStyle: const TextStyle(
            overflow: TextOverflow.clip,
            color: Colors.grey,
            fontSize: 18,
            fontFamily: 'cairo',
            fontWeight: FontWeight.w600),
        focusedBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
          color: const Color.fromARGB(255, 74, 1, 1),
        )),
        hintStyle: TextStyle(
          color: Colors.grey,
          fontSize: 18,
        ),
        labelText: labeltext,
        border:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        floatingLabelAlignment: FloatingLabelAlignment.start,
        prefix: Icon(
          prefix,
        ),
        suffixIcon: suffixIcon != null
            ? IconButton(onPressed: showPassfunc, icon: Icon(suffixIcon))
            : null,
      ),
    );

void ShowToast({
  required String text,
  required ToastStates state,
}) =>
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP_RIGHT,
        timeInSecForIosWeb: 5,
        backgroundColor: chooseColorToast(state),
        textColor: Colors.white,
        fontSize: 16.0);

enum ToastStates { SUCCESS, WARNING, ERROR }

Color chooseColorToast(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}

Widget socialLogin({
  required IconData? iconData,
  required String text,
  Function()? onTap,
}) =>
    Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 50,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                iconData,
                size: 20,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                text,
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF82939E)),
              ),
            ],
          ),
        ),
      ),
    );

PreferredSizeWidget? DefaultAppBar({
  required BuildContext context,
  List<Widget>? actions,
  String? title,
  Widget? leading,
}) =>
    AppBar(
      actions: actions,
      title: Text('$title'),
      leading: leading,
      elevation: 0.0,
      scrolledUnderElevation: 0.0,
    );
