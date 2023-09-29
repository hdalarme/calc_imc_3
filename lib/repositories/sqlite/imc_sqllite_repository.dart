import 'package:calc_imc_2/model/imc_model.dart';
import 'package:calc_imc_2/repositories/sqlite/sqlitedatabase.dart';

class IMCSQLiteRepository {
Future<List<IMCModel>> obterDados() async {
    List<IMCModel> imcModel = [];
    var db = await SQLiteDataBase().obterDataBase();
    var result = await db.rawQuery('SELECT id, data, nome, peso, altura FROM imcs');
    for (var element in result) {
      imcModel.add(
        IMCModel(int.parse(
          element["id"].toString()),
          element["data"].toString(), 
          element["nome"].toString(), 
          element["peso"].toString(), 
          element["altura"].toString(), 
        )
      );
    }
    return imcModel;
  }

  Future<void> salvar(IMCModel imcModel) async {
    var db = await SQLiteDataBase().obterDataBase();
    await db.rawInsert(
        'INSERT INTO imcs (data, nome, peso, altura) values(?,?,?,?)',
        [imcModel.data, imcModel.nome, imcModel.peso, imcModel.altura]);
  }

  Future<void> atualizar(IMCModel imcModel) async {
    var db = await SQLiteDataBase().obterDataBase();
    await db.rawInsert(
        'UPDATE imcs SET data = ?, nome = ?, peso = ?, altura = ? WHERE id = ?',
        [
          imcModel.data,
          imcModel.nome,
          imcModel.peso,
          imcModel.altura,
          imcModel.id
        ]);
  }

  Future<void> remover(int id) async {
    var db = await SQLiteDataBase().obterDataBase();
    await db.rawInsert('DELETE FROM imcs WHERE id = ?', [id]);
  }
}
