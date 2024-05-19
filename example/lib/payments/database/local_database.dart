import 'package:example/common/component/base_bloc.dart';
import 'package:example/common/injection/injection.dart';
import 'package:example/payments/payment.model.dart';
import 'package:isar/isar.dart';

class PaymentsLocalDatabaseService<T extends BaseModel<T>>
    extends BaseRepository<T> {
  Isar get _isar => getIt<Isar>();

  @override
  Future<T> read(String id) async {
    final documentMatches =
        await _isar.payments.filter().idEqualTo(id).findAll();
    final document = documentMatches.first;
    return document as T;
  }

  @override
  Future<T> create(T entity) async {
    _isar.writeTxn(() => _isar.payments.put(entity as Payment));
    return entity;
  }

  @override
  Future<T> update(String id, T entity) async {
    _isar.writeTxn(() => _isar.payments.put(entity as Payment));
    return entity;
  }

  @override
  Future<void> fetchAllDocuments(
      {required Function(List<T> documents, int pageNumber)
          onDocuments}) async {
    final allDocuments =
        await _isar.payments.filter().syncToRemoteEqualTo(true).findAll();
    onDocuments.call(allDocuments.cast<T>(), 1);
  }

  @override
  Future<void> delete(String id) async {
    final entity = await read(id);
    _isar.writeTxn(() => _isar.payments.delete((entity as Payment).isarId));
  }
}
