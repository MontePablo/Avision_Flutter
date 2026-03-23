import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../quiz/datamodels/questionResponse.dart';

class QuizDatabase {
  // Private constructor for singleton pattern
  QuizDatabase._internal();

  // The single instance of the repository
  static final QuizDatabase _instance = QuizDatabase._internal();

  // Factory constructor to return the single instance
  factory QuizDatabase() {
    return _instance;
  }

  // The currently opened box
  Box<QuizDtl>? _currentBox;

  // Initialize Hive and register adapters
  Future<void> init() async {
    await Hive.initFlutter();

    // Register the adapters
    Hive.registerAdapter(QuizDtlAdapter());
    Hive.registerAdapter(QuestionDtlAdapter());
    Hive.registerAdapter(AnsAdapter());
  }

  // Method to open a Hive box with the given section name
  Future<void> openBox(String section) async {
    print("box open quiz");
    if (_currentBox != null && _currentBox!.name == section) {
      // The box is already opened and matches the requested section
      return;
    }

    if (_currentBox != null) {
      // Close the currently opened box
      await _currentBox!.close();
    }

    // Open the new box
    _currentBox = await Hive.openBox<QuizDtl>(section);
  }

  // Save a QuizDtl item
  Future<void> saveQuizDtl(QuizDtl quizDtl) async {
    print("saving quiz");
    if (_currentBox == null) {
      throw Exception("No box is currently open.");
    }
    await _currentBox!.put(quizDtl.testId, quizDtl); // Using testId as the key.
  }

  // Fetch all QuizDtl items
  Future<List<QuizDtl>?> getAllQuizDtls() async {
    print("get all quiz");
    if (_currentBox == null) {
      return null;
    }
    if (_currentBox!.isEmpty) {
      return null;
    }
    return _currentBox!.values.toList();
  }

  // Fetch a QuizDtl by testId
  Future<QuizDtl?> getQuizDtlById(String testId) async {
    print("get single quiz");
    if (_currentBox == null) {
      return null;
    }
    return _currentBox!.get(testId);
  }

  // Update an existing QuizDtl
  Future<void> updateQuizDtl(QuizDtl quizDtl) async {
    print("updating quiz");
    if (_currentBox == null) {
      throw Exception("No box is currently open.");
    }
    await _currentBox!.put(quizDtl.testId, quizDtl); // Using testId as the key.
  }

  // Delete a QuizDtl
  Future<void> deleteQuizDtl(QuizDtl quizDtl) async {
    print("deleting quiz");
    if (_currentBox == null) {
      throw Exception("No box is currently open.");
    }
    await _currentBox!.delete(quizDtl.testId);
  }

  // Clear all QuizDtl items
  Future<void> clearAllQuizDtls() async {
    print("clean quiz");
    if (_currentBox == null) {
      throw Exception("No box is currently open.");
    }
    await _currentBox!.clear();
  }
}
