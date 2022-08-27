import 'package:devfest/core/state/providers.dart';
import 'package:devfest/views/controller_page/widgets/controller_bottom_nav.dart';
import 'package:devfest/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:devfest/utils/colors.dart';

class ControllerPage extends StatefulHookConsumerWidget {
  const ControllerPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ControllerPage> createState() => _ControllerPageState();
}

class _ControllerPageState extends ConsumerState<ControllerPage>
    with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    final currentTab = ref.watch(
      controllerVM.select(
        (v) => v.currentTab,
      ),
    );

    final pages = ref.watch(controllerVM.select(
      (v) => v.pages.map((e) => e.page).toList(),
    ));

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const EmptyAppBar(),
      // this to prevent the default sliding behaviour
      drawerEnableOpenDragGesture: false,
      body: IndexedStack(
        index: currentTab,
        children: pages,
      ),
      bottomNavigationBar: const DevFestControllerBottomNav(),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      FocusManager.instance.primaryFocus!.unfocus();
    }
  }
}
