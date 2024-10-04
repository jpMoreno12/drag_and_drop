import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String containerName = 'container';
  bool inLeft = true;
  bool inRight = false;
  bool showTargetLeft = false;
  bool showTargetRight = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //Para comecar mostrando o draggable do lado esquerdo, a variavel inLeft tem que ser true
                  // e a variavel inRight tem que ser false

                  inLeft == true && inRight == false
                      ? Draggable(
                          //Draggable lado esquerdo
                          data: containerName,
                          feedback: Container(
                            color: Colors.red,
                            width: 100,
                            height: 100,
                          ),
                          childWhenDragging: const Offstage(
                            offstage: true,
                          ),

                          child: Container(
                            color: Colors.red,
                            width: 100,
                            height: 100,
                          ),

                          onDragStarted: () {
                            setState(() {
                              showTargetRight = true;
                            });
                          },

                          onDraggableCanceled: (velocity, offset) {
                            setState(() {
                              showTargetRight = false;
                            });
                          },

                          onDragCompleted: () {
                            inLeft = false;
                            inRight = true;
                            showTargetLeft = false;
                          },

                          //DragTarget do lado esquerdo
                        )
                      : Offstage(
                          offstage: !showTargetLeft,
                          child: DragTarget(
                            builder: (
                              context,
                              accepted,
                              rejected,
                            ) {
                              return inLeft == true && inRight == false
                                  ? Container(
                                      width: 100,
                                      height: 100,
                                      color: Colors.red,
                                    )
                                  : Container(
                                      width: 100,
                                      height: 100,
                                      decoration: BoxDecoration(
                                          color: Colors.green[50],
                                          border: Border.all(
                                            width: 4,
                                          )),
                                    );
                            },
                            onWillAcceptWithDetails: (details) {
                              return details.data == containerName;
                            },
                            onAcceptWithDetails: (details) {
                              if (details.data == containerName) {
                                setState(() {});
                              }
                            },
                          ),
                        ),

                  const SizedBox(
                    width: 70,
                  ),

                  /* Quando meu draggable a esquerda ser movido para o Target do lado direito
                  As minhas 2 variaveis irao trocar onde a direita sera true agora e esquerda sera false */

                  //Drag Target do lado direito

                  Offstage(
                    /* o show target e false entao para ele ficar invisivel e preciso ser true, 
                    para nao inicializa-lo como true no projeto e preciso colocar "!" no offstage para 
                    inverter a condicao e o offstage ler ele como true */

                    offstage:
                        !showTargetRight, // verifica ele como se fosse true
                    child: DragTarget(
                      builder: (
                        context,
                        accepted,
                        rejected,
                      ) {
                        return inRight == true && inLeft == false
                            ? Draggable(
                                //Draggable do lado direito
                                data: containerName,
                                feedback: Container(
                                  width: 100,
                                  height: 100,
                                  color: Colors.red,
                                ),
                                childWhenDragging: const Offstage(
                                  offstage: true,
                                ),
                                child: Container(
                                  width: 100,
                                  height: 100,
                                  color: Colors.red,
                                ),

                                onDragStarted: () {
                                  setState(() {
                                    showTargetLeft = true;
                                  });
                                },

                                onDraggableCanceled: (velocity, offset) {
                                  setState(() {
                                    showTargetLeft = false;
                                  });
                                },

                                onDragCompleted: () {
                                  inLeft = true;
                                  inRight = false;
                                  showTargetRight = false;
                                },
                              )
                            : Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  color: Colors.green[50],
                                  border: Border.all(width: 2),
                                ),
                              );
                      },
                      onWillAcceptWithDetails: (details) {
                        return details.data == containerName;
                      },
                      onAcceptWithDetails: (details) {
                        if (details.data == containerName) {
                          setState(() {});
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
