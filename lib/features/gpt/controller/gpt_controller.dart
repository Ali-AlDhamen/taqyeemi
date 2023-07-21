import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taqyeemi/features/gpt/repository/gpt_repository.dart';

final gptControllerProvider = StateNotifierProvider<GPTController, bool>(
  (ref) => GPTController(
    gptRepository: ref.watch(gptRepositoryProvider),
  ),
);


class GPTController extends StateNotifier<bool> {
  final GPTRepository _gptRepository;
  GPTController({required GPTRepository gptRepository})
      : _gptRepository = gptRepository,
        super(false);

  void taqyeemiGPTInit() async {
     _gptRepository.taqyeemiGPTInit();
  }

  void taqyeemiGPTClear() {
    _gptRepository.taqyeemiGPTClear();
  }

  Future<String> taqyeemiGPTAsk(String question) async {
    state = true;
    String answer = await _gptRepository.taqyeemiGPTAsk(question);
    state = false;
    return answer;
  }
}
