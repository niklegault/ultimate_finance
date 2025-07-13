import 'package:ultimate_finance/data/datasources/abstract_local_data_source.dart';
import 'package:ultimate_finance/data/datasources/local_data_source.dart';
import 'package:ultimate_finance/data/repositories/abstract_data_repository.dart';
import 'package:ultimate_finance/data/repositories/data_repository.dart';

final LocalDatabase localDatabase = LocalDatabase();
final IDataRepository dataRepository = DataRepository(localDataSource: localDatabase);