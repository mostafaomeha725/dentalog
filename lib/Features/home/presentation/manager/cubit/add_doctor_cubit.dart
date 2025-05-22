import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dentalog/Features/home/presentation/data/models/doctors_model.dart';
import 'package:meta/meta.dart';

part 'add_doctor_state.dart';

class AddDoctorCubit extends Cubit<AddDoctorState> {
  AddDoctorCubit() : super(AddDoctorInitial());

  final List<DoctorsModel> _doctorsModel = [];

  List<DoctorsModel> get doctorsModel => List.unmodifiable(_doctorsModel);

  final CollectionReference doctorsCollection =
      FirebaseFirestore.instance.collection('doctors');

  Future<void> getDoctors() async {
    emit(AddDoctorLoading());

    try {
      // تفريغ القائمة لتجنب التكرار في كل استدعاء
      _doctorsModel.clear();

      // جلب البيانات من Firestore
      QuerySnapshot querySnapshot = await doctorsCollection.get();

      // تحويل البيانات إلى List<DoctorsModel>
      _doctorsModel.addAll(querySnapshot.docs.map((doc) {
        return DoctorsModel.fromJson(doc.data() as Map<String, dynamic>);
      }));
      //print lenth of list
      print(_doctorsModel.length);

      emit(AddDoctorSuccess());
    } catch (e) {
      emit(AddDoctorFailure(e.toString()));
    }
  }
}
