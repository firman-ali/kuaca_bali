import 'package:flutter/material.dart';
import 'package:kuaca_bali/common/colors.dart';

class RegisterSellerPage extends StatefulWidget {
  const RegisterSellerPage({Key? key}) : super(key: key);

  @override
  _RegisterSellerPageState createState() => _RegisterSellerPageState();
}

class _RegisterSellerPageState extends State<RegisterSellerPage> {
  final TextEditingController storeNameController = TextEditingController();

  @override
  void dispose() {
    storeNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SafeArea(
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Row(
                      children: [
                        const Icon(Icons.arrow_back_ios),
                        Text(
                          'Daftar Toko',
                          style: Theme.of(context).textTheme.headline2,
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Detail Pemilik',
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.network(
                            'https://images.unsplash.com/photo-1570295999919-56ceb5ecca61?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=580&q=80',
                            fit: BoxFit.cover,
                            height: 80,
                            width: 80,
                          ),
                        ),
                        const SizedBox(width: 10.0),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "nama",
                                style: Theme.of(context).textTheme.headline5,
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.phone,
                                    size: 15,
                                    color: primary300,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    'phone',
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.home,
                                    size: 15,
                                    color: primary300,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    'address',
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                  ),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: List.generate(
                    30,
                    (index) => Expanded(
                      child: Container(
                        color:
                            index % 2 == 0 ? Colors.transparent : Colors.grey,
                        height: 4,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Column(
                  children: [
                    Text(
                      'Data Toko',
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    CustomTextField(
                      maxLines: 1,
                      label: 'Nama Toko',
                      icon: Icons.store,
                      textController: storeNameController,
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      maxLines: 3,
                      label: 'Alamat Toko',
                      icon: Icons.add,
                      textController: storeNameController,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          margin: const EdgeInsets.only(left: 50, right: 50, bottom: 20),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(primary: secondary700),
            onPressed: () {
              print('Ini diklik');
            },
            child: Text('Daftarkan Toko'),
          ),
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    this.maxLines,
    required this.label,
    required this.icon,
    required this.textController,
  }) : super(key: key);

  final int? maxLines;
  final String label;
  final IconData icon;
  final TextEditingController textController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textController,
      maxLines: maxLines,
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        label: Text(label),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
