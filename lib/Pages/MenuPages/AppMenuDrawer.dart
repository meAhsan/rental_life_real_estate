import 'package:flutter/material.dart';

class AppMenuDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
                UserAccountsDrawerHeader(
                  currentAccountPicture: CircleAvatar(
                    backgroundImage:
                    AssetImage("assets/images/apple-in-hand.jpg"),
                  ),
                  accountEmail: Text("Email"),
                  accountName: Text("Name"),
                  onDetailsPressed: () {
                    //Navigator.pushReplacementNamed(
                    //    context, ECommerceRoutes.userSettingsPage);
                  },
                ),
          ListTile(
            leading: Icon(Icons.apps),
            title: Text("My Ads"),
           // selected: _activeRoute == ECommerceRoutes.catalogPage,
            onTap: () => Navigator.pop(context)//_navigate(ECommerceRoutes.catalogPage),
          ),
          ListTile(
            leading: Icon(Icons.money),
            title: Text("Cart"),
            //selected: //_activeRoute == ECommerceRoutes.cartPage,
            onTap: () =>  Navigator.pop(context)//_navigate(ECommerceRoutes.cartPage),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text("User Settings"),
            //selected: _activeRoute == ECommerceRoutes.userSettingsPage,
            onTap: () => Navigator.pop(context)// _navigate(ECommerceRoutes.userSettingsPage),
          ),
          AboutListTile(
            icon: Icon(Icons.info),
            applicationName: "Produce Store",
            aboutBoxChildren: <Widget>[
              Text("Thanks for reading Flutter in Action!"),
            ],
          ),
        ],
      ),
    );
  }
}
