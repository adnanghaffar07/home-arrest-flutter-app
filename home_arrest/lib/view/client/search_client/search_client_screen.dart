import 'package:flutter/material.dart';
import 'package:home_arrest/global_widgets/global_scaffold/global_scaffold.dart';
import 'package:home_arrest/mixins/appbar_mixin.dart';
import 'package:home_arrest/providers/client_provider.dart';
import 'package:provider/provider.dart';

import '../../../global_widgets/text_fields/input_search_field.dart';
import '../../../utils/utils.dart';

class SearchClientScreen extends StatefulWidget {
  static const routeName = '/search-client-screen';
  const SearchClientScreen({super.key});

  @override
  State<SearchClientScreen> createState() => _SearchClientScreenState();
}

class _SearchClientScreenState extends State<SearchClientScreen> with AppbarMixin {
  bool _isSearching = false;
  @override
  Widget build(BuildContext context) {
    return GlobalScaffold(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: baseStyleAppBar(
          title: 'Search',
          backgroundColor: Colors.transparent,
          titleColor: const Color(0xFF0D0E2C),
          leadingWidget: Builder(builder: (context) {
            return IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: const Icon(Icons.menu, color: Color(0xFF21356A)),
            );
          }),
        ),
        body: Consumer<ClientProvider>(
          builder: (context, clientProvider, child) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: const Color(0xFFF2F2F2)),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: InputSearchField(
                            hintText: 'Search',
                            onChanged: (value) {
                              if (value.isNotEmpty) {
                                setState(() {
                                  _isSearching = true;
                                });
                              } else {
                                setState(() {
                                  _isSearching = false;
                                });
                              }
                            },
                          ),
                        ),
                        if (_isSearching)
                          ListView.separated(
                            shrinkWrap: true,
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            itemBuilder: (context, index) {
                              return Container(
                                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                                child: Text(
                                  clientProvider.offenders[index].firstName ?? '',
                                  style: Utils.safeGoogleFont('Poppins', fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const Divider();
                            },
                            itemCount: clientProvider.offenders.length,
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
