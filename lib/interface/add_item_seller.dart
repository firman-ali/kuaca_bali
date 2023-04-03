import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kuaca_bali/common/colors.dart';
import 'package:kuaca_bali/database/auth/auth_service.dart';
import 'package:kuaca_bali/database/firestore/db_service.dart';
import 'package:kuaca_bali/provider/add_item_provider.dart';
import 'package:kuaca_bali/widget/page_bar.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

class AdddItemSeller extends StatefulWidget {
  const AdddItemSeller({Key? key}) : super(key: key);

  @override
  _AdddItemSellerState createState() => _AdddItemSellerState();
}

class _AdddItemSellerState extends State<AdddItemSeller> {
  final TextEditingController _dressNameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  final _multiSelectKey = GlobalKey<FormFieldState>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddItemProvider>(
      create: (context) => AddItemProvider(
          dbService: DatabaseService(), authService: AuthService()),
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
            child: Column(
              children: [
                const PageBar(mainPage: false, title: 'Buat Dagangan'),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Consumer<AddItemProvider>(
                        builder: (context, snapshot, child) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                  child: InkWell(
                                onTap: () async {
                                  final ImagePicker _picker = ImagePicker();
                                  final XFile? photo = await _picker.pickImage(
                                    source: ImageSource.gallery,
                                  );
                                  snapshot.setImage = photo;
                                  snapshot.setImageUin =
                                      await photo!.readAsBytes();
                                },
                                child: snapshot.image == null
                                    ? Container(
                                        height: 200,
                                        width: 200,
                                        decoration: BoxDecoration(
                                          color: CupertinoColors.systemGrey,
                                          borderRadius:
                                              BorderRadius.circular(100),
                                        ),
                                        child: const Icon(
                                          Icons.image_outlined,
                                          size: 100,
                                        ),
                                      )
                                    : Container(
                                        height: 200,
                                        width: 200,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image:
                                                MemoryImage(snapshot.imageUin),
                                            fit: BoxFit.cover,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(100),
                                        ),
                                      ),
                              )),
                              const SizedBox(height: 10.0),
                              Text(
                                'Nama Busana',
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                              const SizedBox(height: 5.0),
                              TextFormField(
                                controller: _dressNameController,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10.0),
                              Text(
                                'Harga Sewa',
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                              const SizedBox(height: 5.0),
                              TextFormField(
                                controller: _priceController,
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10.0),
                              Text(
                                'Deskripsi Busana',
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                              const SizedBox(height: 5.0),
                              SizedBox(
                                height: 150,
                                child: TextFormField(
                                  controller: _descriptionController,
                                  textInputAction: TextInputAction.done,
                                  expands: true,
                                  maxLines: null,
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 20.0),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                ),
                              ),
                              MultiSelectChipField<String?>(
                                key: _multiSelectKey,
                                items: size
                                    .map((e) => MultiSelectItem(e, e))
                                    .toList(),
                                title: const Text("List Ukuran"),
                                headerColor: Colors.transparent,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 0, color: Colors.transparent),
                                ),
                                validator: (values) {
                                  if (values == null || values.isEmpty) {
                                    return "Silahkan Pilih Minimal Satu Ukuran";
                                  }
                                  return null;
                                },
                                selectedChipColor: primary300,
                                selectedTextStyle:
                                    const TextStyle(color: onPrimaryWhite),
                                onTap: (values) {
                                  snapshot.setListSize = values;
                                },
                              )
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ),
                Consumer<AddItemProvider>(
                  builder: (context, snapshot, child) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.only(
                          left: 20.0, right: 20.0, top: 10.0, bottom: 20.0),
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_multiSelectKey.currentState!.validate()) {
                            final result = await snapshot.addItem(
                              _dressNameController.text,
                              int.parse(_priceController.text),
                              _descriptionController.text,
                            );
                            if (result == 'success') {
                              Navigator.pop(context);
                            }
                          }
                        },
                        child: const Text('Buat Dagangan'),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
