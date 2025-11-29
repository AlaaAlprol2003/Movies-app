import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'service_locator.config.dart';

final serviceLocator = GetIt.instance;
@InjectableInit(
  initializerName: 'init', // اسم الدالة التي ستتولد
  preferRelativeImports: true,
  asExtension: true, // سيتم توليد serviceLocator.init() كـ extension method
)
void configureDependencies() => serviceLocator.init();
