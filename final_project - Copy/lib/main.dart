import 'dart:convert';
import 'dart:math';
import 'package:powers/powers.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'stats.dart';
import 'weapons.dart';
import 'compare.dart';
import 'profile.dart';
import 'signin-up.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() {
  runApp(
    MaterialApp(initialRoute: '/', routes: {
      '/': (context) => home(),
      '/main': (context) => MainScreen(),
      '/stats': (context) => stats(),
      '/weapons': (context) => weapons(),
      'profile': (context) => profile(),
      '/details': (context) => detailWeapons(),
    },
    ),
  );
}
class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  List<Widget> _widgetOptions = <Widget>[
    stats(),
    weapons(),
    HomePage(),
    profile(),
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.black,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.orangeAccent,
        currentIndex: _selectedIndex,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.api
            ),
            title: Text('HOME'),
            activeIcon: Icon(
                Icons.api
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.api
            ),
            title: Text('test'),
            activeIcon: Icon(
                Icons.api
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.api
            ),
            title: Text('test'),
            activeIcon: Icon(
                Icons.api
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.api
            ),
            title: Text('test'),
            activeIcon: Icon(
                Icons.api
            ),
          ),
        ],
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
    );
  }

}
class home extends StatefulWidget {
  @override
  _FormState createState() => _FormState();
}

class _FormState extends State<home> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  var _emailFieldController = TextEditingController();
  var _passwordFieldController = TextEditingController();
  var _confirmPasswordFieldController = TextEditingController();

  bool isValidEmail(String input){
    final emailRegex = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return emailRegex.hasMatch(input);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text('Sign In'),centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(8.0),
          children: [
            TextFormField(
              decoration: const InputDecoration(
                icon: Icon(Icons.mail),
                hintText: "Email is required",
                labelText: "Email",
              ),
              keyboardType: TextInputType.emailAddress,
              controller: _emailFieldController,
              validator: (val) => isValidEmail(val!) ? null : 'Invalid Email Address',
            ),
            TextFormField(
                decoration: const InputDecoration(
                  icon: Icon(Icons.lock),
                  hintText: "Password is required",
                  labelText: "Password",
                ),
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
                controller: _passwordFieldController,
                validator: (val){
                  if (val!.isEmpty){
                    return "Invalid Password";
                  }
                  if (!RegExp(r"^(?=.*[A-Z])").hasMatch(val))
                  {
                    return "Password must contain one uppercase character";
                  }
                  if (!RegExp(r"^(?=.*[a-z])").hasMatch(val))
                  {
                    return "Password must contain one lower character";
                  }
                  if (!RegExp(r"^(?=.*[a-z])").hasMatch(val))
                  {
                    return "Password must contain one lower character";
                  }
                  if (!RegExp(r"^.{6,}").hasMatch(val))
                  {
                    return "Password is atleast 6 characters";
                  }
                  if (!RegExp(r"^(?=.*?[!@#\$&*~])").hasMatch(val))
                  {
                    return "Password must contain one special character";
                  }
                  if (val.contains( " " ))
                  {
                    return "Password cannot contain whitespaces.";
                  }
                }
            ),
            TextFormField(
                decoration: const InputDecoration(
                  icon: Icon(Icons.lock),
                  hintText: "Reconfirm your password",
                  labelText: "Confirm Password",
                ),
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
                controller: _confirmPasswordFieldController,
                validator: (val){
                  if (val!.isEmpty){
                    return "Invalid Password";
                  }
                  if (_passwordFieldController.text != _confirmPasswordFieldController.text)
                  {
                    return "Password do not match";
                  }
                }
            ),
            Container(
                padding: EdgeInsets.only(left:40.0, top:20.0, right:40.0,),
                child: RaisedButton(
                  child: Text("SIGN IN"),
                  onPressed: (){
                    if (_formKey.currentState!.validate()) {
                      print("Email: ${_emailFieldController}");
                      print("Password: ${_passwordFieldController}");
                      print("PasswordConfirm: ${_confirmPasswordFieldController}");

                      Alert(context:
                      context,
                        title: "You signed in!",
                        desc: "Enjoy!",
                        buttons: [
                          DialogButton(
                            child: const Text(
                              "Enter the app",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white),
                            ),
                            onPressed: () => Navigator.pushNamed(context, '/weapons'),
                            color: Colors.orange,)
                        ],
                      ).show();
                    }
                    else
                    {
                      Alert(context:
                      context,
                        title:  "Error",
                        desc: "One of the fields has an error",
                        buttons: [
                          DialogButton(
                            child: const Text(
                              "OK",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white),
                            ),
                            onPressed: () => Navigator.pop(context),
                            color: Colors.red,)
                        ],
                      ).show();
                      print('Invalid Form');
                    }
                  },
                )
            ),

            Container(
              height: 125,
            ),

            Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(3.0)),
                  gradient: LinearGradient(
                      colors: [Colors.black, Colors.orange],
                      begin: FractionalOffset(0.2, 0.2),
                      end: FractionalOffset(0.5, 0.5),
                      stops: [0.1, 0.5],
                      tileMode: TileMode.clamp)),
              child: MaterialButton(
                highlightColor: Colors.transparent,
                splashColor: Colors.white70,
                child: const Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 42.0),
                  child: Text(
                    "SignUp",
                    style: TextStyle(
                        fontFamily: "SignikaSemiBold",
                        color: Colors.black,
                        fontSize: 22.0),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => signUp()));
                },
              ),
            ),

          ],
        ),

      ),
    );
  }
}

class signUp extends StatefulWidget {
  @override
  _signUp createState() => _signUp();
}

class _signUp extends State<signUp> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  var _nameSignUp = TextEditingController();
  var _emailSignUp = TextEditingController();
  var _phoneSignUp = TextEditingController();
  var _passwordSignUp = TextEditingController();
  var _confirmPasswordSignUp = TextEditingController();

  bool isValidEmail(String input){
    final emailRegex = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return emailRegex.hasMatch(input);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text('Create Account'),centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(8.0),
          children: [
            TextFormField(
              decoration: const InputDecoration(
                icon: Icon(Icons.person),
                hintText: "Enter your full name",
                labelText: "Name",
              ),
              controller: _nameSignUp,
              validator: (val) {
                if (val!.isEmpty){
                  return "Invalid Name";
                }
                if (RegExp(r"^(?=.*?[!@%#\$&*~])").hasMatch(val))
                {
                  return "Name cannot contain special characters";
                }
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                icon: Icon(Icons.mail),
                hintText: "Email is required",
                labelText: "Email",
              ),
              keyboardType: TextInputType.emailAddress,
              controller: _emailSignUp,
              validator: (val) => isValidEmail(val!) ? null : 'Invalid Email Address',
            ),
            TextFormField(
                decoration: const InputDecoration(
                  icon: Icon(Icons.phone),
                  hintText: "Phone is required",
                  labelText: "Phone",
                ),
                keyboardType: TextInputType.phone,
                controller: _phoneSignUp,
                validator: (val){
                  if (val!.isEmpty){
                    return "Enter Phone number";
                  }
                  if (val.length < 10 || val.length > 10)
                  {
                    return "Enter a 10 digits number";
                  }
                  if (!RegExp(r"(^(?:[+0]9)?[0-9]{10}$)").hasMatch(val))
                  {
                    return "Enter numbers only";
                  }
                }

            ),
            TextFormField(
                decoration: const InputDecoration(
                  icon: Icon(Icons.lock),
                  hintText: "Password is required",
                  labelText: "Password",
                ),
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
                controller: _passwordSignUp,
                validator: (val){
                  if (val!.isEmpty){
                    return "Invalid Password";
                  }
                  if (!RegExp(r"^(?=.*[A-Z])").hasMatch(val))
                  {
                    return "Password must contain one uppercase character";
                  }
                  if (!RegExp(r"^(?=.*[a-z])").hasMatch(val))
                  {
                    return "Password must contain one lower character";
                  }
                  if (!RegExp(r"^(?=.*[a-z])").hasMatch(val))
                  {
                    return "Password must contain one lower character";
                  }
                  if (!RegExp(r"^.{6,}").hasMatch(val))
                  {
                    return "Password is atleast 6 characters";
                  }
                  if (!RegExp(r"^(?=.*?[!@#\$&*~])").hasMatch(val))
                  {
                    return "Password must contain one special character";
                  }
                  if (val.contains( " " ))
                  {
                    return "Password cannot contain whitespaces.";
                  }
                }
            ),
            TextFormField(
                decoration: const InputDecoration(
                  icon: Icon(Icons.lock),
                  hintText: "Reconfirm your password",
                  labelText: "Confirm Password",
                ),
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
                controller: _confirmPasswordSignUp,
                validator: (val){
                  if (val!.isEmpty){
                    return "Invalid Password";
                  }
                  if (_passwordSignUp.text != _confirmPasswordSignUp.text)
                  {
                    return "Password do not match";
                  }
                }
            ),
            Container(
                padding: EdgeInsets.only(left:40.0, top:20.0, right:40.0,),
                child: RaisedButton(
                  child: Text("SIGN IN"),
                  onPressed: (){
                    if (_formKey.currentState!.validate()) {
                      print("Name: ${_nameSignUp}");
                      print("Email: ${_emailSignUp}");
                      print("Phone Number: ${_phoneSignUp}");
                      print("Password: ${_passwordSignUp}");
                      print("PasswordConfirm: ${_confirmPasswordSignUp}");

                      Alert(context:
                      context,
                        title: "You Created an acccount",
                        desc: "You may now sign in!",
                        buttons: [
                          DialogButton(
                            child: const Text(
                              "Enter the app",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white),
                            ),
                            onPressed: () => Navigator.pushNamed(context, '/'),
                            color: Colors.orange,)
                        ],
                      ).show();
                    }
                    else
                    {
                      Alert(context:
                      context,
                        title:  "Error",
                        desc: "One of the fields has an error",
                        buttons: [
                          DialogButton(
                            child: const Text(
                              "OK",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white),
                            ),
                            onPressed: () => Navigator.pop(context),
                            color: Colors.red,)
                        ],
                      ).show();
                      print('Invalid Form');
                    }
                  },
                )
            ),
          ],
        ),

      ),
    );
  }
}


class weapons extends StatefulWidget{
  @override
  State<weapons> createState() => _weaponsState();
}

class _weaponsState extends State<weapons>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Elden Ring Weapons"),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
      body: Center(
          child: FutureBuilder<List<Weapons>>(
            future: getWeapon(),
            builder: (context, snapshot){
              if (snapshot.hasData){
                var Weapons = snapshot.data;
                return ListView.builder(
                    itemCount: Weapons?.length,
                    itemBuilder: (context, ind){
                      var weaponGroup = Weapons![ind];
                      var one = weaponGroup.getName();
                      var two = weaponGroup.getCatagory();
                      var idValue = weaponGroup.getId().toString();
                      return ListTile(
                          title: Text(one!),
                          subtitle: Text(two!),textColor: Colors.white,
                          leading: CircleAvatar(
                            child: Text("$idValue"),
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.orange,),
                          onTap: () async{
                            Navigator.pushNamed(context, '/details', arguments: weaponGroup);
                          }
                      );
                    }
                );
              }
              else if(snapshot.hasError){
                return Text("${snapshot.error}");
              }
              return CircularProgressIndicator();
            },
          )
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.grey,
        items: const<BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home,color: Colors.black87,),
            label:"Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label:"Weapons",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.api),
            label:"Compare",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_sharp),
            label:"Account",
          ),
        ],
      ),
      backgroundColor: Colors.black,
    );
  }
}

Future<List<Weapons>> getWeapon() async {
  var url = 'https://raw.githubusercontent.com/BoredTourist/EldenBlingAPI/main/testFinal';
  var response = await http.get(Uri.parse(url));
  if (response.statusCode == 200){
    var jsonResponse = jsonDecode(response.body);
    return jsonResponse.map<Weapons>((m) => Weapons.fromJson(m)).toList();
  }
  else{
    throw Exception("Failed to fetch data");
  }
}

class detailWeapons extends StatefulWidget{
  @override
  State<detailWeapons> createState() => _detailState();
}
class _detailState extends State<detailWeapons>{
  late Weapons weaponDetails;
  @override
  Widget build(BuildContext context) {
    weaponDetails = ModalRoute.of(context)?.settings.arguments as Weapons;

    String? imageLink = weaponDetails._image!;
    String? description = weaponDetails._description!;
    String? category = weaponDetails._category!;
    String? skill = weaponDetails._skill!;

    String? phy = weaponDetails._phy!;
    String? mag = weaponDetails._mag!;
    String? fire = weaponDetails._fire!;
    String? light = weaponDetails._ligt!;
    String? holy = weaponDetails._holy!;
    String? Crit = weaponDetails._crit!;

    return Scaffold(
      appBar: AppBar(
        title: Text(weaponDetails._name!),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
      body: Column(
        children: [
          Container(
            child: Image.network("$imageLink"),
          ),
          Container(
              child:Text("")
          ),
          Column(children: [
            Container(child: Text("$description",style: TextStyle(color: Colors.white,fontSize: 17),textAlign: TextAlign.center,),alignment: Alignment.center,),
            Container(child: Text("\nCatagory: $category",style: TextStyle(color: Colors.white,fontSize: 17)),alignment: Alignment.center,),
            Container(child: Text("Skill: $skill ",style: TextStyle(color: Colors.white,fontSize: 17)),alignment: Alignment.center,),
            Container(child: Text("\nPhysical: $phy ",style: TextStyle(color: Colors.white,fontSize: 17)),alignment: Alignment.center,),
            Container(child: Text("Magic: $mag ",style: TextStyle(color: Colors.cyan,fontSize: 17)),alignment: Alignment.center,),
            Container(child: Text("Fire: $fire ",style: TextStyle(color: Colors.deepOrange,fontSize: 17)),alignment: Alignment.center,),
            Container(child: Text("Light: $light ",style: TextStyle(color: Colors.yellow,fontSize: 17)),alignment: Alignment.center,),
            Container(child: Text("Holy: $holy ",style: TextStyle(color: Colors.deepOrangeAccent,fontSize: 17)),alignment: Alignment.center,),
            Container(child: Text("Crit: $Crit ",style: TextStyle(color: Colors.red,fontSize: 17)),alignment: Alignment.center,),
          ],
          ),
        ],
      ),
      backgroundColor: Colors.black,

    );
  }
}

class Weapons {
  late int?  _id;
  late String?  _name;
  late String?  _image;
  late String?  _description;
  late String?  _category;
  late String? _skill;

  late String? _phy;
  late String? _mag;
  late String? _fire;
  late String? _ligt;
  late String? _holy;
  late String? _crit;


  Weapons(
      int?    id,
      String? n,
      String? im,
      String? d,
      String? c,
      String? s,

      String? phy,
      String? mag,
      String? fire,
      String? ligt,
      String? holy,
      String? crit,

      ){
    _id = id;
    _name = n;
    _image = im;
    _description = d;
    _category = c;
    _skill = s;

    _phy = phy;
    _mag = mag;
    _fire = fire;
    _ligt = ligt;
    _holy = holy;
    _crit = crit;
  }

  factory Weapons.fromJson(Map<String, dynamic> json){
    return Weapons(
      json['id'],
      json['name'],
      json['image'],
      json['description'],
      json['category'],
      json['Skill'],

      json['attack']["Phy"],
      json['attack']["Mag"],
      json['attack']["Fire"],
      json['attack']["Ligt"],
      json['attack']["Holy"],
      json['attack']["Crit"],
    );
  }
  int? getId() => _id;
  String? getName() => _name;
  String? getImage() => _image;
  String? getDescription() => _description;
  String? getCatagory() => _category;
  String? getSkill() => _skill;

  String? getPhy() => _phy;
  String? getMag() => _mag;
  String? getFire() => _fire;
  String? getLigt() => _ligt;
  String? getHoly() => _holy;
  String? getCrit() => _crit;

}
