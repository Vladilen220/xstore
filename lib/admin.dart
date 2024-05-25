import 'package:flutter/material.dart';

void main() {
  runApp(AdminPanel());
}

class AdminPanel extends StatefulWidget {
  @override
  _AdminPanelState createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
  ThemeMode _themeMode = ThemeMode.light;

  void _toggleTheme() {
    setState(() {
      _themeMode =
          _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-commerce Admin Panel',
      themeMode: _themeMode,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
      ),
      home: DashboardScreen(toggleTheme: _toggleTheme, themeMode: _themeMode),
    );
  }
}

class DashboardScreen extends StatelessWidget {
  final VoidCallback toggleTheme;
  final ThemeMode themeMode;

  DashboardScreen({required this.toggleTheme, required this.themeMode});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        actions: [
          IconButton(
            icon: Icon(themeMode == ThemeMode.light
                ? Icons.dark_mode
                : Icons.light_mode),
            onPressed: toggleTheme,
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('Products'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProductsScreen()),
                );
              },
            ),
            ListTile(
              title: Text('Orders'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OrdersScreen()),
                );
              },
            ),
            ListTile(
              title: Text('Approve Products'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ApproveProductsScreen()),
                );
              },
            ),
            ListTile(
              title: Text('Issue Requests'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => IssueRequestsScreen()),
                );
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Text('Welcome to Admin Panel!'),
      ),
    );
  }
}

class ApproveProductsScreen extends StatefulWidget {
  @override
  _ApproveProductsScreenState createState() => _ApproveProductsScreenState();
}

class _ApproveProductsScreenState extends State<ApproveProductsScreen> {
  List<Product> products = [
    Product(
        id: 1, sellerId: 1, name: 'Product A', description: 'Description A'),
    Product(
        id: 2, sellerId: 2, name: 'Product B', description: 'Description B'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Approve Products'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: products.length,
          itemBuilder: (context, index) {
            return Card(
              margin: EdgeInsets.symmetric(vertical: 8.0),
              child: ListTile(
                title: Text(products[index].name,
                    style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(
                    'Seller ID: ${products[index].sellerId}\n${products[index].description}'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.check, color: Colors.green),
                      onPressed: () {
                        // Approve product
                        setState(() {
                          products.removeAt(index);
                        });
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.close, color: Colors.red),
                      onPressed: () {
                        // Reject product
                        setState(() {
                          products.removeAt(index);
                        });
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class Product {
  final int id;
  final int sellerId;
  final String name;
  final String description;

  Product({
    required this.id,
    required this.sellerId,
    required this.name,
    required this.description,
  });
}

class IssueRequestsScreen extends StatefulWidget {
  @override
  _IssueRequestsScreenState createState() => _IssueRequestsScreenState();
}

class _IssueRequestsScreenState extends State<IssueRequestsScreen> {
  List<IssueRequest> issueRequests = [
    IssueRequest(
        id: 1, customerId: 1, description: 'Product damaged', reply: ''),
    IssueRequest(
        id: 2,
        customerId: 2,
        description: 'Wrong product delivered',
        reply: ''),
  ];
  final TextEditingController _replyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Issue Requests'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: issueRequests.length,
          itemBuilder: (context, index) {
            return Card(
              margin: EdgeInsets.symmetric(vertical: 8.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(issueRequests[index].description,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 4.0),
                    Text('Customer ID: ${issueRequests[index].customerId}'),
                    if (issueRequests[index].reply.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Text('Reply: ${issueRequests[index].reply}',
                            style: TextStyle(color: Colors.blue)),
                      ),
                    TextField(
                      controller: _replyController,
                      decoration: InputDecoration(
                        hintText: 'Type your reply here',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    ButtonBar(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            // Reply to request
                            setState(() {
                              issueRequests[index].reply =
                                  _replyController.text;
                              _replyController.clear();
                            });
                          },
                          child: Text('Reply'),
                        ),
                        IconButton(
                          icon: Icon(Icons.check, color: Colors.green),
                          onPressed: () {
                            // Approve request
                            setState(() {
                              issueRequests.removeAt(index);
                            });
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.close, color: Colors.red),
                          onPressed: () {
                            // Reject request
                            setState(() {
                              issueRequests.removeAt(index);
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class IssueRequest {
  final int id;
  final int customerId;
  final String description;
  String reply;

  IssueRequest({
    required this.id,
    required this.customerId,
    required this.description,
    this.reply = '',
  });
}

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Add logic to display and manage products
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
      ),
      body: Center(
        child: Text('Products Screen'),
      ),
    );
  }
}

class OrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Add logic to display and manage orders
    return Scaffold(
      appBar: AppBar(
        title: Text('Orders'),
      ),
      body: Center(
        child: Text('Orders Screen'),
      ),
    );
  }
}
