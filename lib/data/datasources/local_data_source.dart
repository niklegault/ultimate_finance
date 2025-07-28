import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:ultimate_finance/models/budget_category.dart';
import 'package:ultimate_finance/models/types.dart';
import 'package:ultimate_finance/models/transaction.dart' as app_transaction;
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
  IntColumn get categoryId => integer().references(BudgetCategories, #id, onDelete: KeyAction.cascade)();
  DateTimeColumn get period => dateTime()();
  RealColumn get budgetedAmount => real()();
  @override
  List<String> get customConstraints => ['UNIQUE(category_id, period)'];
}

@UseRowClass(app_transaction.Transaction)
class Transactions extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get date => dateTime()();
  IntColumn get type => integer().map(EnumIndexConverter(Types.values))();
  IntColumn get categoryId => integer().references(BudgetCategories, #id, onDelete: KeyAction.setNull)();
  RealColumn get amount => real()();
  TextColumn get description => text().nullable()();
}

// ======== DAOs ========

@DriftAccessor(tables: [BudgetCategories, BudgetPeriods])
class BudgetDao extends DatabaseAccessor<LocalDatabase> with _$BudgetDaoMixin {
  BudgetDao(super.db);

  Stream<List<BudgetCategory>> watchAllBudgetCategories() => select(budgetCategories).watch();
  Future<int> addBudgetCategory(String name, Types type) {
    return into(budgetCategories).insert(BudgetCategoriesCompanion.insert(name: name, type: type));
  }
  Stream<List<BudgetPeriod>> watchPeriodsForMonth(DateTime month) {
    final startOfMonth = DateTime(month.year, month.month, 1);
    return (select(budgetPeriods)..where((tbl) => tbl.period.equals(startOfMonth))).watch();
  }

  Future<void> updateBudgetPeriod(BudgetPeriod period) => into(budgetPeriods).insertOnConflictUpdate(period.toCompanion(true));
}

@DriftAccessor(tables: [Transactions])
class TransactionDao extends DatabaseAccessor<LocalDatabase> with _$TransactionDaoMixin {
  TransactionDao(super.db);
  Stream<List<app_transaction.Transaction>> watchAllTransactions() => select(transactions).watch();
  Future<void> addTransaction(TransactionsCompanion transaction) => into(transactions).insert(transaction);
  Future<void> updateTransaction(app_transaction.Transaction transaction) => update(transactions).replace(transaction as Insertable<app_transaction.Transaction>);
  Future<void> deleteTransaction(int id) => (delete(transactions)..where((t) => t.id.equals(id))).go();
}

// ======== Database ========

@DriftDatabase(tables: [BudgetCategories, BudgetPeriods, Transactions], daos: [BudgetDao, TransactionDao])
class LocalDatabase extends _$LocalDatabase implements ILocalDataSource {
  LocalDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 2; // Version 2 because you have multiple tables

  // --- THIS IS THE CRITICAL FIX FOR THE LOADING SCREEN ---
  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) => m.createAll(), // Creates all tables on first launch
      onUpgrade: (Migrator m, int from, int to) async {
        // This runs only if a user already has an older version of the app
        if (from == 1) {
          await m.createTable(budgetPeriods);
          await m.createTable(transactions);
        }
      },
    );
  }

  // --- ILocalDataSource Implementation ---
  @override
  Stream<List<BudgetCategory>> watchAllBudgetCategories() => budgetDao.watchAllBudgetCategories();
  @override
  Future<int> addBudgetCategory(String name, Types type) => budgetDao.addBudgetCategory(name, type);
  @override
  Stream<List<BudgetPeriod>> watchBudgetPeriodsForMonth(DateTime month) => budgetDao.watchPeriodsForMonth(month);
  @override
  Future<void> updateBudgetPeriod(int categoryId, DateTime period, double budgetedAmount) {
    final startOfMonth = DateTime(period.year, period.month, 1);
    final budgetPeriod = BudgetPeriod(id: -1, categoryId: categoryId, period: startOfMonth, budgetedAmount: budgetedAmount);
    return budgetDao.updateBudgetPeriod(budgetPeriod);
  }
  @override
  Stream<List<app_transaction.Transaction>> watchAllTransactions() => transactionDao.watchAllTransactions();
  @override
  Future<void> addTransaction({required DateTime date, required Types type, required int categoryId, required double amount, String? description}) {
    final companion = TransactionsCompanion.insert(date: date, type: type, categoryId: categoryId, amount: amount, description: Value(description));
    return transactionDao.addTransaction(companion);
  }
  @override
  Future<void> updateTransaction(app_transaction.Transaction transaction) => transactionDao.updateTransaction(transaction);
  @override
  Future<void> deleteTransaction(int id) => transactionDao.deleteTransaction(id);
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