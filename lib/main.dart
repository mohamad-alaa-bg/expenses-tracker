import 'package:flutter/material.dart';
import './models/transaction.dart';
import './Widgets/new_transaction.dart';
import './Widgets/transaction_list.dart';
import './Widgets/chart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home',
      theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.amber,
          fontFamily: 'Quicksand',
          textTheme: ThemeData.light().textTheme.copyWith(
                bodyText1: TextStyle(
                  fontFamily: 'Quicksand',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                bodyText2: TextStyle(
                  fontFamily: 'Quicksand',
                ),
                subtitle1: TextStyle(
                  fontFamily: 'Quicksand',

                ),
                button: TextStyle(color: Colors.white,),// هنا في حال لم نذكر نوع الخط ياخد الافتراضي الذي في الاعلى
              ),
          appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                  headline6: TextStyle(
                    fontFamily: 'OpenSans',
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
          )),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransaction = [
//    Transaction(
//      id: 't1',
//      title: 'Food',
//      amount: 90.99,
//      date: DateTime.now(),
//    ),
//    Transaction(
//      id: 't2',
//      title: 'sport',
//      amount: 50.01,
//      date: DateTime.now(),
//    ),
  ];

  List<Transaction> get _recentTransaction {
    return _userTransaction
        .where(
          (tx) => tx.date.isAfter(DateTime.now().subtract(Duration(days: 7))),
        )
        .toList();
  }

  void _addNewTransaction(String txTitle, double txAmount) {
    final newTx = Transaction(
      title: txTitle,
      amount: txAmount,
      date: DateTime.now(),
      id: DateTime.now().toString(),
    );

    setState(() {
      _userTransaction.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(child: NewTransaction(_addNewTransaction));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Expenses'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.add,
            ),
            onPressed: () => _startAddNewTransaction(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        // قمنا باضافة سكرول لان عندما نستخد الكيبورد يصبح هناك مشكلة بسبب ضغط العناصر اما في حال وضعنا السكرول
        // فنصبح قادرين على تحريك الشاشة للاعلى والادنىى
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
// mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              width: double.infinity,
              child: Chart(_recentTransaction),
            ),
            TransactionList(_userTransaction),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
