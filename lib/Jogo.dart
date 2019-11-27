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
  var _sequenciaVitoria = 0;
  var _sequenciaEmpate = 0;
  var _sequenciaDerrota = 0;
  var _jogos = 0;
  var _pedra = 0;
  var _paper = 0;
  var _tesoura = 0;
  var _tesouraSeq = 0;
  var _pedraSeq = 0;
  var _papelSeq = 0;
  List _diferentes = [false, false, false];


  //Seleção - ainda dá pra arrumar
  var _imagemSelecao = AssetImage("images/ultimo.png");
  var _imagemVazio = AssetImage("images/vetor.png");
  var _sel1 =  AssetImage("images/vetor.png");
  var _sel2 =  AssetImage("images/vetor.png");
  var _sel3 =  AssetImage("images/vetor.png");

  List _corConquista = [
    Colors.white, //[0]
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white, //[10]
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white, //[18]
  ];


  // BOTÃO DE RESET
  void _reset(){
    setState(() {
      _vitoria = 0; _empates = 0; _derrota = 0; _sequenciaDerrota = 0;
      _sequenciaEmpate = 0; _sequenciaVitoria = 0; _jogos = 0; _pedra = 0; _paper = 0;
      _tesoura = 0; _pedraSeq = 0; _papelSeq = 0; _tesouraSeq = 0; _diferentes = [false, false, false];
      placarApp = 0; placarUsuario = 0; _sel1 =  _imagemVazio; _sel2 =  _imagemVazio; _sel3 =  _imagemVazio;
      _mensagem = 'Escolha uma opção abaixo'; _imagemApp = AssetImage("images/padrao.png");
      _corConquista = [
        Colors.white, Colors.white, Colors.white,
        Colors.white, Colors.white, Colors.white,
        Colors.white, Colors.white, Colors.white,
        Colors.white, Colors.white, Colors.white,
        Colors.white, Colors.white, Colors.white,
        Colors.white, Colors.white, Colors.white,
        Colors.white, Colors.white,
      ];
    });
  }


  // REGRAS DO NEGÓCIO
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
        _sequenciaVitoria++;
        _sequenciaEmpate = 0;
        _sequenciaDerrota = 0;
        _jogos++;
        if(escolhaUsuario == "pedra"){
          _pedra++; _pedraSeq++; _papelSeq = 0; _tesouraSeq = 0;
          if (_diferentes[0] == false){ _diferentes[0] = true;}
          else {_diferentes = [false, false, false];}
          print(_diferentes);
        }
        if(escolhaUsuario == "papel"){
          _paper++; _papelSeq++; _pedraSeq = 0; _tesouraSeq = 0;
          if (_diferentes[1] == false){ _diferentes[1] = true;}
          else {_diferentes = [false, false, false];}
          print(_diferentes);
        }
        if(escolhaUsuario == "tesoura"){
          _tesoura++; _tesouraSeq++; _pedraSeq = 0; _papelSeq = 0;
          if (_diferentes[2] == false){ _diferentes[2] = true;}
          else {_diferentes = [false, false, false];}
          print(_diferentes);
        }
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
      _sequenciaVitoria = 0;
      _sequenciaEmpate = 0;
      _sequenciaDerrota++;
      _jogos++;
      _diferentes = [false, false, false];
      print(_diferentes);
    } else {
      setState(() {
        this._mensagem = "Deu empate!";
      });
      _sequenciaVitoria = 0;
      _sequenciaEmpate++;
      _sequenciaDerrota = 0;
      _jogos++;
      _empates++;
      _diferentes = [false, false, false];
      print(_diferentes);
    }

    // Validação dos Achievements //
    if(_derrota >= 50){  //50 Derrotas
      this._corConquista[0] = Colors.teal;
    }
    if(_vitoria >= 50){ //50 Vitórias
      this._corConquista[1] = Colors.lime;
    }
    if(_sequenciaVitoria >= 3){  //3 Vitórias em Sequencia
      this._corConquista[2] = Colors.blue;
    }
    if(_jogos >= 50){ // 50 jogos
      this._corConquista[3] = Colors.pink;
    }
    if(_jogos >= 100){ // 100 Jogos
      this._corConquista[4] = Colors.deepPurple;
    }
    if(_tesoura >= 15){ // 15 Vitórias usando tesoura
      this._corConquista[5] = Colors.green;
    }
    if(_paper >= 15){  // 15 Vitórias usando Papel
      this._corConquista[6] = Colors.red;
    }
    if(_pedra >= 15){ // 15 Vitórias usando Pedra
      this._corConquista[7] = Colors.indigo;
    }
    if(_empates >= 50){  // 50 Empates
      this._corConquista[8] = Colors.brown;
    }


    // Segunda linha dos Achievements //
    if(_vitoria > _derrota + 10) {  // 10 vitórias de vantagem
      this._corConquista[9] = Colors.blue;
    }
    // ---------- Achievement 11, Cor 10 - 60 jogos em 60 segundos -------------//

    if(_jogos >= 500){ // 500 jogos
      this._corConquista[11] = Colors.blueGrey;
    }
    if (_diferentes[1] == true && _diferentes[2] == true && _diferentes[0] == true){ // 3 vitórias seguidas com três simbolos diferentes
      this._corConquista[12] = Colors.greenAccent;
    }
    if(_sequenciaVitoria >= 5){  // 5 Vitórias Seguidas
      this._corConquista[13] = Colors.lime;
    }
    if(_tesouraSeq >= 3){ // 3 Vitórias Seguidas com a tesoura
      this._corConquista[14] = Colors.amber;
    }
    if(_pedraSeq >= 3){ // 3 Vitórias Seguidas com a pedra
      this._corConquista[15] = Colors.amber;
    }
    if(_papelSeq >= 3){ // 3 Vitórias Seguidas com o papel
      this._corConquista[16] = Colors.amber;
    }
    if(_papelSeq >= 3){ // 3 Vitórias Seguidas com o papel
      this._corConquista[16] = Colors.amber;
    }
    if(_sequenciaEmpate >= 3) { //3 Empates em Sequencia
      this._corConquista[17] = Colors.indigoAccent;
    }
    if(_sequenciaDerrota >= 5) { //5 Derrotas em Sequencia
      this._corConquista[18] = Colors.yellow;
    }


  }

  //Início do Scaffold
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(30.0),
        child: AppBar(
          title: Text("JoKenPo",
            style: TextStyle(
                fontSize: 15,
                color: Colors.blue,
            ),
          ),
          elevation: 0,
          backgroundColor: Colors.white,
          bottomOpacity: 10,
          centerTitle: true,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 15, bottom: 10),
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
                  Image(image: _sel1, width: 100, height: 5, fit: BoxFit.cover),
                  Image(image: _sel2, width: 100, height: 5, fit: BoxFit.cover),
                  Image(image: _sel3, width: 100, height: 5, fit: BoxFit.cover)
                ],
              ),
              padding: EdgeInsets.only(top:10, bottom: 10)
          ),


          // Placar do Jogo

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 0),
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
                    padding: EdgeInsets.only(top: 5, bottom: 1),
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
                ],
              ),
              Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 2, bottom: 20),
                    child: Text(
                      "Jogos Realizados: " + _jogos.toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal
                      ),
                    ),
                  ),
                ],
              )
            ],
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
          ),
          Padding(padding: EdgeInsets.only(top: 5, bottom: 5)),

          //Segunda linha de Achievements
          Row(

            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              GestureDetector(
                  onTap: () => Fluttertoast.showToast(
                    msg: "Acelerado: Abriu distância de 10 vitórias de vantagem.",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: Colors.limeAccent,
                    textColor: Colors.black,
                    timeInSecForIos: 1,
                  ),
                  child: Icon(Icons.arrow_forward, color: _corConquista[9])
              ),
              GestureDetector(
                  onTap: () => Fluttertoast.showToast(
                    msg: "60dps, Dedos Furiosos: Você concluiu 60 jogos em 60 segundos ou menos [AINDA POR FAZER].",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: Colors.limeAccent,
                    textColor: Colors.black,
                    timeInSecForIos: 1,
                  ),
                  child: Icon(Icons.fingerprint, color: _corConquista[10])
              ),
              GestureDetector(
                  onTap: () => Fluttertoast.showToast(
                    msg: "Procastinador: Você alcançou uma sequência de 500 jogos.",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: Colors.limeAccent,
                    textColor: Colors.black,
                    timeInSecForIos: 1,
                  ),
                  child: Icon(Icons.sentiment_satisfied, color: _corConquista[11])
              ),
              GestureDetector(
                  onTap: () => Fluttertoast.showToast(
                    msg: "Ousadia e Alegria: Conseguiu 3 vitórias seguidas com 3 símbolos diferentes.",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: Colors.limeAccent,
                    textColor: Colors.black,
                    timeInSecForIos: 1,
                  ),
                  child: Icon(Icons.add_location, color: _corConquista[12])
              ),
              GestureDetector(
                  onTap: () => Fluttertoast.showToast(
                    msg: "Snipper: Você conseguiu 5 vitórias seguidas!",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: Colors.limeAccent,
                    textColor: Colors.black,
                    timeInSecForIos: 1,
                  ),
                  child: Icon(Icons.terrain, color: _corConquista[13])
              ),
              GestureDetector(
                  onTap: () => Fluttertoast.showToast(
                    msg: "Nazaré Tedesco: Você conseguiu uma sequência de 3 vitórias com a tesoura!",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: Colors.limeAccent,
                    textColor: Colors.black,
                    timeInSecForIos: 1,
                  ),
                  child: Icon(Icons.content_cut, color: _corConquista[14])
              ),
              GestureDetector(
                  onTap: () => Fluttertoast.showToast(
                    msg: "Apedrejador: Você conseguiu uma sequência de 3 vitórias com a pedra!",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: Colors.limeAccent,
                    textColor: Colors.black,
                    timeInSecForIos: 1,
                  ),
                  child: Icon(Icons.whatshot, color: _corConquista[15])
              ),
              GestureDetector(
                  onTap: () => Fluttertoast.showToast(
                    msg: "Escritório: Você conseguiu uma sequência de 3 vitórias com o papel!",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: Colors.limeAccent,
                    textColor: Colors.black,
                    timeInSecForIos: 1,
                  ),
                  child: Icon(Icons.photo_library, color: _corConquista[16])
              ),
              GestureDetector(
                  onTap: () => Fluttertoast.showToast(
                    msg: "Tite: Você conseguiu 3 empates seguidos.",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: Colors.limeAccent,
                    textColor: Colors.black,
                    timeInSecForIos: 1,
                  ),
                  child: Icon(Icons.trending_flat, color: _corConquista[17])
              ),
              GestureDetector(
                  onTap: () => Fluttertoast.showToast(
                    msg: "Estágiarios no Pembas: Você teve 5 derrotas seguidas.",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: Colors.limeAccent,
                    textColor: Colors.black,
                    timeInSecForIos: 1,
                  ),
                  child: Icon(Icons.trending_flat, color: _corConquista[18])
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(top: 5, bottom: 20),
                  child: RaisedButton(
                    onPressed: (){_reset();},
                    color: Colors.indigoAccent,
                    child: Text(
                      "Reiniciar o Jogo",
                      style: TextStyle(color: Colors.white),
                    ),
                  )
              )
            ],
          )
        ],
      ),

    );
  }
}
