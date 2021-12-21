import 'package:flutter/material.dart';
import 'package:kuaca_bali/common/colors.dart';
import 'package:kuaca_bali/database/auth/auth_service.dart';
import 'package:kuaca_bali/helper/date_helper.dart';
import 'package:kuaca_bali/helper/state_helper.dart';
import 'package:kuaca_bali/interface/payment_page.dart';
import 'package:kuaca_bali/provider/cart_provider.dart.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key, required this.dressId}) : super(key: key);

  final String dressId;

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController dateShowController = TextEditingController();

  @override
  void dispose() {
    dateController.dispose();
    dateShowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Row(
            children: [
              IconButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.clear, size: 35.0),
              ),
              const SizedBox(width: 10),
              Text(
                'Atur Pesanan',
                style: Theme.of(context).textTheme.headline2,
              ),
            ],
          ),
        ),
        Expanded(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Durasi Pemesanan',
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    Form(
                      key: _formKey,
                      child: TextFormField(
                        controller: dateShowController,
                        readOnly: true,
                        onTap: () => _selectDate(context),
                        decoration: const InputDecoration(
                          icon: Icon(
                            Icons.calendar_today,
                            color: primary300,
                          ),
                          hintText: 'Pilih Tanggal',
                        ),
                        validator: (value) => dateController.text == 'null' ||
                                value == null ||
                                value.isEmpty
                            ? 'Silahkan Pilih Tanggal Pemesanan'
                            : null,
                      ),
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Ukuran',
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    const SizedBox(height: 10),
                    Consumer<CartProvider>(builder: (context, snapshot, child) {
                      return Wrap(
                        alignment: WrapAlignment.start,
                        spacing: 15,
                        children: List<Widget>.generate(
                          4,
                          (int index) {
                            return ChoiceChip(
                              padding: const EdgeInsets.all(10.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              selectedColor: secondary700,
                              backgroundColor: secondary300,
                              labelStyle: Theme.of(context).textTheme.button,
                              label: Text(size[index]),
                              avatar: Text(
                                avatar[index],
                                style: Theme.of(context).textTheme.button,
                              ),
                              selected: snapshot.size == index,
                              onSelected: (bool selected) {
                                snapshot.addSize = index;
                              },
                            );
                          },
                        ).toList(),
                      );
                    }),
                  ],
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Consumer<CartProvider>(
                      builder: (context, snapshot, child) {
                    return ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await snapshot.addCart(
                            dateController.text,
                            widget.dressId,
                            AuthService().getUserId()!,
                          );

                          if (snapshot.state == ResultState.isSuccess) {
                            snapshot.fetchCartList();
                            Navigator.pop(context);
                          }
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.add),
                          Icon(Icons.shopping_cart),
                        ],
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(10),
                        primary: secondary700,
                      ),
                    );
                  }),
                ),
                const SizedBox(width: 20),
                Expanded(
                  flex: 3,
                  child: Consumer<CartProvider>(
                      builder: (context, snapshot, child) {
                    return ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          final cartId = await snapshot.addCart(
                            dateController.text,
                            widget.dressId,
                            AuthService().getUserId()!,
                          );

                          if (cartId != null &&
                              snapshot.state == ResultState.isSuccess) {
                            snapshot.fetchCartList();
                            Navigator.pop(context);
                            pushNewScreen(
                              context,
                              screen: PaymentPage(cartId: [cartId]),
                              withNavBar: false,
                            );
                          }
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: const [
                          Text('Lanjutkan Pesanan'),
                          Icon(
                            Icons.arrow_back,
                            textDirection: TextDirection.rtl,
                          ),
                        ],
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(10),
                        primary: secondary700,
                      ),
                    );
                  }),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  _selectDate(BuildContext context) async {
    final DateTimeRange? selectDate = await showDateRangePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2025),
    );

    dateController.text = selectDate.toString();
    if (selectDate != null) {
      dateShowController.text = DateHelper.formatDateRange(selectDate);
    }
  }
}
