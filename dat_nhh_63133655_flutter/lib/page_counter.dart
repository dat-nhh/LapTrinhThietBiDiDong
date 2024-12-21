import 'package:dat_nhh_63133655_flutter/CounterState.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CounterStateProvider extends StatelessWidget {
  const CounterStateProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CounterState(),
      child: PageCounter2()
    );
  }
}

class PageCounter extends StatelessWidget {
  PageCounter({super.key});
  int value = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Ví dụ Provider"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: Text("+",style: TextStyle(fontSize: 50),),
              onPressed: () {
                // Đối tượng đc trả về bởi read chỉ được sử dụng trong các sự kiện
                var c = context.read<CounterState>();
                c.tang();
                value++;
              },
            ),
            Consumer<CounterState>(
                builder: (context, value, child) {
                  return Column(
                    children: [
                      Text('${value.count}',style: TextStyle(fontSize: 20),),
                      child?? Text("Chưa có widget"),
                    ],
                  );
                },
              child: Text("Not rebuild $value"),
            ),
            ElevatedButton(
              child: Text("-",style: TextStyle(fontSize: 20),),
              onPressed: () {
                var c = context.read<CounterState>();
                c.giam();
                value--;
              },
            ),
          ],
        ),
      ),
    );
  }
}

class PageCounter2 extends StatelessWidget {
  const PageCounter2({super.key});

  @override
  Widget build(BuildContext context) {
    //var c = context.watch<CounterState>();
    var c = Provider.of<CounterState>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Ví dụ 2 Provider"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: Text("+",style: TextStyle(fontSize: 20),),
              onPressed: () {
                var c = context.read<CounterState>();
                c.tang();
              },
            ),
            Text("${c.count}",style: TextStyle(fontSize: 50),),
            ElevatedButton(
              child: Text("-",style: TextStyle(fontSize: 20),),
              onPressed: () {
                var c = context.read<CounterState>();
                c.giam();
              },
            ),
          ],
        ),
      ),
    );
  }
}

