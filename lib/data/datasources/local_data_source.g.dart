// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_data_source.dart';

// ignore_for_file: type=lint
mixin _$BudgetDaoMixin on DatabaseAccessor<LocalDatabase> {
  $BudgetCategoriesTable get budgetCategories =>
      attachedDatabase.budgetCategories;
  $BudgetPeriodsTable get budgetPeriods => attachedDatabase.budgetPeriods;
}
mixin _$TransactionDaoMixin on DatabaseAccessor<LocalDatabase> {
  $BudgetCategoriesTable get budgetCategories =>
      attachedDatabase.budgetCategories;
  $TransactionsTable get transactions => attachedDatabase.transactions;
}
mixin _$AccountDaoMixin on DatabaseAccessor<LocalDatabase> {
  $BudgetCategoriesTable get budgetCategories =>
      attachedDatabase.budgetCategories;
  $AccountsTable get accounts => attachedDatabase.accounts;
  $AccountPeriodsTable get accountPeriods => attachedDatabase.accountPeriods;
}

class $BudgetCategoriesTable extends BudgetCategories
    with TableInfo<$BudgetCategoriesTable, BudgetCategory> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BudgetCategoriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<Types, int> type =
      GeneratedColumn<int>(
        'type',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<Types>($BudgetCategoriesTable.$convertertype);
  @override
  List<GeneratedColumn> get $columns => [id, name, type];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'budget_categories';
  @override
  VerificationContext validateIntegrity(
    Insertable<BudgetCategory> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BudgetCategory map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BudgetCategory(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      name:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}name'],
          )!,
      type: $BudgetCategoriesTable.$convertertype.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}type'],
        )!,
      ),
    );
  }

  @override
  $BudgetCategoriesTable createAlias(String alias) {
    return $BudgetCategoriesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<Types, int, int> $convertertype =
      EnumIndexConverter(Types.values);
}

class BudgetCategoriesCompanion extends UpdateCompanion<BudgetCategory> {
  final Value<int> id;
  final Value<String> name;
  final Value<Types> type;
  const BudgetCategoriesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.type = const Value.absent(),
  });
  BudgetCategoriesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required Types type,
  }) : name = Value(name),
       type = Value(type);
  static Insertable<BudgetCategory> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<int>? type,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (type != null) 'type': type,
    });
  }

  BudgetCategoriesCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<Types>? type,
  }) {
    return BudgetCategoriesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (type.present) {
      map['type'] = Variable<int>(
        $BudgetCategoriesTable.$convertertype.toSql(type.value),
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BudgetCategoriesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('type: $type')
          ..write(')'))
        .toString();
  }
}

class $BudgetPeriodsTable extends BudgetPeriods
    with TableInfo<$BudgetPeriodsTable, BudgetPeriod> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BudgetPeriodsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _categoryIdMeta = const VerificationMeta(
    'categoryId',
  );
  @override
  late final GeneratedColumn<int> categoryId = GeneratedColumn<int>(
    'category_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES budget_categories (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _periodMeta = const VerificationMeta('period');
  @override
  late final GeneratedColumn<DateTime> period = GeneratedColumn<DateTime>(
    'period',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _budgetedAmountMeta = const VerificationMeta(
    'budgetedAmount',
  );
  @override
  late final GeneratedColumn<double> budgetedAmount = GeneratedColumn<double>(
    'budgeted_amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    categoryId,
    period,
    budgetedAmount,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'budget_periods';
  @override
  VerificationContext validateIntegrity(
    Insertable<BudgetPeriod> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('category_id')) {
      context.handle(
        _categoryIdMeta,
        categoryId.isAcceptableOrUnknown(data['category_id']!, _categoryIdMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryIdMeta);
    }
    if (data.containsKey('period')) {
      context.handle(
        _periodMeta,
        period.isAcceptableOrUnknown(data['period']!, _periodMeta),
      );
    } else if (isInserting) {
      context.missing(_periodMeta);
    }
    if (data.containsKey('budgeted_amount')) {
      context.handle(
        _budgetedAmountMeta,
        budgetedAmount.isAcceptableOrUnknown(
          data['budgeted_amount']!,
          _budgetedAmountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_budgetedAmountMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BudgetPeriod map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BudgetPeriod(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      categoryId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}category_id'],
          )!,
      period:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}period'],
          )!,
      budgetedAmount:
          attachedDatabase.typeMapping.read(
            DriftSqlType.double,
            data['${effectivePrefix}budgeted_amount'],
          )!,
    );
  }

  @override
  $BudgetPeriodsTable createAlias(String alias) {
    return $BudgetPeriodsTable(attachedDatabase, alias);
  }
}

class BudgetPeriodsCompanion extends UpdateCompanion<BudgetPeriod> {
  final Value<int> id;
  final Value<int> categoryId;
  final Value<DateTime> period;
  final Value<double> budgetedAmount;
  const BudgetPeriodsCompanion({
    this.id = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.period = const Value.absent(),
    this.budgetedAmount = const Value.absent(),
  });
  BudgetPeriodsCompanion.insert({
    this.id = const Value.absent(),
    required int categoryId,
    required DateTime period,
    required double budgetedAmount,
  }) : categoryId = Value(categoryId),
       period = Value(period),
       budgetedAmount = Value(budgetedAmount);
  static Insertable<BudgetPeriod> custom({
    Expression<int>? id,
    Expression<int>? categoryId,
    Expression<DateTime>? period,
    Expression<double>? budgetedAmount,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (categoryId != null) 'category_id': categoryId,
      if (period != null) 'period': period,
      if (budgetedAmount != null) 'budgeted_amount': budgetedAmount,
    });
  }

  BudgetPeriodsCompanion copyWith({
    Value<int>? id,
    Value<int>? categoryId,
    Value<DateTime>? period,
    Value<double>? budgetedAmount,
  }) {
    return BudgetPeriodsCompanion(
      id: id ?? this.id,
      categoryId: categoryId ?? this.categoryId,
      period: period ?? this.period,
      budgetedAmount: budgetedAmount ?? this.budgetedAmount,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<int>(categoryId.value);
    }
    if (period.present) {
      map['period'] = Variable<DateTime>(period.value);
    }
    if (budgetedAmount.present) {
      map['budgeted_amount'] = Variable<double>(budgetedAmount.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BudgetPeriodsCompanion(')
          ..write('id: $id, ')
          ..write('categoryId: $categoryId, ')
          ..write('period: $period, ')
          ..write('budgetedAmount: $budgetedAmount')
          ..write(')'))
        .toString();
  }
}

class $TransactionsTable extends Transactions
    with TableInfo<$TransactionsTable, app_transaction.Transaction> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TransactionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<Types, int> type =
      GeneratedColumn<int>(
        'type',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<Types>($TransactionsTable.$convertertype);
  static const VerificationMeta _categoryIdMeta = const VerificationMeta(
    'categoryId',
  );
  @override
  late final GeneratedColumn<int> categoryId = GeneratedColumn<int>(
    'category_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES budget_categories (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    date,
    type,
    categoryId,
    amount,
    description,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'transactions';
  @override
  VerificationContext validateIntegrity(
    Insertable<app_transaction.Transaction> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('category_id')) {
      context.handle(
        _categoryIdMeta,
        categoryId.isAcceptableOrUnknown(data['category_id']!, _categoryIdMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryIdMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  app_transaction.Transaction map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return app_transaction.Transaction(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      date:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}date'],
          )!,
      type: $TransactionsTable.$convertertype.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}type'],
        )!,
      ),
      categoryId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}category_id'],
          )!,
      amount:
          attachedDatabase.typeMapping.read(
            DriftSqlType.double,
            data['${effectivePrefix}amount'],
          )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
    );
  }

  @override
  $TransactionsTable createAlias(String alias) {
    return $TransactionsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<Types, int, int> $convertertype =
      EnumIndexConverter(Types.values);
}

class TransactionsCompanion
    extends UpdateCompanion<app_transaction.Transaction> {
  final Value<int> id;
  final Value<DateTime> date;
  final Value<Types> type;
  final Value<int> categoryId;
  final Value<double> amount;
  final Value<String?> description;
  const TransactionsCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.type = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.amount = const Value.absent(),
    this.description = const Value.absent(),
  });
  TransactionsCompanion.insert({
    this.id = const Value.absent(),
    required DateTime date,
    required Types type,
    required int categoryId,
    required double amount,
    this.description = const Value.absent(),
  }) : date = Value(date),
       type = Value(type),
       categoryId = Value(categoryId),
       amount = Value(amount);
  static Insertable<app_transaction.Transaction> custom({
    Expression<int>? id,
    Expression<DateTime>? date,
    Expression<int>? type,
    Expression<int>? categoryId,
    Expression<double>? amount,
    Expression<String>? description,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (type != null) 'type': type,
      if (categoryId != null) 'category_id': categoryId,
      if (amount != null) 'amount': amount,
      if (description != null) 'description': description,
    });
  }

  TransactionsCompanion copyWith({
    Value<int>? id,
    Value<DateTime>? date,
    Value<Types>? type,
    Value<int>? categoryId,
    Value<double>? amount,
    Value<String?>? description,
  }) {
    return TransactionsCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      type: type ?? this.type,
      categoryId: categoryId ?? this.categoryId,
      amount: amount ?? this.amount,
      description: description ?? this.description,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (type.present) {
      map['type'] = Variable<int>(
        $TransactionsTable.$convertertype.toSql(type.value),
      );
    }
    if (categoryId.present) {
      map['category_id'] = Variable<int>(categoryId.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TransactionsCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('type: $type, ')
          ..write('categoryId: $categoryId, ')
          ..write('amount: $amount, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }
}

class $AccountsTable extends Accounts with TableInfo<$AccountsTable, Account> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AccountsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _categoryIdMeta = const VerificationMeta(
    'categoryId',
  );
  @override
  late final GeneratedColumn<int> categoryId = GeneratedColumn<int>(
    'category_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'UNIQUE REFERENCES budget_categories (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<Types, int> type =
      GeneratedColumn<int>(
        'type',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<Types>($AccountsTable.$convertertype);
  @override
  List<GeneratedColumn> get $columns => [id, categoryId, name, type];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'accounts';
  @override
  VerificationContext validateIntegrity(
    Insertable<Account> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('category_id')) {
      context.handle(
        _categoryIdMeta,
        categoryId.isAcceptableOrUnknown(data['category_id']!, _categoryIdMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Account map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Account(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      categoryId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}category_id'],
          )!,
      name:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}name'],
          )!,
      type: $AccountsTable.$convertertype.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}type'],
        )!,
      ),
    );
  }

  @override
  $AccountsTable createAlias(String alias) {
    return $AccountsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<Types, int, int> $convertertype =
      EnumIndexConverter(Types.values);
}

class AccountsCompanion extends UpdateCompanion<Account> {
  final Value<int> id;
  final Value<int> categoryId;
  final Value<String> name;
  final Value<Types> type;
  const AccountsCompanion({
    this.id = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.name = const Value.absent(),
    this.type = const Value.absent(),
  });
  AccountsCompanion.insert({
    this.id = const Value.absent(),
    required int categoryId,
    required String name,
    required Types type,
  }) : categoryId = Value(categoryId),
       name = Value(name),
       type = Value(type);
  static Insertable<Account> custom({
    Expression<int>? id,
    Expression<int>? categoryId,
    Expression<String>? name,
    Expression<int>? type,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (categoryId != null) 'category_id': categoryId,
      if (name != null) 'name': name,
      if (type != null) 'type': type,
    });
  }

  AccountsCompanion copyWith({
    Value<int>? id,
    Value<int>? categoryId,
    Value<String>? name,
    Value<Types>? type,
  }) {
    return AccountsCompanion(
      id: id ?? this.id,
      categoryId: categoryId ?? this.categoryId,
      name: name ?? this.name,
      type: type ?? this.type,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<int>(categoryId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (type.present) {
      map['type'] = Variable<int>(
        $AccountsTable.$convertertype.toSql(type.value),
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AccountsCompanion(')
          ..write('id: $id, ')
          ..write('categoryId: $categoryId, ')
          ..write('name: $name, ')
          ..write('type: $type')
          ..write(')'))
        .toString();
  }
}

class $AccountPeriodsTable extends AccountPeriods
    with TableInfo<$AccountPeriodsTable, AccountPeriod> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AccountPeriodsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _accountIdMeta = const VerificationMeta(
    'accountId',
  );
  @override
  late final GeneratedColumn<int> accountId = GeneratedColumn<int>(
    'account_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES accounts (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _periodMeta = const VerificationMeta('period');
  @override
  late final GeneratedColumn<DateTime> period = GeneratedColumn<DateTime>(
    'period',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _balanceMeta = const VerificationMeta(
    'balance',
  );
  @override
  late final GeneratedColumn<double> balance = GeneratedColumn<double>(
    'balance',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _depositsMeta = const VerificationMeta(
    'deposits',
  );
  @override
  late final GeneratedColumn<double> deposits = GeneratedColumn<double>(
    'deposits',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _withdrawalsMeta = const VerificationMeta(
    'withdrawals',
  );
  @override
  late final GeneratedColumn<double> withdrawals = GeneratedColumn<double>(
    'withdrawals',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _interestMeta = const VerificationMeta(
    'interest',
  );
  @override
  late final GeneratedColumn<double> interest = GeneratedColumn<double>(
    'interest',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    accountId,
    period,
    balance,
    deposits,
    withdrawals,
    interest,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'account_periods';
  @override
  VerificationContext validateIntegrity(
    Insertable<AccountPeriod> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('account_id')) {
      context.handle(
        _accountIdMeta,
        accountId.isAcceptableOrUnknown(data['account_id']!, _accountIdMeta),
      );
    } else if (isInserting) {
      context.missing(_accountIdMeta);
    }
    if (data.containsKey('period')) {
      context.handle(
        _periodMeta,
        period.isAcceptableOrUnknown(data['period']!, _periodMeta),
      );
    } else if (isInserting) {
      context.missing(_periodMeta);
    }
    if (data.containsKey('balance')) {
      context.handle(
        _balanceMeta,
        balance.isAcceptableOrUnknown(data['balance']!, _balanceMeta),
      );
    } else if (isInserting) {
      context.missing(_balanceMeta);
    }
    if (data.containsKey('deposits')) {
      context.handle(
        _depositsMeta,
        deposits.isAcceptableOrUnknown(data['deposits']!, _depositsMeta),
      );
    } else if (isInserting) {
      context.missing(_depositsMeta);
    }
    if (data.containsKey('withdrawals')) {
      context.handle(
        _withdrawalsMeta,
        withdrawals.isAcceptableOrUnknown(
          data['withdrawals']!,
          _withdrawalsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_withdrawalsMeta);
    }
    if (data.containsKey('interest')) {
      context.handle(
        _interestMeta,
        interest.isAcceptableOrUnknown(data['interest']!, _interestMeta),
      );
    } else if (isInserting) {
      context.missing(_interestMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AccountPeriod map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AccountPeriod(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      accountId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}account_id'],
          )!,
      period:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}period'],
          )!,
      balance:
          attachedDatabase.typeMapping.read(
            DriftSqlType.double,
            data['${effectivePrefix}balance'],
          )!,
      deposits:
          attachedDatabase.typeMapping.read(
            DriftSqlType.double,
            data['${effectivePrefix}deposits'],
          )!,
      withdrawals:
          attachedDatabase.typeMapping.read(
            DriftSqlType.double,
            data['${effectivePrefix}withdrawals'],
          )!,
      interest:
          attachedDatabase.typeMapping.read(
            DriftSqlType.double,
            data['${effectivePrefix}interest'],
          )!,
    );
  }

  @override
  $AccountPeriodsTable createAlias(String alias) {
    return $AccountPeriodsTable(attachedDatabase, alias);
  }
}

class AccountPeriodsCompanion extends UpdateCompanion<AccountPeriod> {
  final Value<int> id;
  final Value<int> accountId;
  final Value<DateTime> period;
  final Value<double> balance;
  final Value<double> deposits;
  final Value<double> withdrawals;
  final Value<double> interest;
  const AccountPeriodsCompanion({
    this.id = const Value.absent(),
    this.accountId = const Value.absent(),
    this.period = const Value.absent(),
    this.balance = const Value.absent(),
    this.deposits = const Value.absent(),
    this.withdrawals = const Value.absent(),
    this.interest = const Value.absent(),
  });
  AccountPeriodsCompanion.insert({
    this.id = const Value.absent(),
    required int accountId,
    required DateTime period,
    required double balance,
    required double deposits,
    required double withdrawals,
    required double interest,
  }) : accountId = Value(accountId),
       period = Value(period),
       balance = Value(balance),
       deposits = Value(deposits),
       withdrawals = Value(withdrawals),
       interest = Value(interest);
  static Insertable<AccountPeriod> custom({
    Expression<int>? id,
    Expression<int>? accountId,
    Expression<DateTime>? period,
    Expression<double>? balance,
    Expression<double>? deposits,
    Expression<double>? withdrawals,
    Expression<double>? interest,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (accountId != null) 'account_id': accountId,
      if (period != null) 'period': period,
      if (balance != null) 'balance': balance,
      if (deposits != null) 'deposits': deposits,
      if (withdrawals != null) 'withdrawals': withdrawals,
      if (interest != null) 'interest': interest,
    });
  }

  AccountPeriodsCompanion copyWith({
    Value<int>? id,
    Value<int>? accountId,
    Value<DateTime>? period,
    Value<double>? balance,
    Value<double>? deposits,
    Value<double>? withdrawals,
    Value<double>? interest,
  }) {
    return AccountPeriodsCompanion(
      id: id ?? this.id,
      accountId: accountId ?? this.accountId,
      period: period ?? this.period,
      balance: balance ?? this.balance,
      deposits: deposits ?? this.deposits,
      withdrawals: withdrawals ?? this.withdrawals,
      interest: interest ?? this.interest,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (accountId.present) {
      map['account_id'] = Variable<int>(accountId.value);
    }
    if (period.present) {
      map['period'] = Variable<DateTime>(period.value);
    }
    if (balance.present) {
      map['balance'] = Variable<double>(balance.value);
    }
    if (deposits.present) {
      map['deposits'] = Variable<double>(deposits.value);
    }
    if (withdrawals.present) {
      map['withdrawals'] = Variable<double>(withdrawals.value);
    }
    if (interest.present) {
      map['interest'] = Variable<double>(interest.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AccountPeriodsCompanion(')
          ..write('id: $id, ')
          ..write('accountId: $accountId, ')
          ..write('period: $period, ')
          ..write('balance: $balance, ')
          ..write('deposits: $deposits, ')
          ..write('withdrawals: $withdrawals, ')
          ..write('interest: $interest')
          ..write(')'))
        .toString();
  }
}

abstract class _$LocalDatabase extends GeneratedDatabase {
  _$LocalDatabase(QueryExecutor e) : super(e);
  $LocalDatabaseManager get managers => $LocalDatabaseManager(this);
  late final $BudgetCategoriesTable budgetCategories = $BudgetCategoriesTable(
    this,
  );
  late final $BudgetPeriodsTable budgetPeriods = $BudgetPeriodsTable(this);
  late final $TransactionsTable transactions = $TransactionsTable(this);
  late final $AccountsTable accounts = $AccountsTable(this);
  late final $AccountPeriodsTable accountPeriods = $AccountPeriodsTable(this);
  late final BudgetDao budgetDao = BudgetDao(this as LocalDatabase);
  late final TransactionDao transactionDao = TransactionDao(
    this as LocalDatabase,
  );
  late final AccountDao accountDao = AccountDao(this as LocalDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    budgetCategories,
    budgetPeriods,
    transactions,
    accounts,
    accountPeriods,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'budget_categories',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('budget_periods', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'budget_categories',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('transactions', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'budget_categories',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('accounts', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'accounts',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('account_periods', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$BudgetCategoriesTableCreateCompanionBuilder =
    BudgetCategoriesCompanion Function({
      Value<int> id,
      required String name,
      required Types type,
    });
typedef $$BudgetCategoriesTableUpdateCompanionBuilder =
    BudgetCategoriesCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<Types> type,
    });

final class $$BudgetCategoriesTableReferences
    extends
        BaseReferences<
          _$LocalDatabase,
          $BudgetCategoriesTable,
          BudgetCategory
        > {
  $$BudgetCategoriesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$BudgetPeriodsTable, List<BudgetPeriod>>
  _budgetPeriodsRefsTable(_$LocalDatabase db) => MultiTypedResultKey.fromTable(
    db.budgetPeriods,
    aliasName: $_aliasNameGenerator(
      db.budgetCategories.id,
      db.budgetPeriods.categoryId,
    ),
  );

  $$BudgetPeriodsTableProcessedTableManager get budgetPeriodsRefs {
    final manager = $$BudgetPeriodsTableTableManager(
      $_db,
      $_db.budgetPeriods,
    ).filter((f) => f.categoryId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_budgetPeriodsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $TransactionsTable,
    List<app_transaction.Transaction>
  >
  _transactionsRefsTable(_$LocalDatabase db) => MultiTypedResultKey.fromTable(
    db.transactions,
    aliasName: $_aliasNameGenerator(
      db.budgetCategories.id,
      db.transactions.categoryId,
    ),
  );

  $$TransactionsTableProcessedTableManager get transactionsRefs {
    final manager = $$TransactionsTableTableManager(
      $_db,
      $_db.transactions,
    ).filter((f) => f.categoryId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_transactionsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$AccountsTable, List<Account>> _accountsRefsTable(
    _$LocalDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.accounts,
    aliasName: $_aliasNameGenerator(
      db.budgetCategories.id,
      db.accounts.categoryId,
    ),
  );

  $$AccountsTableProcessedTableManager get accountsRefs {
    final manager = $$AccountsTableTableManager(
      $_db,
      $_db.accounts,
    ).filter((f) => f.categoryId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_accountsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$BudgetCategoriesTableFilterComposer
    extends Composer<_$LocalDatabase, $BudgetCategoriesTable> {
  $$BudgetCategoriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<Types, Types, int> get type =>
      $composableBuilder(
        column: $table.type,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  Expression<bool> budgetPeriodsRefs(
    Expression<bool> Function($$BudgetPeriodsTableFilterComposer f) f,
  ) {
    final $$BudgetPeriodsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.budgetPeriods,
      getReferencedColumn: (t) => t.categoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BudgetPeriodsTableFilterComposer(
            $db: $db,
            $table: $db.budgetPeriods,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> transactionsRefs(
    Expression<bool> Function($$TransactionsTableFilterComposer f) f,
  ) {
    final $$TransactionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.transactions,
      getReferencedColumn: (t) => t.categoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TransactionsTableFilterComposer(
            $db: $db,
            $table: $db.transactions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> accountsRefs(
    Expression<bool> Function($$AccountsTableFilterComposer f) f,
  ) {
    final $$AccountsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.accounts,
      getReferencedColumn: (t) => t.categoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountsTableFilterComposer(
            $db: $db,
            $table: $db.accounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$BudgetCategoriesTableOrderingComposer
    extends Composer<_$LocalDatabase, $BudgetCategoriesTable> {
  $$BudgetCategoriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BudgetCategoriesTableAnnotationComposer
    extends Composer<_$LocalDatabase, $BudgetCategoriesTable> {
  $$BudgetCategoriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Types, int> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  Expression<T> budgetPeriodsRefs<T extends Object>(
    Expression<T> Function($$BudgetPeriodsTableAnnotationComposer a) f,
  ) {
    final $$BudgetPeriodsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.budgetPeriods,
      getReferencedColumn: (t) => t.categoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BudgetPeriodsTableAnnotationComposer(
            $db: $db,
            $table: $db.budgetPeriods,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> transactionsRefs<T extends Object>(
    Expression<T> Function($$TransactionsTableAnnotationComposer a) f,
  ) {
    final $$TransactionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.transactions,
      getReferencedColumn: (t) => t.categoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TransactionsTableAnnotationComposer(
            $db: $db,
            $table: $db.transactions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> accountsRefs<T extends Object>(
    Expression<T> Function($$AccountsTableAnnotationComposer a) f,
  ) {
    final $$AccountsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.accounts,
      getReferencedColumn: (t) => t.categoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountsTableAnnotationComposer(
            $db: $db,
            $table: $db.accounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$BudgetCategoriesTableTableManager
    extends
        RootTableManager<
          _$LocalDatabase,
          $BudgetCategoriesTable,
          BudgetCategory,
          $$BudgetCategoriesTableFilterComposer,
          $$BudgetCategoriesTableOrderingComposer,
          $$BudgetCategoriesTableAnnotationComposer,
          $$BudgetCategoriesTableCreateCompanionBuilder,
          $$BudgetCategoriesTableUpdateCompanionBuilder,
          (BudgetCategory, $$BudgetCategoriesTableReferences),
          BudgetCategory,
          PrefetchHooks Function({
            bool budgetPeriodsRefs,
            bool transactionsRefs,
            bool accountsRefs,
          })
        > {
  $$BudgetCategoriesTableTableManager(
    _$LocalDatabase db,
    $BudgetCategoriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () =>
                  $$BudgetCategoriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$BudgetCategoriesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer:
              () => $$BudgetCategoriesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<Types> type = const Value.absent(),
              }) => BudgetCategoriesCompanion(id: id, name: name, type: type),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required Types type,
              }) => BudgetCategoriesCompanion.insert(
                id: id,
                name: name,
                type: type,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$BudgetCategoriesTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({
            budgetPeriodsRefs = false,
            transactionsRefs = false,
            accountsRefs = false,
          }) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (budgetPeriodsRefs) db.budgetPeriods,
                if (transactionsRefs) db.transactions,
                if (accountsRefs) db.accounts,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (budgetPeriodsRefs)
                    await $_getPrefetchedData<
                      BudgetCategory,
                      $BudgetCategoriesTable,
                      BudgetPeriod
                    >(
                      currentTable: table,
                      referencedTable: $$BudgetCategoriesTableReferences
                          ._budgetPeriodsRefsTable(db),
                      managerFromTypedResult:
                          (p0) =>
                              $$BudgetCategoriesTableReferences(
                                db,
                                table,
                                p0,
                              ).budgetPeriodsRefs,
                      referencedItemsForCurrentItem:
                          (item, referencedItems) => referencedItems.where(
                            (e) => e.categoryId == item.id,
                          ),
                      typedResults: items,
                    ),
                  if (transactionsRefs)
                    await $_getPrefetchedData<
                      BudgetCategory,
                      $BudgetCategoriesTable,
                      app_transaction.Transaction
                    >(
                      currentTable: table,
                      referencedTable: $$BudgetCategoriesTableReferences
                          ._transactionsRefsTable(db),
                      managerFromTypedResult:
                          (p0) =>
                              $$BudgetCategoriesTableReferences(
                                db,
                                table,
                                p0,
                              ).transactionsRefs,
                      referencedItemsForCurrentItem:
                          (item, referencedItems) => referencedItems.where(
                            (e) => e.categoryId == item.id,
                          ),
                      typedResults: items,
                    ),
                  if (accountsRefs)
                    await $_getPrefetchedData<
                      BudgetCategory,
                      $BudgetCategoriesTable,
                      Account
                    >(
                      currentTable: table,
                      referencedTable: $$BudgetCategoriesTableReferences
                          ._accountsRefsTable(db),
                      managerFromTypedResult:
                          (p0) =>
                              $$BudgetCategoriesTableReferences(
                                db,
                                table,
                                p0,
                              ).accountsRefs,
                      referencedItemsForCurrentItem:
                          (item, referencedItems) => referencedItems.where(
                            (e) => e.categoryId == item.id,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$BudgetCategoriesTableProcessedTableManager =
    ProcessedTableManager<
      _$LocalDatabase,
      $BudgetCategoriesTable,
      BudgetCategory,
      $$BudgetCategoriesTableFilterComposer,
      $$BudgetCategoriesTableOrderingComposer,
      $$BudgetCategoriesTableAnnotationComposer,
      $$BudgetCategoriesTableCreateCompanionBuilder,
      $$BudgetCategoriesTableUpdateCompanionBuilder,
      (BudgetCategory, $$BudgetCategoriesTableReferences),
      BudgetCategory,
      PrefetchHooks Function({
        bool budgetPeriodsRefs,
        bool transactionsRefs,
        bool accountsRefs,
      })
    >;
typedef $$BudgetPeriodsTableCreateCompanionBuilder =
    BudgetPeriodsCompanion Function({
      Value<int> id,
      required int categoryId,
      required DateTime period,
      required double budgetedAmount,
    });
typedef $$BudgetPeriodsTableUpdateCompanionBuilder =
    BudgetPeriodsCompanion Function({
      Value<int> id,
      Value<int> categoryId,
      Value<DateTime> period,
      Value<double> budgetedAmount,
    });

final class $$BudgetPeriodsTableReferences
    extends BaseReferences<_$LocalDatabase, $BudgetPeriodsTable, BudgetPeriod> {
  $$BudgetPeriodsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $BudgetCategoriesTable _categoryIdTable(_$LocalDatabase db) =>
      db.budgetCategories.createAlias(
        $_aliasNameGenerator(
          db.budgetPeriods.categoryId,
          db.budgetCategories.id,
        ),
      );

  $$BudgetCategoriesTableProcessedTableManager get categoryId {
    final $_column = $_itemColumn<int>('category_id')!;

    final manager = $$BudgetCategoriesTableTableManager(
      $_db,
      $_db.budgetCategories,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_categoryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$BudgetPeriodsTableFilterComposer
    extends Composer<_$LocalDatabase, $BudgetPeriodsTable> {
  $$BudgetPeriodsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get period => $composableBuilder(
    column: $table.period,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get budgetedAmount => $composableBuilder(
    column: $table.budgetedAmount,
    builder: (column) => ColumnFilters(column),
  );

  $$BudgetCategoriesTableFilterComposer get categoryId {
    final $$BudgetCategoriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.budgetCategories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BudgetCategoriesTableFilterComposer(
            $db: $db,
            $table: $db.budgetCategories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BudgetPeriodsTableOrderingComposer
    extends Composer<_$LocalDatabase, $BudgetPeriodsTable> {
  $$BudgetPeriodsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get period => $composableBuilder(
    column: $table.period,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get budgetedAmount => $composableBuilder(
    column: $table.budgetedAmount,
    builder: (column) => ColumnOrderings(column),
  );

  $$BudgetCategoriesTableOrderingComposer get categoryId {
    final $$BudgetCategoriesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.budgetCategories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BudgetCategoriesTableOrderingComposer(
            $db: $db,
            $table: $db.budgetCategories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BudgetPeriodsTableAnnotationComposer
    extends Composer<_$LocalDatabase, $BudgetPeriodsTable> {
  $$BudgetPeriodsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get period =>
      $composableBuilder(column: $table.period, builder: (column) => column);

  GeneratedColumn<double> get budgetedAmount => $composableBuilder(
    column: $table.budgetedAmount,
    builder: (column) => column,
  );

  $$BudgetCategoriesTableAnnotationComposer get categoryId {
    final $$BudgetCategoriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.budgetCategories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BudgetCategoriesTableAnnotationComposer(
            $db: $db,
            $table: $db.budgetCategories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BudgetPeriodsTableTableManager
    extends
        RootTableManager<
          _$LocalDatabase,
          $BudgetPeriodsTable,
          BudgetPeriod,
          $$BudgetPeriodsTableFilterComposer,
          $$BudgetPeriodsTableOrderingComposer,
          $$BudgetPeriodsTableAnnotationComposer,
          $$BudgetPeriodsTableCreateCompanionBuilder,
          $$BudgetPeriodsTableUpdateCompanionBuilder,
          (BudgetPeriod, $$BudgetPeriodsTableReferences),
          BudgetPeriod,
          PrefetchHooks Function({bool categoryId})
        > {
  $$BudgetPeriodsTableTableManager(
    _$LocalDatabase db,
    $BudgetPeriodsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$BudgetPeriodsTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () =>
                  $$BudgetPeriodsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$BudgetPeriodsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> categoryId = const Value.absent(),
                Value<DateTime> period = const Value.absent(),
                Value<double> budgetedAmount = const Value.absent(),
              }) => BudgetPeriodsCompanion(
                id: id,
                categoryId: categoryId,
                period: period,
                budgetedAmount: budgetedAmount,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int categoryId,
                required DateTime period,
                required double budgetedAmount,
              }) => BudgetPeriodsCompanion.insert(
                id: id,
                categoryId: categoryId,
                period: period,
                budgetedAmount: budgetedAmount,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$BudgetPeriodsTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({categoryId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                T extends TableManagerState<
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic
                >
              >(state) {
                if (categoryId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.categoryId,
                            referencedTable: $$BudgetPeriodsTableReferences
                                ._categoryIdTable(db),
                            referencedColumn:
                                $$BudgetPeriodsTableReferences
                                    ._categoryIdTable(db)
                                    .id,
                          )
                          as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$BudgetPeriodsTableProcessedTableManager =
    ProcessedTableManager<
      _$LocalDatabase,
      $BudgetPeriodsTable,
      BudgetPeriod,
      $$BudgetPeriodsTableFilterComposer,
      $$BudgetPeriodsTableOrderingComposer,
      $$BudgetPeriodsTableAnnotationComposer,
      $$BudgetPeriodsTableCreateCompanionBuilder,
      $$BudgetPeriodsTableUpdateCompanionBuilder,
      (BudgetPeriod, $$BudgetPeriodsTableReferences),
      BudgetPeriod,
      PrefetchHooks Function({bool categoryId})
    >;
typedef $$TransactionsTableCreateCompanionBuilder =
    TransactionsCompanion Function({
      Value<int> id,
      required DateTime date,
      required Types type,
      required int categoryId,
      required double amount,
      Value<String?> description,
    });
typedef $$TransactionsTableUpdateCompanionBuilder =
    TransactionsCompanion Function({
      Value<int> id,
      Value<DateTime> date,
      Value<Types> type,
      Value<int> categoryId,
      Value<double> amount,
      Value<String?> description,
    });

final class $$TransactionsTableReferences
    extends
        BaseReferences<
          _$LocalDatabase,
          $TransactionsTable,
          app_transaction.Transaction
        > {
  $$TransactionsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $BudgetCategoriesTable _categoryIdTable(_$LocalDatabase db) =>
      db.budgetCategories.createAlias(
        $_aliasNameGenerator(
          db.transactions.categoryId,
          db.budgetCategories.id,
        ),
      );

  $$BudgetCategoriesTableProcessedTableManager get categoryId {
    final $_column = $_itemColumn<int>('category_id')!;

    final manager = $$BudgetCategoriesTableTableManager(
      $_db,
      $_db.budgetCategories,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_categoryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$TransactionsTableFilterComposer
    extends Composer<_$LocalDatabase, $TransactionsTable> {
  $$TransactionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<Types, Types, int> get type =>
      $composableBuilder(
        column: $table.type,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  $$BudgetCategoriesTableFilterComposer get categoryId {
    final $$BudgetCategoriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.budgetCategories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BudgetCategoriesTableFilterComposer(
            $db: $db,
            $table: $db.budgetCategories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TransactionsTableOrderingComposer
    extends Composer<_$LocalDatabase, $TransactionsTable> {
  $$TransactionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  $$BudgetCategoriesTableOrderingComposer get categoryId {
    final $$BudgetCategoriesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.budgetCategories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BudgetCategoriesTableOrderingComposer(
            $db: $db,
            $table: $db.budgetCategories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TransactionsTableAnnotationComposer
    extends Composer<_$LocalDatabase, $TransactionsTable> {
  $$TransactionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Types, int> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  $$BudgetCategoriesTableAnnotationComposer get categoryId {
    final $$BudgetCategoriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.budgetCategories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BudgetCategoriesTableAnnotationComposer(
            $db: $db,
            $table: $db.budgetCategories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TransactionsTableTableManager
    extends
        RootTableManager<
          _$LocalDatabase,
          $TransactionsTable,
          app_transaction.Transaction,
          $$TransactionsTableFilterComposer,
          $$TransactionsTableOrderingComposer,
          $$TransactionsTableAnnotationComposer,
          $$TransactionsTableCreateCompanionBuilder,
          $$TransactionsTableUpdateCompanionBuilder,
          (app_transaction.Transaction, $$TransactionsTableReferences),
          app_transaction.Transaction,
          PrefetchHooks Function({bool categoryId})
        > {
  $$TransactionsTableTableManager(_$LocalDatabase db, $TransactionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$TransactionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$TransactionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () =>
                  $$TransactionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<Types> type = const Value.absent(),
                Value<int> categoryId = const Value.absent(),
                Value<double> amount = const Value.absent(),
                Value<String?> description = const Value.absent(),
              }) => TransactionsCompanion(
                id: id,
                date: date,
                type: type,
                categoryId: categoryId,
                amount: amount,
                description: description,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required DateTime date,
                required Types type,
                required int categoryId,
                required double amount,
                Value<String?> description = const Value.absent(),
              }) => TransactionsCompanion.insert(
                id: id,
                date: date,
                type: type,
                categoryId: categoryId,
                amount: amount,
                description: description,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$TransactionsTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({categoryId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                T extends TableManagerState<
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic
                >
              >(state) {
                if (categoryId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.categoryId,
                            referencedTable: $$TransactionsTableReferences
                                ._categoryIdTable(db),
                            referencedColumn:
                                $$TransactionsTableReferences
                                    ._categoryIdTable(db)
                                    .id,
                          )
                          as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$TransactionsTableProcessedTableManager =
    ProcessedTableManager<
      _$LocalDatabase,
      $TransactionsTable,
      app_transaction.Transaction,
      $$TransactionsTableFilterComposer,
      $$TransactionsTableOrderingComposer,
      $$TransactionsTableAnnotationComposer,
      $$TransactionsTableCreateCompanionBuilder,
      $$TransactionsTableUpdateCompanionBuilder,
      (app_transaction.Transaction, $$TransactionsTableReferences),
      app_transaction.Transaction,
      PrefetchHooks Function({bool categoryId})
    >;
typedef $$AccountsTableCreateCompanionBuilder =
    AccountsCompanion Function({
      Value<int> id,
      required int categoryId,
      required String name,
      required Types type,
    });
typedef $$AccountsTableUpdateCompanionBuilder =
    AccountsCompanion Function({
      Value<int> id,
      Value<int> categoryId,
      Value<String> name,
      Value<Types> type,
    });

final class $$AccountsTableReferences
    extends BaseReferences<_$LocalDatabase, $AccountsTable, Account> {
  $$AccountsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $BudgetCategoriesTable _categoryIdTable(_$LocalDatabase db) =>
      db.budgetCategories.createAlias(
        $_aliasNameGenerator(db.accounts.categoryId, db.budgetCategories.id),
      );

  $$BudgetCategoriesTableProcessedTableManager get categoryId {
    final $_column = $_itemColumn<int>('category_id')!;

    final manager = $$BudgetCategoriesTableTableManager(
      $_db,
      $_db.budgetCategories,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_categoryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$AccountPeriodsTable, List<AccountPeriod>>
  _accountPeriodsRefsTable(_$LocalDatabase db) => MultiTypedResultKey.fromTable(
    db.accountPeriods,
    aliasName: $_aliasNameGenerator(
      db.accounts.id,
      db.accountPeriods.accountId,
    ),
  );

  $$AccountPeriodsTableProcessedTableManager get accountPeriodsRefs {
    final manager = $$AccountPeriodsTableTableManager(
      $_db,
      $_db.accountPeriods,
    ).filter((f) => f.accountId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_accountPeriodsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$AccountsTableFilterComposer
    extends Composer<_$LocalDatabase, $AccountsTable> {
  $$AccountsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<Types, Types, int> get type =>
      $composableBuilder(
        column: $table.type,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  $$BudgetCategoriesTableFilterComposer get categoryId {
    final $$BudgetCategoriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.budgetCategories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BudgetCategoriesTableFilterComposer(
            $db: $db,
            $table: $db.budgetCategories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> accountPeriodsRefs(
    Expression<bool> Function($$AccountPeriodsTableFilterComposer f) f,
  ) {
    final $$AccountPeriodsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.accountPeriods,
      getReferencedColumn: (t) => t.accountId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountPeriodsTableFilterComposer(
            $db: $db,
            $table: $db.accountPeriods,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$AccountsTableOrderingComposer
    extends Composer<_$LocalDatabase, $AccountsTable> {
  $$AccountsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  $$BudgetCategoriesTableOrderingComposer get categoryId {
    final $$BudgetCategoriesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.budgetCategories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BudgetCategoriesTableOrderingComposer(
            $db: $db,
            $table: $db.budgetCategories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AccountsTableAnnotationComposer
    extends Composer<_$LocalDatabase, $AccountsTable> {
  $$AccountsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Types, int> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  $$BudgetCategoriesTableAnnotationComposer get categoryId {
    final $$BudgetCategoriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.budgetCategories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BudgetCategoriesTableAnnotationComposer(
            $db: $db,
            $table: $db.budgetCategories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> accountPeriodsRefs<T extends Object>(
    Expression<T> Function($$AccountPeriodsTableAnnotationComposer a) f,
  ) {
    final $$AccountPeriodsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.accountPeriods,
      getReferencedColumn: (t) => t.accountId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountPeriodsTableAnnotationComposer(
            $db: $db,
            $table: $db.accountPeriods,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$AccountsTableTableManager
    extends
        RootTableManager<
          _$LocalDatabase,
          $AccountsTable,
          Account,
          $$AccountsTableFilterComposer,
          $$AccountsTableOrderingComposer,
          $$AccountsTableAnnotationComposer,
          $$AccountsTableCreateCompanionBuilder,
          $$AccountsTableUpdateCompanionBuilder,
          (Account, $$AccountsTableReferences),
          Account,
          PrefetchHooks Function({bool categoryId, bool accountPeriodsRefs})
        > {
  $$AccountsTableTableManager(_$LocalDatabase db, $AccountsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$AccountsTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$AccountsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$AccountsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> categoryId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<Types> type = const Value.absent(),
              }) => AccountsCompanion(
                id: id,
                categoryId: categoryId,
                name: name,
                type: type,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int categoryId,
                required String name,
                required Types type,
              }) => AccountsCompanion.insert(
                id: id,
                categoryId: categoryId,
                name: name,
                type: type,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$AccountsTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({
            categoryId = false,
            accountPeriodsRefs = false,
          }) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (accountPeriodsRefs) db.accountPeriods,
              ],
              addJoins: <
                T extends TableManagerState<
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic
                >
              >(state) {
                if (categoryId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.categoryId,
                            referencedTable: $$AccountsTableReferences
                                ._categoryIdTable(db),
                            referencedColumn:
                                $$AccountsTableReferences
                                    ._categoryIdTable(db)
                                    .id,
                          )
                          as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (accountPeriodsRefs)
                    await $_getPrefetchedData<
                      Account,
                      $AccountsTable,
                      AccountPeriod
                    >(
                      currentTable: table,
                      referencedTable: $$AccountsTableReferences
                          ._accountPeriodsRefsTable(db),
                      managerFromTypedResult:
                          (p0) =>
                              $$AccountsTableReferences(
                                db,
                                table,
                                p0,
                              ).accountPeriodsRefs,
                      referencedItemsForCurrentItem:
                          (item, referencedItems) => referencedItems.where(
                            (e) => e.accountId == item.id,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$AccountsTableProcessedTableManager =
    ProcessedTableManager<
      _$LocalDatabase,
      $AccountsTable,
      Account,
      $$AccountsTableFilterComposer,
      $$AccountsTableOrderingComposer,
      $$AccountsTableAnnotationComposer,
      $$AccountsTableCreateCompanionBuilder,
      $$AccountsTableUpdateCompanionBuilder,
      (Account, $$AccountsTableReferences),
      Account,
      PrefetchHooks Function({bool categoryId, bool accountPeriodsRefs})
    >;
typedef $$AccountPeriodsTableCreateCompanionBuilder =
    AccountPeriodsCompanion Function({
      Value<int> id,
      required int accountId,
      required DateTime period,
      required double balance,
      required double deposits,
      required double withdrawals,
      required double interest,
    });
typedef $$AccountPeriodsTableUpdateCompanionBuilder =
    AccountPeriodsCompanion Function({
      Value<int> id,
      Value<int> accountId,
      Value<DateTime> period,
      Value<double> balance,
      Value<double> deposits,
      Value<double> withdrawals,
      Value<double> interest,
    });

final class $$AccountPeriodsTableReferences
    extends
        BaseReferences<_$LocalDatabase, $AccountPeriodsTable, AccountPeriod> {
  $$AccountPeriodsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $AccountsTable _accountIdTable(_$LocalDatabase db) =>
      db.accounts.createAlias(
        $_aliasNameGenerator(db.accountPeriods.accountId, db.accounts.id),
      );

  $$AccountsTableProcessedTableManager get accountId {
    final $_column = $_itemColumn<int>('account_id')!;

    final manager = $$AccountsTableTableManager(
      $_db,
      $_db.accounts,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_accountIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$AccountPeriodsTableFilterComposer
    extends Composer<_$LocalDatabase, $AccountPeriodsTable> {
  $$AccountPeriodsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get period => $composableBuilder(
    column: $table.period,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get balance => $composableBuilder(
    column: $table.balance,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get deposits => $composableBuilder(
    column: $table.deposits,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get withdrawals => $composableBuilder(
    column: $table.withdrawals,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get interest => $composableBuilder(
    column: $table.interest,
    builder: (column) => ColumnFilters(column),
  );

  $$AccountsTableFilterComposer get accountId {
    final $$AccountsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.accounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountsTableFilterComposer(
            $db: $db,
            $table: $db.accounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AccountPeriodsTableOrderingComposer
    extends Composer<_$LocalDatabase, $AccountPeriodsTable> {
  $$AccountPeriodsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get period => $composableBuilder(
    column: $table.period,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get balance => $composableBuilder(
    column: $table.balance,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get deposits => $composableBuilder(
    column: $table.deposits,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get withdrawals => $composableBuilder(
    column: $table.withdrawals,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get interest => $composableBuilder(
    column: $table.interest,
    builder: (column) => ColumnOrderings(column),
  );

  $$AccountsTableOrderingComposer get accountId {
    final $$AccountsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.accounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountsTableOrderingComposer(
            $db: $db,
            $table: $db.accounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AccountPeriodsTableAnnotationComposer
    extends Composer<_$LocalDatabase, $AccountPeriodsTable> {
  $$AccountPeriodsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get period =>
      $composableBuilder(column: $table.period, builder: (column) => column);

  GeneratedColumn<double> get balance =>
      $composableBuilder(column: $table.balance, builder: (column) => column);

  GeneratedColumn<double> get deposits =>
      $composableBuilder(column: $table.deposits, builder: (column) => column);

  GeneratedColumn<double> get withdrawals => $composableBuilder(
    column: $table.withdrawals,
    builder: (column) => column,
  );

  GeneratedColumn<double> get interest =>
      $composableBuilder(column: $table.interest, builder: (column) => column);

  $$AccountsTableAnnotationComposer get accountId {
    final $$AccountsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.accounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountsTableAnnotationComposer(
            $db: $db,
            $table: $db.accounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AccountPeriodsTableTableManager
    extends
        RootTableManager<
          _$LocalDatabase,
          $AccountPeriodsTable,
          AccountPeriod,
          $$AccountPeriodsTableFilterComposer,
          $$AccountPeriodsTableOrderingComposer,
          $$AccountPeriodsTableAnnotationComposer,
          $$AccountPeriodsTableCreateCompanionBuilder,
          $$AccountPeriodsTableUpdateCompanionBuilder,
          (AccountPeriod, $$AccountPeriodsTableReferences),
          AccountPeriod,
          PrefetchHooks Function({bool accountId})
        > {
  $$AccountPeriodsTableTableManager(
    _$LocalDatabase db,
    $AccountPeriodsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$AccountPeriodsTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () =>
                  $$AccountPeriodsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$AccountPeriodsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> accountId = const Value.absent(),
                Value<DateTime> period = const Value.absent(),
                Value<double> balance = const Value.absent(),
                Value<double> deposits = const Value.absent(),
                Value<double> withdrawals = const Value.absent(),
                Value<double> interest = const Value.absent(),
              }) => AccountPeriodsCompanion(
                id: id,
                accountId: accountId,
                period: period,
                balance: balance,
                deposits: deposits,
                withdrawals: withdrawals,
                interest: interest,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int accountId,
                required DateTime period,
                required double balance,
                required double deposits,
                required double withdrawals,
                required double interest,
              }) => AccountPeriodsCompanion.insert(
                id: id,
                accountId: accountId,
                period: period,
                balance: balance,
                deposits: deposits,
                withdrawals: withdrawals,
                interest: interest,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$AccountPeriodsTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({accountId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                T extends TableManagerState<
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic
                >
              >(state) {
                if (accountId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.accountId,
                            referencedTable: $$AccountPeriodsTableReferences
                                ._accountIdTable(db),
                            referencedColumn:
                                $$AccountPeriodsTableReferences
                                    ._accountIdTable(db)
                                    .id,
                          )
                          as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$AccountPeriodsTableProcessedTableManager =
    ProcessedTableManager<
      _$LocalDatabase,
      $AccountPeriodsTable,
      AccountPeriod,
      $$AccountPeriodsTableFilterComposer,
      $$AccountPeriodsTableOrderingComposer,
      $$AccountPeriodsTableAnnotationComposer,
      $$AccountPeriodsTableCreateCompanionBuilder,
      $$AccountPeriodsTableUpdateCompanionBuilder,
      (AccountPeriod, $$AccountPeriodsTableReferences),
      AccountPeriod,
      PrefetchHooks Function({bool accountId})
    >;

class $LocalDatabaseManager {
  final _$LocalDatabase _db;
  $LocalDatabaseManager(this._db);
  $$BudgetCategoriesTableTableManager get budgetCategories =>
      $$BudgetCategoriesTableTableManager(_db, _db.budgetCategories);
  $$BudgetPeriodsTableTableManager get budgetPeriods =>
      $$BudgetPeriodsTableTableManager(_db, _db.budgetPeriods);
  $$TransactionsTableTableManager get transactions =>
      $$TransactionsTableTableManager(_db, _db.transactions);
  $$AccountsTableTableManager get accounts =>
      $$AccountsTableTableManager(_db, _db.accounts);
  $$AccountPeriodsTableTableManager get accountPeriods =>
      $$AccountPeriodsTableTableManager(_db, _db.accountPeriods);
}
