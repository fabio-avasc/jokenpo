import 'package:flutter/material.dart';
import 'dart:math';
import 'package:fluttertoast/fluttertoast.dart';

class Jogo extends StatefulWidget {
  @override
  _JogoState createState() => _JogoState();
}

class _JogoState extends State<Jogo> {

  var _imagemApp = AssetImage("images/padrao.png");
  var _mensagem = "Escolha uma opção abaixo";

  // Placar
  var placarUsuario = 0;
  var placarApp = 0;

  //Achievements
  var _vitoria = 0;
  var _derrota = 0;
  var _empates = 0;
  var _sequencia = 0;
  var _jogos = 0;
  var _pedra = 0;
  var _paper = 0;
  var _tesoura = 0;

  //Seleção - ainda dá pra arrumar
  var _imagemSelecao = AssetImage("images/ultimo.png");
  var _imagemVazio = AssetImage("images/vetor.png");
  var _sel1 =  AssetImage("images/vetor.png");
  var _sel2 =  AssetImage("images/vetor.png");
  var _sel3 =  AssetImage("images/vetor.png");

  List _corConquista = [
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
  ];

  void _opcaoSelecionada(String escolhaUsuario){
    var opcoes = ["pedra", "papel", "tesoura"];
    var numero = Random().nextInt(3);
    var escolhaApp = opcoes[numero];


    print("Escolha do App: " + escolhaApp);
    print("Escolha do Usuário: " + escolhaUsuario);

    switch(escolhaApp){
      case "pedra": setState(() {
        this._imagemApp = AssetImage("images/pedra.png");
        });
        break;
      case "papel": setState(() {
        this._imagemApp = AssetImage("images/papel.png");
        });
        break;
      case "tesoura": setState(() {
        this._imagemApp = AssetImage("images/tesoura.png");
        });
        break;
    }

    switch(escolhaUsuario){
      case "pedra": setState(() {
        this._sel1 = _imagemSelecao;
        this._sel2 = _imagemVazio;
        this._sel3 = _imagemVazio;
      });
      break;
      case "papel": setState(() {
        this._sel2 = _imagemSelecao;
        this._sel1 = _imagemVazio;
        this._sel3 = _imagemVazio;
      });
      break;
      case "tesoura": setState(() {
        this._sel3 = _imagemSelecao;
        this._sel2 = _imagemVazio;
        this._sel1 = _imagemVazio;
      });
      break;
    }

    if(
        (escolhaUsuario == "pedra" && escolhaApp == "tesoura") ||
        (escolhaUsuario == "tesoura" && escolhaApp == "papel") ||
        (escolhaUsuario == "papel" && escolhaApp == "pedra")
    ){
        setState(() {
          this._mensagem = "Parabéns! Você ganhou!";
        });
        placarUsuario++;
        _vitoria++;
        _sequencia++;
        _jogos++;
        if(escolhaUsuario == "pedra"){_pedra++;};
        if(escolhaUsuario == "papel"){_paper++;};
        if(escolhaUsuario == "tesoura"){_tesoura++;};
    } else if(
        (escolhaApp == "pedra" && escolhaUsuario == "tesoura") ||
        (escolhaApp == "tesoura" && escolhaUsuario == "papel") ||
        (escolhaApp == "papel" && escolhaUsuario == "pedra")
    ){
      setState(() {
        this._mensagem = "Que pena! Você perdeu!";
      });
      placarApp++;
      _derrota++;
      _sequencia = 0;
      _jogos++;
    } else {
      setState(() {
        this._mensagem = "Deu empate!";
      });
      _sequencia = 0;
      _jogos++;
      _empates++;
    }

    // Validação dos Achievements //
    if(_derrota >= 50){
      this._corConquista[0] = Colors.teal;
    }
    if(_vitoria >= 50){
      this._corConquista[1] = Colors.lime;
    }
    if(_sequencia >= 3){
      this._corConquista[2] = Colors.blue;
    }
    if(_jogos >= 50){
      this._corConquista[3] = Colors.pink;
    }
    if(_jogos >= 100){
      this._corConquista[4] = Colors.deepPurple;
    }
    if(_pedra >= 15){
      this._corConquista[5] = Colors.green;
    }
    if(_paper >= 15){
      this._corConquista[6] = Colors.red;
    }
    if(_tesoura >= 15){
      this._corConquista[7] = Colors.indigo;
    }
    if(_empates >= 50){
      this._corConquista[8] = Colors.brown;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("JoKenPo"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 32, bottom: 16),
            child: Text(
              "Escolha do App",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
          Image(image: this._imagemApp),
          Padding(
            padding: EdgeInsets.only(top: 32, bottom: 16),
            child: Text(
              _mensagem,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
              ),
            ),
          ),


          //Imagens do Jokenpo do Usuário
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              GestureDetector(
                onTap: () => _opcaoSelecionada("pedra"),
                child: Image.asset("images/pedra.png", height: 100,)
              ),
              GestureDetector(
                onTap: () => _opcaoSelecionada("papel"),
                child: Image.asset("images/papel.png", height: 100)
              ),
              GestureDetector(
                onTap: () => _opcaoSelecionada("tesoura"),
                child: Image.asset("images/tesoura.png", height: 100)
              )
            ],
          ),


          //Indicador da seleção
          Padding(child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Image(image: _sel1, width: 100, height: 10),
                  Image(image: _sel2, width: 100, height: 10),
                  Image(image: _sel3, width: 100, height: 10)
                ],
              ),
              padding: EdgeInsets.only(top:10, bottom: 10)
          ),


          // Placar do Jogo
          Padding(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              child: Text(
                "Placar do jogo",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),
              ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 5, bottom: 3),
            child: Text(
              "Você: " + placarUsuario.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 2, bottom: 20),
            child: Text(
              "Aplicativo: " + placarApp.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal
            ),
            ),
          ),


          //Achievements
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              GestureDetector(
                  onTap: () => Fluttertoast.showToast(
                      msg: "Azarado: Você conseguiu um total de 50 derrotas.",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      backgroundColor: Colors.limeAccent,
                      textColor: Colors.black,
                      timeInSecForIos: 1,
                  ),
                  child: Icon(Icons.call_received, color: _corConquista[0])
              ),
              GestureDetector(
                  onTap: () => Fluttertoast.showToast(
                    msg: "Sortudo: Você conseguiu um total de 50 vitórias.",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: Colors.limeAccent,
                    textColor: Colors.black,
                    timeInSecForIos: 1,
                  ),
                  child: Icon(Icons.call_made, color: _corConquista[1])
              ),
              GestureDetector(
                  onTap: () => Fluttertoast.showToast(
                    msg: "Rei do Nada: Você conseguiu um total de 50 empates.",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: Colors.limeAccent,
                    textColor: Colors.black,
                    timeInSecForIos: 1,
                  ),
                  child: Icon(Icons.cancel, color: _corConquista[8])
              ),
              GestureDetector(
                  onTap: () => Fluttertoast.showToast(
                    msg: "Boa, Parça: Você conseguiu uma sequência de 3 vitórias seguidas!",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: Colors.limeAccent,
                    textColor: Colors.black,
                    timeInSecForIos: 1,
                  ),
                  child: Icon(Icons.thumb_up, color: _corConquista[2])
              ),
              GestureDetector(
                  onTap: () => Fluttertoast.showToast(
                    msg: "Persistente: Você alcançou uma sequência de 50 jogos feitos!",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: Colors.limeAccent,
                    textColor: Colors.black,
                    timeInSecForIos: 1,
                  ),
                  child: Icon(Icons.accessibility, color: _corConquista[3])
              ),
              GestureDetector(
                  onTap: () => Fluttertoast.showToast(
                    msg: "Contínuo: Você alcançou uma sequência de 100 jogos feitos!",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: Colors.limeAccent,
                    textColor: Colors.black,
                    timeInSecForIos: 1,
                  ),
                  child: Icon(Icons.visibility, color: _corConquista[4])
              ),
              GestureDetector(
                  onTap: () => Fluttertoast.showToast(
                    msg: "Picotador: Você ganhou 15 jogos usando a tesoura!",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: Colors.limeAccent,
                    textColor: Colors.black,
                    timeInSecForIos: 1,
                  ),
                  child: Icon(Icons.content_cut, color: _corConquista[5])
              ),
              GestureDetector(
                  onTap: () => Fluttertoast.showToast(
                    msg: "Colecionador de Papel: Você ganhou 15 jogos usando o papel!",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: Colors.limeAccent,
                    textColor: Colors.black,
                    timeInSecForIos: 1,
                  ),
                  child: Icon(Icons.photo_library, color: _corConquista[6])
              ),
              GestureDetector(
                  onTap: () => Fluttertoast.showToast(
                    msg: "Pedra Quente: Você ganhou 15 jogos usando a pedra!",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: Colors.limeAccent,
                    textColor: Colors.black,
                    timeInSecForIos: 1,
                  ),
                  child: Icon(Icons.whatshot, color: _corConquista[7])
              ),
            ],
          )
        ],
      ),

    );
  }
}
