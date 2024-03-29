import 'package:flutter/material.dart';

import '../../authentication/login-page.dart';
import '../../logic/classes.dart';
import '../../logic/processing.dart';

class ProducerPage extends StatefulWidget {
  const ProducerPage({super.key});

  @override
  State<ProducerPage> createState() => _ProducerPageState();
}

class _ProducerPageState extends State<ProducerPage> {
  List namesProducer = [];
  late final Future myFutureProducerData;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  final _formKeyShowModal = GlobalKey<FormState>();
  final nameRegExp = RegExp(r'^(?=.*?[a-z]).{3,}$');
  final locationRegExp = RegExp(r'^(?=.*?[a-z]).{3,}$');
  final descriptionRegExp = RegExp(r'^(?=.*?[a-z]).{3,70}$');

  @override
  void initState() {
    super.initState();
    myFutureProducerData = downloadProducersList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.logout,
                          color: Color(0xFFA2A6B1),
                        ),
                        onPressed: () {

                          Navigator.popAndPushNamed(context, "/");
                        },
                      ),
                    ],
                  ),
                  const Text('All producers'),
                  FutureBuilder(
                      future: myFutureProducerData,
                      builder: (context, AsyncSnapshot<dynamic> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {}

                        if (snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.hasError) {
                            return const Text('Error');
                          }
                          //&& snapshot.data.length > 0
                          if (snapshot.hasData) {
                            return Flexible(
                                flex: 2,
                                fit: FlexFit.tight,
                                child: RefreshIndicator(
                                  key: _refreshIndicatorKey,
                                  onRefresh: refresh,
                                  child: ListView.separated(
                                    padding: const EdgeInsets.all(8),
                                    itemCount: namesProducer.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return (!namesProducer[index]
                                              .name
                                              .isEmpty)
                                          ? Dismissible(
                                              background: Container(
                                                color: Colors.red,
                                              ),
                                              key: ValueKey(
                                                  namesProducer[index]),
                                              onDismissed:
                                                  (DismissDirection direction) {
                                                Processing.deleteProducer(
                                                    namesProducer[index]
                                                        .producerId); // замінив з snapshot.data

                                                setState(() {
                                                  namesProducer.removeAt(
                                                      index); // замінив з snapshot.data
                                                });
                                              },
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                                decoration: const BoxDecoration(
                                                    color: Color(0xFF6040E5),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                20))),
                                                child: Wrap(
                                                  crossAxisAlignment:
                                                      WrapCrossAlignment.center,
                                                  children: [
                                                    ListTile(
                                                      leading: Image.asset(
                                                        'assets/images/flag.svg.png',
                                                        fit: BoxFit.cover,
                                                        width: 60,
                                                        height: 40,
                                                      ),
                                                      title: Column(
                                                        children: [
                                                          Text(
                                                            '${namesProducer[index].name}',
                                                            // замінив з snapshot.data
                                                            textAlign: TextAlign
                                                                .center,
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 20,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                          Text(
                                                            'Description: ${namesProducer[index].description}',
                                                            // замінив з snapshot.data
                                                            textAlign: TextAlign
                                                                .center,
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 14,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                          Text(
                                                            'Contact phone: ${namesProducer[index].contactPhone}',
                                                            // замінив з snapshot.data
                                                            textAlign: TextAlign
                                                                .center,
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 14,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                          Text(
                                                            'Location: ${namesProducer[index].location}',
                                                            // замінив з snapshot.data
                                                            textAlign: TextAlign
                                                                .center,
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 14,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      trailing: SizedBox(
                                                          child:
                                                              FloatingActionButton
                                                                  .small(
                                                        onPressed: () =>
                                                            dialogBuilder(
                                                                context,
                                                                namesProducer[
                                                                    index]),
                                                        tooltip:
                                                            'Add new Producer',
                                                        child: const Icon(
                                                          Icons.edit,
                                                          color: Colors.white,
                                                          size: 20.0,
                                                        ),
                                                      )),
                                                      onTap: () =>
                                                          dialogBuilder(
                                                              context,
                                                              namesProducer[
                                                                  index]),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )
                                          : Container();
                                    },
                                    separatorBuilder:
                                        (BuildContext context, int index) {
                                      return const Divider(
                                        // height: 1,
                                        thickness: 1,
                                        // indent: 20,
                                        endIndent: 0,
                                        color: Colors.black,
                                      );
                                    },
                                  ),
                                ));
                          }
                          return const Text('Empty data');
                        }
                        return const Text('Empty data2');
                      })
                ],
              )),
          Positioned(
              right: 30.0,
              bottom: 30.0,
              child: FloatingActionButton(
                onPressed: () {
                  final TextEditingController name = TextEditingController();
                  final TextEditingController description =
                      TextEditingController();
                  final TextEditingController location =
                      TextEditingController();
                  final TextEditingController contactPhone =
                      TextEditingController();

                  showModalBottomSheet<void>(
                    context: context,
                    isScrollControlled: true,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(35),
                            topRight: Radius.circular(35))),
                    builder: (_) {

                      return StatefulBuilder(builder:
                          (BuildContext context, StateSetter setState) {

                        return Container(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 60),
                          height: MediaQuery.of(context).size.height * 0.9,
                          child: Scaffold(
                            resizeToAvoidBottomInset: true,
                            body: ListView(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IconButton(
                                      onPressed: () => Navigator.pop(context),
                                      icon: const Icon(
                                        Icons.close,
                                        color: Color(0xFFA2A6B1),
                                      ),
                                    ),
                                  ],
                                ),
                                Form(
                                  key: _formKeyShowModal,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'Add new producers',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          //height: 5,

                                          fontSize: 20,
                                        ),
                                      ),
                                      const SizedBox(height: 15),
                                      CustomFormField(
                                        hintText: "Enter product name",
                                        controller: name,
                                        validator: (val) {
                                          if (!nameRegExp.hasMatch(val!)) {
                                            return 'Enter valid name';
                                          }
                                          return null;
                                        },
                                      ),
                                      const SizedBox(height: 15),
                                      CustomFormField(
                                        hintText: "Enter location",
                                        controller: location,
                                        validator: (val) {
                                          if (!locationRegExp.hasMatch(val!)) {
                                            return 'Description can contain up to 70 characters';
                                          }
                                          return null;
                                        },
                                      ),
                                      const SizedBox(height: 15),
                                      // const SizedBox(height: 10),
                                      CustomFormField(
                                        hintText: "Enter new description",
                                        controller: description,
                                        validator: (val) {
                                          if (!descriptionRegExp.hasMatch(val!)) {
                                            return 'Description can contain up to 70 characters';
                                          }
                                          return null;
                                        },
                                      ),
                                      const SizedBox(height: 15),
                                      // const SizedBox(height: 10,),
                                      CustomFormField(
                                        hintText: 'Phone',
                                        controller: contactPhone,
                                        validator: (val) {
                                          final phoneRegExp = RegExp(
                                              r'(^(?:[+0]9)?[0-9]{10,12}$)');

                                          if (!phoneRegExp.hasMatch(val!)) {
                                            return 'Enter valid Phone';
                                          }
                                          return null;
                                        },
                                      ),
                                      const SizedBox(height: 15),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              const Color(0xFF613CEA),
                                          // backgroundColor: const Color(0xFFA2A6B1),

                                          padding: const EdgeInsets.fromLTRB(
                                              40, 20, 40, 20),
                                        ),
                                        child: const Text('SAVE CHANGES'),
                                        onPressed: () {
                                          if (_formKeyShowModal.currentState!
                                              .validate()) {
                                            var newItem = Producer(
                                              producerId: 0,
                                              name: name.text,
                                              description: description.text,
                                              location: location.text,
                                              contactPhone: contactPhone.text,
                                            );
                                            Processing.addProducer(newItem)
                                                .then((value) {
                                              if (value == 'success') {
                                                showDialog(
                                                  context: context,
                                                  builder: (_) => AlertDialog(
                                                    title: const Text(
                                                        'Successfully added!'),
                                                    content: const Text(
                                                        'New producer was created'),
                                                    actions: <Widget>[
                                                      Center(
                                                        child: SizedBox(
                                                          height: 40,
                                                          width: 90,
                                                          child:
                                                              FloatingActionButton(
                                                            onPressed: () {
                                                              Navigator.popUntil(
                                                                  context,
                                                                  ModalRoute
                                                                      .withName(
                                                                          '/main'));
                                                            },
                                                            backgroundColor:
                                                                const Color(
                                                                    0xFF613CEA),
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5),
                                                            ),
                                                            child: const Text(
                                                                'Close'),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              }
                                            });
                                            _refreshIndicatorKey.currentState
                                                ?.show();
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      });
                    },
                  );
                },
                tooltip: 'Add new item',
                backgroundColor: Colors.pink,
                child: const Icon(
                  Icons.add,
                ),
              ))
        ],
      ),
    );
  }

  Future refresh() async {
    final producer = await Processing.getProducers().then((value) {
      namesProducer = value;

      return namesProducer;
    });

    setState(() {
      namesProducer = producer;
      // lengthList = products.length;
    });
  }

  downloadProducersList() {
    return Processing.getProducers().then((value) {
      namesProducer = value;

      return namesProducer;
    });
  }

  Future<void> dialogBuilder(BuildContext context, Producer currentProduct) {
    final formKey = GlobalKey<FormState>();

    final TextEditingController name =
        TextEditingController(text: currentProduct.name);
    final TextEditingController description =
        TextEditingController(text: currentProduct.description);
    final TextEditingController location =
        TextEditingController(text: currentProduct.location);
    final TextEditingController phone =
        TextEditingController(text: currentProduct.contactPhone);

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        var heightAlert = MediaQuery.of(context).size.height;

        return Scaffold(
          resizeToAvoidBottomInset: true,
          body: Center(
            child: SizedBox(
              height: heightAlert * 0.7,
              child: AlertDialog(
                  // insetPadding: EdgeInsets.symmetric(vertical: height),
                  title: const Text('Change producer'),
                  content: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        // const SizedBox(height: 10),
                        CustomFormField(
                          hintText: "Enter new producer name",
                          controller: name,
                          validator: (val) {
                            if (!nameRegExp.hasMatch(val!)) {
                              return 'Enter valid name';
                            }
                            return null;
                          },
                        ),
                        // const SizedBox(height: 10),
                        CustomFormField(
                          hintText: "Enter location",
                          controller: location,
                          validator: (val) {
                            if (!locationRegExp.hasMatch(val!)) {
                              return 'Description can contain up to 70 characters';
                            }
                            return null;
                          },
                        ),
                        // const SizedBox(height: 10),
                        CustomFormField(
                          hintText: "Enter new description",
                          controller: description,
                          validator: (val) {
                            if (!descriptionRegExp.hasMatch(val!)) {
                              return 'Description can contain up to 70 characters';
                            }
                            return null;
                          },
                        ),
                        // const SizedBox(height: 10,),
                        CustomFormField(
                          hintText: 'Phone',
                          controller: phone,
                          validator: (val) {
                            final phoneRegExp =
                                RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)');

                            if (!phoneRegExp.hasMatch(val!)) {
                              return 'Enter valid Phone';
                            }
                            return null;
                          },
                        ),
                        // const SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                              style: TextButton.styleFrom(
                                // textStyle: Theme.of(context).textTheme.labelLarge,
                                backgroundColor: Colors.green,
                                padding:
                                    const EdgeInsets.fromLTRB(20, 10, 20, 10),
                              ),
                              child: const Text('Save changes',
                                  style: TextStyle(
                                    color: Colors.white,
                                  )),
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  Processing.updateProducer(Producer(
                                          producerId: currentProduct.producerId,
                                          name: name.text,
                                          description: description.text,
                                          location: location.text,
                                          contactPhone: phone.text))
                                      .then((value) {
                                    Navigator.of(context).pop();
                                    refresh();
                                  });
                                }
                              },
                            ),
                            TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.redAccent,
                                padding:
                                    const EdgeInsets.fromLTRB(20, 10, 20, 10),
                              ),
                              child: const Text('Close',
                                  style: TextStyle(
                                    color: Colors.white,
                                  )),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                  // actions: <Widget>[
                  //
                  // ],
                  ),
            ),
          ),
        );
      },
    );
  }
}
