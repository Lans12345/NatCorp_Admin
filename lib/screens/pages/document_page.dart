import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nat_corp_admin/widgets/app_bar.dart';
import 'package:nat_corp_admin/widgets/text_widget.dart';

class DocumentPage extends StatelessWidget {
  DocumentPage({Key? key}) : super(key: key);

  final box = GetStorage();
  final filesList = [
    'NSO',
    'NBI',
    'Diploma',
    'COE',
    'SSS',
    'Philhealth',
    'Pag-ibig',
    'TIN',
    'TOR',
    'Brgy Clearance',
    'Police Clearance',
    'Vaccine Card',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppbarWidget('Documents'),
        body: ListView.builder(
            itemCount: filesList.length,
            itemBuilder: ((context, index) {
              return box.read('data')[filesList[index]] != ''
                  ? Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child: Container(
                        width: double.infinity,
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              TextBold(
                                  text: "Document Type: " + filesList[index],
                                  fontSize: 18,
                                  color: Colors.black),
                              const SizedBox(
                                height: 10,
                              ),
                              Image.network(
                                box.read('data')[filesList[index]],
                                height: 150,
                                width: 150,
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : const SizedBox();
            })));
  }
}
