import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isTurnO = true;
  int filledBoxes = 0;
  bool gameHasResult = false;

  int scoreX = 0;
  int scoreO = 0;

  String winnerTitle = '';
  List<String> xOrOList = ['', '', '', '', '', '', '', '', ''];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'TicTacToe',
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.grey[900],
        actions: [
          IconButton(
            onPressed: () {
              gameReset();
            },
            icon: Icon(Icons.refresh),
          )
        ],
      ),
      backgroundColor: Colors.grey[900],
      body: SafeArea(
        child: Column(
          children: [
            getScoreBoard(),
            SizedBox(height: 10.0),
            getResultButton(),
            SizedBox(height: 10.0),
            getGridView(),
            getTurn(),
          ],
        ),
      ),
    );
  }

  Widget getResultButton() {
    return Visibility(
      visible: gameHasResult,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          primary: Colors.white,
          side: BorderSide(color: Colors.white, width: 2.0),
        ),
        onPressed: () {
          setState(() {
            gameHasResult = false;
            gameReset();
          });
        },
        child: Text(
          '$winnerTitle, play again!',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget getTurn() {
    return Text(
      isTurnO ? 'Turn O' : 'Turn X',
      style: TextStyle(
        color: Colors.white,
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget getGridView() {
    return Expanded(
      child: GridView.builder(
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemCount: 9,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              tapped(index);
            },
            child: Container(
              height: 100.0,
              width: 100.0,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                ),
              ),
              child: Center(
                child: Text(
                  xOrOList[index],
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: xOrOList[index] == 'X' ? Colors.white : Colors.red,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void tapped(int index) {
    if (gameHasResult == false) {
      print('$index');
      setState(() {
        if (xOrOList[index] == '') {
          if (isTurnO) {
            xOrOList[index] = 'O';
            filledBoxes++;
          } else {
            xOrOList[index] = 'X';
            filledBoxes++;
          }
          isTurnO = !isTurnO;
          winnerChecker();
        }
      });
    }
  }

  void winnerChecker() {
    if (xOrOList[0] == xOrOList[1] &&
        xOrOList[0] == xOrOList[2] &&
        xOrOList[0] != '') {
      setResult(xOrOList[0], 'winner is ${xOrOList[0]}');
    } else if (xOrOList[3] == xOrOList[4] &&
        xOrOList[3] == xOrOList[5] &&
        xOrOList[3] != '') {
      setResult(xOrOList[3], 'winner is ${xOrOList[3]}');
    } else if (xOrOList[6] == xOrOList[7] &&
        xOrOList[6] == xOrOList[8] &&
        xOrOList[6] != '') {
      setResult(xOrOList[6], 'winner is ${xOrOList[6]}');
    } else if (xOrOList[0] == xOrOList[3] &&
        xOrOList[0] == xOrOList[6] &&
        xOrOList[0] != '') {
      setResult(xOrOList[0], 'winner is ${xOrOList[0]}');
    } else if (xOrOList[1] == xOrOList[4] &&
        xOrOList[1] == xOrOList[7] &&
        xOrOList[1] != '') {
      setResult(xOrOList[1], 'winner is ${xOrOList[1]}');
    } else if (xOrOList[2] == xOrOList[5] &&
        xOrOList[2] == xOrOList[8] &&
        xOrOList[2] != '') {
      setResult(xOrOList[2], 'winner is ${xOrOList[2]}');
    } else if (xOrOList[0] == xOrOList[4] &&
        xOrOList[0] == xOrOList[8] &&
        xOrOList[0] != '') {
      setResult(xOrOList[0], 'winner is ${xOrOList[0]}');
    } else if (xOrOList[2] == xOrOList[4] &&
        xOrOList[2] == xOrOList[6] &&
        xOrOList[2] != '') {
      setResult(xOrOList[2], 'winner is ${xOrOList[2]}');
    } else if (filledBoxes == 9) {
      setResult('', 'Draw');
    }
  }

  Widget getScoreBoard() {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Player O',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25.0,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '$scoreO',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25.0,
                  ),
                ),
              )
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Player X',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25.0,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '$scoreX',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25.0,
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  void setResult(String winner, String title) {
    setState(() {
      gameHasResult = true;
      winnerTitle = title;
      if (winner == 'X') {
        scoreX++;
      } else if (winner == 'O') {
        scoreO++;
      } else {
        scoreX++;
        scoreO++;
      }
    });
  }

  void gameReset() {
    setState(() {
      for (var i = 0; i < xOrOList.length; i++) {
        xOrOList[i] = '';
      }
    });
    filledBoxes = 0;
  }
}
