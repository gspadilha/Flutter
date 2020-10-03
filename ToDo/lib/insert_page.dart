import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertodo/models/itens.dart';

class InsertPage extends StatefulWidget {
  var itens = new List<Itens>();
  // temporário
  InsertPage() {
    itens = [];
    itens.add(Itens(id: 0, atividade: "Teste 0", marcado: true));
    itens.add(Itens(id: 1, atividade: "Teste 1", marcado: true));
    itens.add(Itens(id: 2, atividade: "Teste 2", marcado: false));
    itens.add(Itens(id: 3, atividade: "Teste 3", marcado: false));
  }
  @override
  _InsertPageState createState() => _InsertPageState();
}

class _InsertPageState extends State<InsertPage> {
  final _formKey = GlobalKey<FormState>();
  var textController = TextEditingController();

  //@TODO: separar o gerenciamento de estado
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('ToDo'),
        ),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 8, 0),
            child: Icon(Icons.help),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Form(
            key: _formKey,
            child: Container(
              margin: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Center(
                    child: Text(
                      'Qual a atividade a ser feita?',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  TextFormField(
                    controller: textController,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      suffixIcon: Icon(Icons.help_outline),
                      //hintText: 'Descreva a atividade',
                      labelText: 'Atividade:',
                    ),
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Obrigatório';
                      }
                      return null;
                    },
                    onSaved: (String value) {
                      setState(() {
                        widget.itens.add(
                          Itens(
                              id: widget.itens.length,
                              atividade: value + widget.itens.length.toString(),
                              marcado: false),
                        );
                        textController.clear();
                      });
                    },
                  ),
                  RaisedButton.icon(
                    color: Theme.of(context).accentColor,
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();
                      }
                    },
                    icon: Icon(Icons.add),
                    label: Text('Adicionar'),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: widget.itens.length,
              itemBuilder: (BuildContext context, int index) {
                final item = widget.itens[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Dismissible(
                      key: UniqueKey(),
                      secondaryBackground: Container(
                        color: Colors.red,
                        padding: EdgeInsets.only(right: 8.0),
                        alignment: Alignment.centerRight,
                        child: Text(
                          "Excluir!",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      background: Container(
                        color: Colors.blue,
                      ),
                      onDismissed: (direction) {
                        print(item.id);
                        setState(() {
                          widget.itens.removeAt(index);
                        });
                        Scaffold.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Registro Excluído!"),
                          ),
                        );
                      },
                      child: CheckboxListTile(
                        title: Text(item.atividade),
                        value: item.marcado,
                        onChanged: (value) {
                          setState(() {
                            item.marcado = !item.marcado;
                          });
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
