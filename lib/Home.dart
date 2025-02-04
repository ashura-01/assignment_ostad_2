import 'package:flutter/material.dart';

class HomeActivity extends StatefulWidget {
  const HomeActivity({super.key});

  @override
  State<HomeActivity> createState() => _HomeActivityState();
}

class _HomeActivityState extends State<HomeActivity> {

  final TextEditingController _name = TextEditingController();
  final TextEditingController _number = TextEditingController();

  final List<String> _nameList = [];
  final List<String> _numberList = [];

  void _addContact() {
    if (_name.text.isNotEmpty) {
      setState(() {
        _nameList.add(_name.text);
        _numberList.add(_number.text);
        _name.clear();
        _number.clear();
      });
    }
  }

  void _removeContact(int index) {
    setState(() {
      _nameList.removeAt(index); 
      _numberList.removeAt(index); // Fixed here
    });
  }



  void myAlertDialog(BuildContext context,int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(3),
          ),
          title: Text(
            "Confirmation",
            style: TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          content: Text("Are you sure for Delete?"),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.no_sim_outlined,
                color: Colors.cyan,
              ),
            ),
            IconButton(
              onPressed: () {
                _removeContact(index);
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.delete_outline,
                color: Colors.cyan,
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        foregroundColor: Colors.white,
        title: Text("Contact List"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 13, bottom: 0, left: 10, right: 10),
            child: TextField(
              controller: _name,
              decoration: InputDecoration(
                hintText: "Name",
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 2),
                  borderRadius: BorderRadius.all(Radius.circular(3)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 1),
                  borderRadius: BorderRadius.all(Radius.circular(3)),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
            child: TextField(
              controller: _number,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "Number",
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 2),
                  borderRadius: BorderRadius.all(Radius.circular(3)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 1),
                  borderRadius: BorderRadius.all(Radius.circular(3)),
                  
                ),
                
              ),
            
            ),
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.only(top: 5, bottom: 8, right: 10, left: 10),
              child: SizedBox(
                height: 38,
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueGrey,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  onPressed:_addContact,
                  child: Text("Add"),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _nameList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onLongPress: () {
                    myAlertDialog(context,index);
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: ListTile(
                      title: Text(
                        _nameList[index],
                        style: TextStyle(color: Colors.red),
                      ),
                      subtitle: Text(_numberList[index]),
                      leading: Icon(
                        Icons.person,
                        size: 40,
                        color: Colors.brown,
                      ),
                      trailing: Icon(
                        Icons.call,
                        color: Colors.lightBlue,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
