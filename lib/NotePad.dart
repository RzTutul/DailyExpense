import 'package:flutter/material.dart';
import 'package:myapp/utils/Notes.dart';

class NotePadPage extends StatefulWidget {
  @override
  _NotePadPageState createState() => _NotePadPageState();
}

class _NotePadPageState extends State<NotePadPage> {
  TextEditingController _messageTextController = TextEditingController();
  final NoteDBManager notedb = new NoteDBManager();
  NotePojo note;

  List<NotePojo> NotepojoList;
  int updateIndex =0;

  @override
  Widget build(BuildContext context) {
   double width = MediaQuery.of(context).size.width;
    return Scaffold(
      
      appBar: AppBar(
        title: Text('NotePad'),
        centerTitle: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))),
      ),
      body: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(10.2),
          child: Column(
             children: <Widget>[
            Container(
                padding: EdgeInsets.all(10.0),
                height: 200,
                width: 400,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.red.shade100),
                child: TextField(
                  controller: _messageTextController,
                  maxLines: 30,
                  decoration: InputDecoration(labelText: "Enter Message"),
                )),
            Container(
              alignment: Alignment.center,
              child: RaisedButton(
                  onPressed: () {
                    setState(() {
                     _saved(context);
                    });
             
                  },
                  child: Text("Save",)),
            ),
            Expanded(child:
               FutureBuilder(
                    future: notedb.getnoteList(),
                    builder: (context,snapshot){
                      if(snapshot.hasData) {
                        NotepojoList = snapshot.data;
                        return  ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: NotepojoList == null ?0 : NotepojoList.length,
                          itemBuilder: (BuildContext context, int index) {
                           NotePojo st = NotepojoList[index];
                           return Card(
                               color: Colors.indigoAccent.shade100,
                                elevation: 7.5,
                             child: Row(
                               children: <Widget>[
                                 Container(
                                   width: width*0.6,
                                   child: Column(
                                
                                     crossAxisAlignment: CrossAxisAlignment.start,
                                     children: <Widget>[
                                       Text(' ${st.message}',style: TextStyle(fontSize: 15),),
                
                                     ],
                                   ),
                                 ),
                             

                                 IconButton(onPressed: (){
                                   _messageTextController.text=st.message;
                         
                                   note=st;
                                   updateIndex = index;
                                 }, icon: Icon(Icons.edit, color: Colors.blueAccent,),),
                                IconButton(onPressed: (){
                                  notedb.deleteStudent(st.id);
                                  setState(() {
                                   NotepojoList.removeAt(index); 
                                  });
                                }, icon: Icon(Icons.delete, color: Colors.red,),)
                               
                               ],
                             ),
                           );
                          },

                        );
                        
                      }
                      return new CircularProgressIndicator();
                    },                   
                        
                  ))
          ])),
    );
  }

  void _saved(BuildContext context) {
    if (note == null) {

      if(_messageTextController.text.isEmpty)
      {
             final snackBar = SnackBar(content: Text('Message Empty'));
           Scaffold.of(context).showSnackBar(snackBar);
      }
      else
      {
   NotePojo notePojo = new NotePojo(message: _messageTextController.text);
      setState(() {
             notedb.insertStudent(notePojo).then((id) =>
          {_messageTextController.clear(), print('Note Added to Db ${id}')});
      });

      }
      
    }
  
  else {
        note.message = _messageTextController.text;

        notedb.updateStudent(note).then((id) =>{
          setState((){
            NotepojoList[updateIndex].message = _messageTextController.text;
    
          }),
          _messageTextController.clear(),
        
          note=null
        });
      }

  }}

