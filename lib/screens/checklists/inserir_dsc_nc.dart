import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inspeccion_seguridad/constants.dart';
import 'package:inspeccion_seguridad/models/resposta.dart';
import 'package:inspeccion_seguridad/models/tsl_data.dart';

class InserirDscNC extends StatelessWidget {
  final Resposta resposta;

  InserirDscNC(this.resposta);

  @override
  Widget build(BuildContext context) {
    TSLData tslData = TSLData();
    TextEditingController controller =
        TextEditingController(text: resposta.dscNC ?? '');
    return Container(
      color: Color(0xff757575),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Insertar la no conformidad',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: paracelGreen,
                fontSize: 20.0,
              ),
            ),
            TextField(
              controller: controller,
              autofocus: true,
              textAlign: TextAlign.center,
              onChanged: (newText) {},
            ),
            SizedBox(
              height: 12.0,
            ),
            TextButton(
              onPressed: () {
                if (controller.text != '') {
                  this.resposta.dscNC = controller.text;
                  tslData.updateResposta(this.resposta);
                  Navigator.of(context).pop();
                  showGeneralDialog(
                    barrierColor: Colors.white.withOpacity(0.5),
                    transitionBuilder: (context, a1, a2, widget) {
                      final curvedValue =
                          Curves.easeInOutBack.transform(a1.value) - 1.0;
                      return Transform(
                        transform: Matrix4.translationValues(
                            0.0, curvedValue * 200, 0.0),
                        child: Opacity(
                          opacity: a1.value,
                          child: AlertDialog(
                            backgroundColor: paracelGreen,
                            shape: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16.0)),
                            content: Text('¡Información guardada con éxito!'),
                            titleTextStyle: TextStyle(color: Colors.white),
                            contentTextStyle: TextStyle(color: Colors.white),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  'OK',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    transitionDuration: Duration(
                      seconds: 1,
                    ),
                    barrierDismissible: true,
                    barrierLabel: '',
                    context: context,
                    pageBuilder: (context, a1, a2) {
                      final curvedValue =
                          Curves.easeInOutBack.transform(a1.value) - 1.0;
                      return Transform(
                        transform: Matrix4.translationValues(
                            0.0, curvedValue * 200, 0.0),
                        child: Opacity(
                          opacity: a1.value,
                          child: AlertDialog(
                            backgroundColor: paracelGreen,
                            shape: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16.0)),
                            content: Text('¡Información guardada con éxito!'),
                            titleTextStyle: TextStyle(color: Colors.white),
                            contentTextStyle: TextStyle(color: Colors.white),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  'OK',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
              child: Text(
                'Guardar',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              style: TextButton.styleFrom(
                backgroundColor: paracelGreen,
              ),
            )
          ],
        ),
        padding: EdgeInsets.all(30.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
      ),
    );
  }
}
