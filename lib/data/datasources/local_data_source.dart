import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:ultimate_finance/models/budget_category.dart';
import 'package:ultimate_finance/models/types.dart';
import 'package:ultimate_finance/models/transaction.dart';
import 'abstract_local_data_source.dart';

part 'local_data_source.g.dart';

// ======== Tables ========

@UseRowClass(BudgetCategory)
class BudgetCategories extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  IntColumn get type => integer().map(EnumIndexConverter(Types.values))();
}

@UseRowClass(BudgetPeriod)
class BudgetPeriods extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get categoryId => integer().references(BudgetCategories, #id)();
  DateTimeColumn get period => dateTime()();
  RealColumn get budgetedAmount => real()();

  @override
  List<String> get customConstraints => [
        'UNIQUE(categoryId, period)',
      ];
}

@UseRowClass(Transaction)
class Transactions extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get date => dateTime()();
  IntColumn get type => integer().map(EnumIndexConverter(Types.values))();
  IntColumn get categoryId => integer()();
  RealColumn get amount => real()();
  TextColumn get description => text().nullable()();
}

 // ======== DAOs ========

@DriftAccessor(tables: [BudgetCategories, BudgetPeriods])
class BudgetDao extends DatabaseAccessor<LocalDatabase> with _$BudgetDaoMixin {
  BudgetDao(super.db);

  Stream<List<BudgetCategory>> watchAllBudgetCategories() {
    return select(budgetCategories).watch();
  }

  Future<void> addBudgetCategory(String name, Types type) {
    return into(budgetCategories).insert(
      BudgetCategoriesCompanion.insert(name: name, type: type),
    );
  }

  Stream<List<BudgetPeriod>> watchAllBudgetPeriods() {
    return select(budgetPeriods).watch();
  }

  Future<void> addBudgetPeriod(int categoryId, DateTime period, double budgetedAmount) {
    return into(budgetPeriods).insert(
      BudgetPeriodsCompanion.insert(
        categoryId: categoryId,
        period: period,
        budgetedAmount: budgetedAmount,
      ),
    );
  }

  Future<void> updateBudgetPeriod(BudgetPeriod budgetPeriod) {
    return into(budgetPeriods).insertOnConflictUpdate(budgetPeriod.toCompanion(true));
  }
}

@DriftAccessor(tables: [Transactions])
class TransactionDao extends DatabaseAccessor<LocalDatabase> with _$TransactionDaoMixin {
  TransactionDao(super.db);

  Stream<List<Transaction>> watchAllTransactions() {
    return select(transactions).watch();
  }

  Future<void> addTransaction({
    required DateTime date,
    required Types type,
    required int categoryId,
    required double amount,
    String? description,
  }) {
    return into(transactions).insert(
      TransactionsCompanion.insert(
        date: date,
        type: type,
        categoryId: categoryId,
        amount: amount,
        description: Value(description),
      ),
    );
  }

  Future<void> updateTransaction(Transaction transaction) {
    return update(transactions).replace(
      TransactionsCompanion(
        id: Value(transaction.id),
        date: Value(transaction.date),
        type: Value(transaction.type),
        categoryId: Value(transaction.categoryId),
        amount: Value(transaction.amount),
        description: Value(transaction.description),
      ),
    );
  }

  Future<void> deleteTransaction(int id) {
    return (delete(transactions)..where((t) => t.id.equals(id))).go();
  }
}

// ======== Database ========

@DriftDatabase(tables: [BudgetCategories, BudgetPeriods, Transactions], daos: [BudgetDao, TransactionDao])
class LocalDatabase extends _$LocalDatabase implements ILocalDataSource {
  LocalDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 2;

  @override
  Stream<List<BudgetCategory>> watchAllBudgetCategories() {
    return budgetDao.watchAllBudgetCategories(); 
  }

  @override
  Future<void> addBudgetCategory(String name, Types type) {
    return budgetDao.addBudgetCategory(name, type); 
  }

  @override
  Stream<List<BudgetPeriod>> watchAllBudgetPeriods() {
    return budgetDao.watchAllBudgetPeriods();
  }

  @override
  Future<void> addBudgetPeriod(int categoryId, DateTime period, double budgetedAmount) {
    return budgetDao.addBudgetPeriod(categoryId, period, budgetedAmount); 
  }

  @override
  Future<void> updateBudgetPeriod(int categoryId, DateTime period, double budgetedAmount) {
    final startOfMonth = DateTime(period.year, period.month, 1);
    final budgetPeriod = BudgetPeriod(
      id: -1,
      categoryId: categoryId,
      period: startOfMonth,
      budgetedAmount: budgetedAmount,
    );
    return budgetDao.updateBudgetPeriod(budgetPeriod);
  }

  @override
  Stream<List<Transaction>> watchAllTransactions() {
    return transactionDao.watchAllTransactions();
  }

  @override
  Future<void> addTransaction({
    required DateTime date,
    required Types type,
    required int categoryId,
    required double amount,
    String? description,
  }) {
    return transactionDao.addTransaction(
      date: date,
      type: type,
      categoryId: categoryId,
      amount: amount,
      description: description,
    );
  }

  @override
  Future<void> updateTransaction(Transaction transaction) {   
    return transactionDao.updateTransaction(transaction); 
  }

  @override
  Future<void> deleteTransaction(int id) {
    return transactionDao.deleteTransaction(id);
  }
}

extension on BudgetPeriod {
  BudgetPeriodsCompanion toCompanion(bool nullToAbsent) {
    return BudgetPeriodsCompanion(
      categoryId: Value(categoryId),
      period: Value(period),
      budgetedAmount: Value(budgetedAmount),
    );
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}