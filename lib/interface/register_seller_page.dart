import 'package:flutter/material.dart';
import 'package:kuaca_bali/common/colors.dart';
import 'package:kuaca_bali/database/auth/auth_service.dart';
import 'package:kuaca_bali/model/user_data_model.dart';
import 'package:kuaca_bali/widget/page_bar.dart';

class RegisterSellerPage extends StatefulWidget {
  const RegisterSellerPage({Key? key, required this.userData})
      : super(key: key);

  final UserData userData;
  @override
  _RegisterSellerPageState createState() => _RegisterSellerPageState();
}

class _RegisterSellerPageState extends State<RegisterSellerPage> {
  final TextEditingController storeNameController = TextEditingController();
  final TextEditingController storeAddressController = TextEditingController();

  @override
  void initState() {
    if (widget.userData.storeName != null) {
      storeNameController.text = widget.userData.storeName!;
    }
    if (widget.userData.storeAddress != null) {
      storeAddressController.text = widget.userData.storeAddress!;
    }
    super.initState();
  }

  @override
  void dispose() {
    storeNameController.dispose();
    storeAddressController.dispose();
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
          padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
          child: Column(
            children: [
              const PageBar(mainPage: false, title: 'Daftar Penjual'),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 10),
                    child: Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Detail Pemilik',
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            const SizedBox(height: 10),
                            Material(
                              elevation: 5,
                              borderRadius: BorderRadius.circular(10.0),
                              child: Container(
                                padding: const EdgeInsets.all(8.0),
                                height: 100,
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 50,
                                      backgroundImage: NetworkImage(widget
                                              .userData.imageUrl ??
                                          'https://images.unsplash.com/photo-1570295999919-56ceb5ecca61?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=580&q=80'),
                                    ),
                                    const SizedBox(width: 10.0),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            widget.userData.name,
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle1
                                                ?.copyWith(
                                                    fontWeight:
                                                        FontWeight.bold),
                                          ),
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.phone,
                                                size: 15,
                                                color: primary300,
                                              ),
                                              const SizedBox(width: 5),
                                              Text(
                                                widget.userData.phoneNumber,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .subtitle1,
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
                                              const SizedBox(width: 5),
                                              Text(
                                                widget.userData.address,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .subtitle2,
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: List.generate(
                            30,
                            (index) => Expanded(
                              child: Container(
                                color: index % 2 == 0
                                    ? Colors.transparent
                                    : Colors.grey,
                                height: 4,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Data Toko',
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              height: 80,
                              child: CustomTextField(
                                label: 'Nama Toko',
                                icon: Icons.store,
                                textController: storeNameController,
                              ),
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              height: 80,
                              child: CustomTextField(
                                label: 'Alamat Toko',
                                icon: Icons.location_on,
                                textController: storeAddressController,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 80.0),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomSheet: Container(
          margin: const EdgeInsets.only(left: 50, right: 50, bottom: 20),
          width: MediaQuery.of(context).size.width,
          child: ElevatedButton(
            onPressed: () async {
              try {
                await AuthService().sellerRegister(
                    storeNameController.text, storeAddressController.text);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Toko Telah Terdaftar'),
                  ),
                );
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Maaf Terjadi Error Saat Mendaftar'),
                  ),
                );
              }
            },
            child: const Text('Daftarkan Toko'),
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
      minLines: null,
      maxLines: null,
      expands: true,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
        prefixIcon: Icon(icon),
        label: Text(label),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
