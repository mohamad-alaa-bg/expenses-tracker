import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transaction;
  final Function deleteTx;

  TransactionList(this.transaction, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: MediaQuery.of(context).size.height *0.7,
      // يجب تحديد طول الكونتينر الذي سوف نضع بداخله ال ListVew لانه لا ياخذ ما تبقى من الشاشة بشكل تلقائي وبالتالي يحدث مشكلة
      //تستخدم ال ListView children عندما يكون ليدنا عدد عناصر قليلة
      //اما في حال عدد العناصر غير معروف فيجب استخدما ListView.builder لانه يقوم فقط بتحميل في الذاكرة العناصر التي نشاهدها وبالتالي يحسن الاداء
      // هنا ليش هناك فائدة لتابع ال .map لانه يقوم بنفس الوظيفة حيث يكرر العملية على كل عناصر ال List
      child: transaction.isEmpty
          ? LayoutBuilder(
              builder: (context, constraints) {
                return Column(
                  children: <Widget>[
                    Text(
                      'No transaction added yet!',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: Image.asset(
                        'accsets/images/waiting.png',
                        fit: BoxFit.cover,
                      ),
                      height: constraints.maxHeight * 0.6,
                    ),
                  ],
                );
              },
            )
          : ListView.builder(
              itemCount: transaction.length,
              itemBuilder: (t, index) {
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 5,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                          padding: EdgeInsets.all(6),
                          child: FittedBox(
                              child: Text('\$${transaction[index].amount}'))),
                    ),
                    title: Text(
                      '${transaction[index].title}',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    subtitle: Text(
                      DateFormat.yMMMd().format(transaction[index].date),
                    ),
                    trailing: MediaQuery.of(context).size.width > 460
                        ? FlatButton.icon(
                            icon: Icon(Icons.delete),
                            label: Text("Delete"),
                            textColor: Theme.of(context).errorColor,
                            onPressed: () {
                              return deleteTx(transaction[index].id);
                            },
                          )
                        : IconButton(
                            icon: Icon(Icons.delete),
                            color: Theme.of(context).errorColor,
                            onPressed: () {
                              return deleteTx(transaction[index].id);
                            },
                          ),
                  ),
                );
              },
            ),
    );
  }
}
