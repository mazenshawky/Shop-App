import 'package:flutter/material.dart';

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  bool isUpperCase = true,
  double radius = 3.0,

  required void Function() function,
//required VoidCallback function,
  required String text,
}) =>
    Container(
      width: width,
      height: 40.0,
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: background,
      ),
    );

Widget defaultTextButton({
  required void Function() function,
  required String text,
}) =>
    TextButton(
      onPressed: function,
      child: Text(text.toUpperCase()),
    );

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  ValueChanged<String>? onSubmit,
  ValueChanged<String>? onChange,
  GestureTapCallback? onTap,
  bool isPassword = false,
  required FormFieldValidator<String> validate,
  required String label,
  required IconData prefix,
  IconData? suffix,
  VoidCallback? suffixPressed,
  bool isClickable = true,
}) => TextFormField(
  controller: controller,
  keyboardType: type,
  obscureText: isPassword,
  enabled: isClickable,
  onFieldSubmitted: onSubmit,
  onChanged: onChange,
  onTap: onTap,
  validator: validate,
  decoration: InputDecoration(
    labelText: label,
    prefixIcon: Icon(
      prefix,
    ),
    suffixIcon: suffix != null ? IconButton(
      onPressed: suffixPressed,
      icon: Icon(
        suffix,
      ),
    ) : null,
    border: OutlineInputBorder(),
  ),
);

PreferredSizeWidget defaultAppBar({
  required BuildContext context,
  String? title,
  List<Widget>? actions,
}) => AppBar(
  leading: IconButton(
    onPressed: ()
    {
      Navigator.pop(context);
    },
    icon: Icon(
      Icons.arrow_back_ios,
    ),
  ),
  titleSpacing: 0.0,
  title: Text(
    title!,
  ),
  actions: actions,
);

Widget buildTaskItem(Map model, context) => Dismissible(
  key: Key(model['id'].toString()),
  child: Padding(
    padding: EdgeInsets.all(20.0),
    child: Row(
      children:
      [
        CircleAvatar(
          radius: 40.0,
          child: Text(
            '${model['time']}',
          ),
        ),
        SizedBox(
          width: 20.0,
        ),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children:
            [
              Text(
                '${model['title']}',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${model['date']}',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: 20.0,
        ),
        IconButton(
            onPressed: ()
            {
              // AppCubit.get(context).updateData(
              //     status: 'done',
              //     id: model['id'],
              // );
            },
            icon: Icon(
              Icons.check_box,
              color: Colors.green,
            ),
        ),
        IconButton(
          onPressed: ()
          {
            // AppCubit.get(context).updateData(
            //   status: 'archive',
            //   id: model['id'],
            // );
          },
          icon: Icon(
            Icons.archive,
            color: Colors.black45,
          ),
        ),
      ],
    ),
  ),
  onDismissed: (direction)
  {
    // AppCubit.get(context).deleteData(id: model['id'],);
  },
);

Widget tasksBuilder({
  required List<Map> tasks,
}) => tasks.isNotEmpty ?
ListView.separated(
  itemBuilder: (context, index) =>
      buildTaskItem(tasks[index], context),
  separatorBuilder: (context, index) =>
      myDivider(),
  itemCount: tasks.length,
)
    : Center(
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Icon(
        Icons.menu,
        size: 100.0,
        color: Colors.grey,
      ),
      Text(
        'No Tasks Yet, Please Add Some Tasks',
        style: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
          color: Colors.grey,
        ),
      ),
    ],
  ),
);

Widget myDivider() => Padding(
  padding: EdgeInsetsDirectional.only(
    start: 20.0,
  ),
  child: Container(
    width: double.infinity,
    height: 1.0,
    color: Colors.grey[300],
  ),
);

Widget buildArticleItem(article, context) => InkWell(
  onTap: (){
    // navigateTo(context, WebViewScreen(article['url']),);
  },
  child: Padding(
    padding: EdgeInsets.all(20.0),
    child: Row(
      children: [
        Container(
          width: 120.0,
          height: 120.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0,),
            image: DecorationImage(
              image: NetworkImage('${article['urlToImage']}'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(
          width: 20.0,
        ),
        Expanded(
          child: Container(
            height: 120.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    '${article['title']}',
                    style: Theme.of(context).textTheme.bodyText1,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  '${article['publishedAt']}',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  ),
);

Widget articleBuilder(list, context, {isSearch = false}) => list.length > 0 ?
ListView.separated(
  physics: BouncingScrollPhysics(),
  itemBuilder: (context, index) => buildArticleItem(list[index], context),
  separatorBuilder: (context, index) => myDivider(),
  itemCount: list.length,
)
    : isSearch ?
Container()
    : Center(child: CircularProgressIndicator());

void navigateTo(context, widget) => Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
);

void navigateAndFinish(
    context, widget
    ) =>
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
        (route) => false,
);

void printFullText(String text)
{
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}