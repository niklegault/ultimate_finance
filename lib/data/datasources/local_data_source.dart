import 'dart:io';
import 'dart:math';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:ultimate_finance/models/budget_category.dart';
import 'package:ultimate_finance/models/types.dart';
import 'abstract_local_data_source.dart';

part 'local_data_source.g.dart';

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
}

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
}

@DriftDatabase(tables: [BudgetCategories, BudgetPeriods], daos: [BudgetDao])
class LocalDatabase extends _$LocalDatabase implements ILocalDataSource {
  LocalDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

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
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}