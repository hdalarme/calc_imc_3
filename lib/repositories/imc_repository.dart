import 'package:calc_imc_2/model/imc_model.dart';

class IMCRepository {
  final List<IMCModel> _IMCs = [];

  Future<void> adicinar(IMCModel imc) async {
    await Future.delayed(const Duration(milliseconds: 100));
    _IMCs.add(imc);
  }

  Future<void> remove(String id) async {
    await Future.delayed(const Duration(milliseconds: 100));
    _IMCs.remove(_IMCs.where((imc) => imc.id == id).first);
  }

  Future<List<IMCModel>> listar() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return _IMCs;
  }
}