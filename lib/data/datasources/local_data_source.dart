import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:ultimate_finance/models/budget_category.dart';
import 'package:ultimate_finance/models/types.dart';
import 'package:ultimate_finance/models/transaction.dart' as app_transaction;
import 'package:ultimate_finance/models/account.dart';
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
  IntColumn get categoryId =>
      integer().references(
        BudgetCategories,
        #id,
        onDelete: KeyAction.cascade,
      )();
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
  IntColumn get categoryId =>
      integer().references(
        BudgetCategories,
        #id,
        onDelete: KeyAction.setNull,
      )();
  RealColumn get amount => real()();
  TextColumn get description => text().nullable()();
}

@UseRowClass(Account)
class Accounts extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get catId =>
      integer().references(
        BudgetCategories,
        #id,
        onDelete: KeyAction.cascade,
      )();
  TextColumn get name => text()();
  IntColumn get type => integer().map(EnumIndexConverter(Types.values))();
  @override
  List<String> get customConstraints => ['UNIQUE(cat_id, name)'];
}

@UseRowClass(AccountPeriod)
class AccountPeriods extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get accountId =>
      integer().references(Accounts, #id, onDelete: KeyAction.cascade)();
  DateTimeColumn get period => dateTime()();
  RealColumn get balance => real()();
  RealColumn get deposits => real()();
  RealColumn get withdrawals => real()();
  RealColumn get interest => real()();
  @override
  List<String> get customConstraints => ['UNIQUE(account_id, period)'];
}

// ======== DAOs ========
@DriftAccessor(tables: [BudgetCategories, BudgetPeriods])
class BudgetDao extends DatabaseAccessor<LocalDatabase> with _$BudgetDaoMixin {
  BudgetDao(super.db);

  Stream<List<BudgetCategory>> watchAllBudgetCategories() =>
      select(budgetCategories).watch();
  Future<int> addBudgetCategory(String name, Types type) {
    return into(
      budgetCategories,
    ).insert(BudgetCategoriesCompanion.insert(name: name, type: type));
  }

  Future<void> updateBudgetCategory(BudgetCategory category) {
    return update(budgetCategories).replace(
      BudgetCategoriesCompanion(
        id: Value(category.id),
        name: Value(category.name),
        type: Value(category.type),
      ),
    );
  }

  Future<void> deleteBudgetCategory(int id) {
    return (delete(budgetCategories)..where((tbl) => tbl.id.equals(id))).go();
  }

  Stream<List<BudgetPeriod>> watchPeriodsForMonth(DateTime month) {
    final startOfMonth = DateTime(month.year, month.month, 1);
    return (select(budgetPeriods)
      ..where((tbl) => tbl.period.equals(startOfMonth))).watch();
  }

  Future<void> updateBudgetPeriod(BudgetPeriod period) {
    return into(budgetPeriods).insert(
      period.toCompanion(true),
      onConflict: DoUpdate(
        (old) => BudgetPeriodsCompanion.custom(
          budgetedAmount: Variable(period.budgetedAmount),
        ),
        target: [budgetPeriods.categoryId, budgetPeriods.period],
      ),
    );
  }
}

@DriftAccessor(tables: [Transactions])
class TransactionDao extends DatabaseAccessor<LocalDatabase>
    with _$TransactionDaoMixin {
  TransactionDao(super.db);
  Stream<List<app_transaction.Transaction>> watchAllTransactions() =>
      select(transactions).watch();
  Future<void> addTransaction(TransactionsCompanion transaction) =>
      into(transactions).insert(transaction);
  Future<void> updateTransaction(app_transaction.Transaction transaction) =>
      update(
        transactions,
      ).replace(transaction as Insertable<app_transaction.Transaction>);
  Future<void> deleteTransaction(int id) =>
      (delete(transactions)..where((t) => t.id.equals(id))).go();
}

@DriftAccessor(tables: [Accounts, AccountPeriods])
class AccountDao extends DatabaseAccessor<LocalDatabase>
    with _$AccountDaoMixin {
  AccountDao(super.db);

  Stream<List<Account>> watchAllAccounts() => select(accounts).watch();
  Future<int> addAccount(String name, Types type, int catId) {
    return into(
      accounts,
    ).insert(AccountsCompanion.insert(name: name, type: type, catId: catId));
  }

  Future<void> updateAccount(Account account) {
    return update(accounts).replace(
      AccountsCompanion(
        id: Value(account.id),
        name: Value(account.name),
        type: Value(account.type),
      ),
    );
  }

  Future<void> deleteAccount(int id) {
    return (delete(accounts)..where((tbl) => tbl.id.equals(id))).go();
  }

  Stream<List<AccountPeriod>> watchAccountPeriodsForMonth(DateTime month) {
    final startOfMonth = DateTime(month.year, month.month, 1);
    return (select(accountPeriods)
      ..where((tbl) => tbl.period.equals(startOfMonth))).watch();
  }

  Future<void> updateAccountPeriod(AccountPeriod period) {
    return into(accountPeriods).insert(
      period.toCompanion(true),
      onConflict: DoUpdate(
        (old) => AccountPeriodsCompanion.custom(
          balance: Variable(period.balance),
          deposits: Variable(period.deposits),
          withdrawals: Variable(period.withdrawals),
          interest: Variable(period.interest),
        ),
        target: [accountPeriods.accountId, accountPeriods.period],
      ),
    );
  }
}

// ======== Database ========

@DriftDatabase(
  tables: [
    BudgetCategories,
    BudgetPeriods,
    Transactions,
    Accounts,
    AccountPeriods,
  ],
  daos: [BudgetDao, TransactionDao, AccountDao],
)
class LocalDatabase extends _$LocalDatabase implements ILocalDataSource {
  LocalDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 3; // Version 2 because you have multiple tables

  // --- THIS IS THE CRITICAL FIX FOR THE LOADING SCREEN ---
  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate:
          (Migrator m) => m.createAll(), // Creates all tables on first launch
      onUpgrade: (Migrator m, int from, int to) async {
        // This runs only if a user already has an older version of the app
        if (from < 2) {
          await m.createTable(budgetPeriods);
          await m.createTable(transactions);
        }
        if (from < 3) {
          await m.createTable(accounts);
          await m.createTable(accountPeriods);
        }
      },
    );
  }

  // --- ILocalDataSource Implementation ---
  @override
  Stream<List<BudgetCategory>> watchAllBudgetCategories() =>
      budgetDao.watchAllBudgetCategories();
  @override
  Future<int> addBudgetCategory(String name, Types type) =>
      budgetDao.addBudgetCategory(name, type);
  @override
  Future<void> updateBudgetCategory(BudgetCategory category) =>
      budgetDao.updateBudgetCategory(category);
  @override
  Future<void> deleteBudgetCategory(int id) =>
      budgetDao.deleteBudgetCategory(id);
  @override
  Stream<List<BudgetPeriod>> watchBudgetPeriodsForMonth(DateTime month) =>
      budgetDao.watchPeriodsForMonth(month);
  @override
  Future<void> updateBudgetPeriod(
    int categoryId,
    DateTime period,
    double budgetedAmount,
  ) {
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
  Stream<List<app_transaction.Transaction>> watchAllTransactions() =>
      transactionDao.watchAllTransactions();
  @override
  Future<void> addTransaction({
    required DateTime date,
    required Types type,
    required int categoryId,
    required double amount,
    String? description,
  }) {
    final companion = TransactionsCompanion.insert(
      date: date,
      type: type,
      categoryId: categoryId,
      amount: amount,
      description: Value(description),
    );
    return transactionDao.addTransaction(companion);
  }

  @override
  Future<void> updateTransaction(app_transaction.Transaction transaction) =>
      transactionDao.updateTransaction(transaction);
  @override
  Future<void> deleteTransaction(int id) =>
      transactionDao.deleteTransaction(id);

  @override
  Stream<List<Account>> watchAllAccounts() => accountDao.watchAllAccounts();
  @override
  Future<int> addAccount(String name, Types type, int catId) =>
      accountDao.addAccount(name, type, catId);
  @override
  Future<void> updateAccount(Account account) =>
      accountDao.updateAccount(account);
  @override
  Future<void> deleteAccount(int id) => accountDao.deleteAccount(id);

  @override
  Stream<List<AccountPeriod>> watchAccountPeriodsForMonth(DateTime month) =>
      accountDao.watchAccountPeriodsForMonth(month);
  @override
  Future<void> updateAccountPeriod(
    int accountId,
    DateTime period,
    double balance,
    double deposits,
    double withdrawals,
    double interest,
  ) {
    final startOfMonth = DateTime(period.year, period.month, 1);
    final accountPeriod = AccountPeriod(
      id: -1,
      accountId: accountId,
      period: startOfMonth,
      balance: balance,
      deposits: deposits,
      withdrawals: withdrawals,
      interest: interest,
    );
    return accountDao.updateAccountPeriod(accountPeriod);
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

extension on AccountPeriod {
  AccountPeriodsCompanion toCompanion(bool nullToAbsent) {
    return AccountPeriodsCompanion(
      accountId: Value(accountId),
      period: Value(period),
      balance: Value(balance),
      deposits: Value(deposits),
      withdrawals: Value(withdrawals),
      interest: Value(interest),
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
