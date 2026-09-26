import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skybase/config/base/navigation.dart';
import 'package:skybase/core/database/storage/storage_key.dart';
import 'package:skybase/core/database/storage/storage_manager.dart';
import 'package:skybase/ui/views/login/login_view.dart';

class IntroState {
  final int currentIndex;
  final PageController pageController;

  IntroState({
    required this.currentIndex,
    required this.pageController,
  });

  bool get isFirstPage => currentIndex == 0;
  bool get isLastPage => currentIndex == 2;

  IntroState copyWith({
    int? currentIndex,
    PageController? pageController,
  }) {
    return IntroState(
      currentIndex: currentIndex ?? this.currentIndex,
      pageController: pageController ?? this.pageController,
    );
  }
}

final introProvider = NotifierProvider.autoDispose<IntroNotifier, IntroState>(IntroNotifier.new);

class IntroNotifier extends AutoDisposeNotifier<IntroState> {
  late final StorageManager _storageManager;
  late final PageController _pageController;

  @override
  IntroState build() {
    _storageManager = ref.read(storageManagerProvider);

    _pageController = PageController(initialPage: 0);
    ref.onDispose(() {
      _pageController.dispose();
    });

    return IntroState(
      currentIndex: 0,
      pageController: _pageController,
    );
  }

  void onChangePage(int index) {
    state = state.copyWith(currentIndex: index);
  }

  void onPreviousPage() {
    state.pageController.previousPage(
      curve: Curves.easeIn,
      duration: const Duration(milliseconds: 260),
    );
  }

  void onNextPage(BuildContext context, Navigation navigation) {
    if (!state.isLastPage) {
      state.pageController.nextPage(
        curve: Curves.easeIn,
        duration: const Duration(milliseconds: 260),
      );
    } else {
      _storageManager.save(StorageKey.FIRST_INSTALL, false);
      navigation.push(context, LoginView.route);
    }
  }
}
