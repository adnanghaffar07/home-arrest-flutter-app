import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../providers/client_provider.dart';
import '../../../../utils/utils.dart';

typedef MonitorLevelCallBack = void Function(int index);

class MonitorLevelBottomSheet extends StatelessWidget {
  final MonitorLevelCallBack? onTap;
  const MonitorLevelBottomSheet({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Consumer<ClientProvider>(
      builder: (context, provider, child) {
        return Container(
          height: 220,
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 20),
                child: Text(
                  'Monitor Level',
                  style: Utils.safeGoogleFont('Poppins', fontSize: 14, fontWeight: FontWeight.w700, color: const Color(0xFF21356A)),
                ),
              ),
              ListView.separated(
                padding: const EdgeInsets.only(top: 10),
                itemCount: provider.monitorLevelList.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      onTap!(index);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                      child: Row(
                        children: [
                          Image.asset(
                            provider.monitorLevelList[index].icon!,
                            height: 30,
                            width: 30,
                          ),
                          const SizedBox(width: 20),
                          Text(
                            provider.monitorLevelList[index].title,
                            style: Utils.safeGoogleFont('Poppins', fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black),
                          ),
                          const Spacer(),
                          Radio(
                            value: provider.monitorLevelList[index].title,
                            groupValue: provider.monitorLevelList.indexWhere((element) => element.isSelected == true) != -1
                                ? provider.monitorLevelList[provider.monitorLevelList.indexWhere((element) => element.isSelected == true)].title
                                : '',
                            onChanged: (val) {
                              onTap!(index);
                            },
                            visualDensity: VisualDensity.compact,
                          ),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(width: double.infinity, height: 10);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
