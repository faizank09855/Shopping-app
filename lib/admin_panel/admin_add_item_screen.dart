import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transparent/admin_panel/bloc/admin_bloc.dart';
import 'package:transparent/login_module/widget/widgets.dart';
import 'package:transparent/payment_module/payment_widgets.dart';
import 'package:transparent/utils/colors_file.dart';

class AdminAddItemScreen extends StatefulWidget {
  AdminAddItemScreen({Key? key}) : super(key: key);

  @override
  State<AdminAddItemScreen> createState() => _AdminAddItemScreenState();
}

class _AdminAddItemScreenState extends State<AdminAddItemScreen> {
  TextEditingController nameController = TextEditingController();

  TextEditingController priceController = TextEditingController();

  TextEditingController imageController = TextEditingController();
  AdminBloc? bloc;

  @override
  void initState() {
    bloc = BlocProvider.of<AdminBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: ColorsUtils.textBlack,
        elevation: 0,
        centerTitle: true,
        title: const Text("Admin Panel"),
        leading: const BackButton(),
      ),
      body: BlocConsumer<AdminBloc, AdminState>(
        listener: (context, state) {
          if (state is AdminLoadedState) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Item Added Successfully"),
              backgroundColor: Colors.green,
            ));
            Navigator.pop(context);
          } else if (state is AdminErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.error),
              backgroundColor: Colors.red,
            ));
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  LoginTextField(hint: "name", controller: nameController),
                  const SizedBox(
                    height: 16,
                  ),
                  Divider(),
                  LoginTextField(hint: "price", controller: priceController),
                  const SizedBox(
                    height: 16,
                  ),
                  Divider(),
                  LoginTextField(hint: "imgUrl", controller: imageController),
                  const SizedBox(
                    height: 8,
                  ),
                  GradientButton(
                      radius: 32,
                      gradientColors: const [
                        ColorsUtils.orangeAccent,
                        ColorsUtils.pink,
                      ],
                      text: "Add Item",
                      onTap: () {
                        bloc!.add(AdminAddItemEvent(
                            name: nameController.text,
                            price: priceController.text,
                            image: imageController.text));
                      })
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
