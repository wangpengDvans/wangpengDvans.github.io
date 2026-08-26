import '../models/guide_step.dart';

abstract class GuideRepository {
  Future<List<GuideStep>> getGuideSteps();
  Future<void> updateStepCompletion(int index, bool isCompleted);
}
