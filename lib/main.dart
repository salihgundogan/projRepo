import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String displaytxt = '0';   // String olarak tanımlandı
  double numOne = 0;         // double olarak kalmalı
  double numTwo = 0;         // double olarak kalmalı
  String result = '';        // String olarak tanımlandı
  String finalResult = '';   // String olarak tanımlandı
  String opr = '';           // String olarak tanımlandı
  String preOpr = '';        // String olarak tanımlandı

  // Button Widget
  Widget calcbutton(String btntxt, Color btncolor, Color txtcolor) {
    return Container(
      child: ElevatedButton(
        onPressed: () {
          calculation(btntxt);
        },
        style: ElevatedButton.styleFrom(
          shape: CircleBorder(), // Dairesel buton şekli
          backgroundColor: btncolor, // Buton rengi
          padding: EdgeInsets.all(20), // İç boşluk
        ),
        child: Text(
          '$btntxt',
          style: TextStyle(
            fontSize: 35,
            color: txtcolor,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Calculator UI
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Calculator'),
        backgroundColor: Colors.black,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/assets/images/bjk.jpg'),  // Görselin yolu
            fit: BoxFit.cover,  // Görselin nasıl ölçekleneceği
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              // Calculator display
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        '$displaytxt', // String tipinde displaytxt
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 100,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  calcbutton('AC', Colors.grey, Colors.black),
                  calcbutton('+/-', Colors.grey, Colors.black),
                  calcbutton('%', Colors.grey, Colors.black),
                  calcbutton('/', Colors.amber, Colors.white),
                ],
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  calcbutton('7', Colors.grey, Colors.white),
                  calcbutton('8', Colors.grey, Colors.white),
                  calcbutton('9', Colors.grey, Colors.white),
                  calcbutton('x', Colors.amber, Colors.white),
                ],
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  calcbutton('4', Colors.grey, Colors.white),
                  calcbutton('5', Colors.grey, Colors.white),
                  calcbutton('6', Colors.grey, Colors.white),
                  calcbutton('-', Colors.amber, Colors.white),
                ],
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  calcbutton('1', Colors.grey, Colors.white),
                  calcbutton('2', Colors.grey, Colors.white),
                  calcbutton('3', Colors.grey, Colors.white),
                  calcbutton('+', Colors.amber, Colors.white),
                ],
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.fromLTRB(34, 20, 128, 20),
                        shape: StadiumBorder(),
                        backgroundColor: Colors.grey,
                      ),
                      onPressed: () {
                        calculation('0');
                      },
                      child: Text(
                        '0',
                        style: TextStyle(
                          fontSize: 35,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: calcbutton('.', Colors.grey, Colors.white),
                  ),
                  Expanded(
                    flex: 1,
                    child: calcbutton('=', Colors.amber, Colors.white),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            ],
          ),
        ),
      ),
    );
  }
  String add() {
    result = (numOne + numTwo).toString();
    numOne = double.parse(result); // Sonucu numOne'a atıyoruz
    return doesContainDecimal(result);
  }

  String sub() {
    result = (numOne - numTwo).toString();
    numOne = double.parse(result); // Sonucu numOne'a atıyoruz
    return doesContainDecimal(result);
  }

  String mul() {
    result = (numOne * numTwo).toString();
    numOne = double.parse(result); // Sonucu numOne'a atıyoruz
    return doesContainDecimal(result);
  }

  String div() {
    if (numTwo == 0) {
      return 'Error';  // Bölme hatası
    }
    result = (numOne / numTwo).toString();
    numOne = double.parse(result); // Sonucu numOne'a atıyoruz
    return doesContainDecimal(result);
  }
  String doesContainDecimal(dynamic result) {
    if (result.toString().contains('.')) {
      List<String> splitDecimal = result.toString().split('.');
      if (int.parse(splitDecimal[1]) == 0) {
        return splitDecimal[0];  // Sadece tam sayı kısmını döndür
      }
    }
    return result.toString();
  }

  // Calculator logic
  void calculation(String btnText) {
    if (btnText == 'AC') {
      // Temizleme işlemi
      displaytxt = '0';
      numOne = 0;
      numTwo = 0;
      result = '';
      finalResult = '0';
      opr = '';
      preOpr = '';
    } else if (opr == '=' && btnText == '=') {
      // Önceki işlem tamamlanmışsa sonucu hesapla
      if (preOpr == '+') {
        finalResult = add();
      } else if (preOpr == '-') {
        finalResult = sub();
      } else if (preOpr == 'x') {
        finalResult = mul();
      } else if (preOpr == '/') {
        finalResult = div();
      }
    } else if (btnText == '+' || btnText == '-' || btnText == 'x' || btnText == '/' || btnText == '=') {
      // İşlem yapılan buton (artı, eksi, çarpma, bölme)
      if (numOne == 0) {
        numOne = double.parse(result);
      } else {
        numTwo = double.parse(result);
      }

      // İşlem sonucu hesapla
      if (opr == '+') {
        finalResult = add();
      } else if (opr == '-') {
        finalResult = sub();
      } else if (opr == 'x') {
        finalResult = mul();
      } else if (opr == '/') {
        finalResult = div();
      }
      preOpr = opr;
      opr = btnText;
      result = '';
    } else if (btnText == '%') {
      // Yüzde hesaplama
      result = (numOne / 100).toString();
      finalResult = doesContainDecimal(result);
    } else if (btnText == '.') {
      // Ondalık işareti ekleme
      if (!result.toString().contains('.')) {
        result = result.toString() + '.';
      }
      finalResult = result;
    } else if (btnText == '+/-') {
      // Pozitif/negatif değiştir
      result = result.toString().startsWith('-')
          ? result.toString().substring(1)
          : '-' + result.toString();
      finalResult = result;
    } else {
      // Sayı tuşlarına basıldığında
      result = result + btnText;
      finalResult = result;
    }

    setState(() {
      displaytxt = finalResult;  // Hesaplanan sonucu ekranda göster
    });
  }

}
