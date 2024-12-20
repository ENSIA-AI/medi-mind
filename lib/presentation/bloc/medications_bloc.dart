import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:medi_mind/data/dbhelper/db_helper.dart';
import 'package:medi_mind/data/model/medication.dart';

// States
abstract class MedicationState extends Equatable {
  const MedicationState();

  @override
  List<Object?> get props => [];
}

class MedicationInitial extends MedicationState {}

class MedicationLoading extends MedicationState {}

class MedicationLoaded extends MedicationState {
  final List<Medication> medications;

  const MedicationLoaded(this.medications);

  @override
  List<Object?> get props => [medications];
}

class MedicationError extends MedicationState {
  final String error;

  const MedicationError(this.error);

  @override
  List<Object?> get props => [error];
}

// Cubit
class MedicationCubit extends Cubit<MedicationState> {
  MedicationCubit() : super(MedicationInitial());

  final DbHelper _dbHelper = DbHelper();

  Future<void> fetchMedications() async {
    emit(MedicationLoading());
    try {
      final db = await _dbHelper.database;

      // Fetch medications from the database
      final List<Map<String, dynamic>> medsData = await db.query('medications');
      print(medsData);

      // Convert fetched data to Medication objects
      final List<Medication> medications = medsData
          .map((med) => Medication(
                id: med['id'],
                name: med['name'],
                unit: med['unit'],
                img: med['img'],
                details: med['details'],
                endDate: med['endDate'] != null
                    ? DateTime.parse(med['endDate'])
                    : null,
                reminderDays: med['reminderDays'],
              ))
          .toList();

      emit(MedicationLoaded(medications));
    } catch (e) {
      emit(MedicationError(e.toString()));
    }
  }
}
