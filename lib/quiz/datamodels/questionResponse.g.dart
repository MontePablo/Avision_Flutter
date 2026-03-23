// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'questionResponse.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class QuizDtlAdapter extends TypeAdapter<QuizDtl> {
  @override
  final int typeId = 0;

  @override
  QuizDtl read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return QuizDtl(
      testId: fields[0] as String?,
      totalQus: fields[1] as int?,
      correctMarks: fields[2] as int?,
      negativeMarks: fields[3] as double?,
      totalTime: fields[4] as int?,
      questionDtls: (fields[5] as List?)?.cast<QuestionDtl>(),
      timeLeftInSec: fields[6] as int?,
      quizSection: fields[7] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, QuizDtl obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.testId)
      ..writeByte(1)
      ..write(obj.totalQus)
      ..writeByte(2)
      ..write(obj.correctMarks)
      ..writeByte(3)
      ..write(obj.negativeMarks)
      ..writeByte(4)
      ..write(obj.totalTime)
      ..writeByte(5)
      ..write(obj.questionDtls)
      ..writeByte(6)
      ..write(obj.timeLeftInSec)
      ..writeByte(7)
      ..write(obj.quizSection);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuizDtlAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class QuestionDtlAdapter extends TypeAdapter<QuestionDtl> {
  @override
  final int typeId = 1;

  @override
  QuestionDtl read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return QuestionDtl(
      questionId: fields[0] as String?,
      qno: fields[1] as int?,
      question: fields[2] as String?,
      ans: (fields[3] as List?)?.cast<Ans>(),
      isReviewed: fields[4] as bool?,
      selectedAnsPos: fields[5] as int?,
      givenAnsStat: fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, QuestionDtl obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.questionId)
      ..writeByte(1)
      ..write(obj.qno)
      ..writeByte(2)
      ..write(obj.question)
      ..writeByte(3)
      ..write(obj.ans)
      ..writeByte(4)
      ..write(obj.isReviewed)
      ..writeByte(5)
      ..write(obj.selectedAnsPos)
      ..writeByte(6)
      ..write(obj.givenAnsStat);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuestionDtlAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class AnsAdapter extends TypeAdapter<Ans> {
  @override
  final int typeId = 2;

  @override
  Ans read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Ans(
      answerId: fields[0] as String?,
      answer: fields[1] as String?,
      answerStatus: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Ans obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.answerId)
      ..writeByte(1)
      ..write(obj.answer)
      ..writeByte(2)
      ..write(obj.answerStatus);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AnsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
