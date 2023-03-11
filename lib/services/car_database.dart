import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ropstem_task/utils/other.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:uuid/uuid.dart';
const uuid = Uuid();
class CarDatabase {
  final carStore = intMapStoreFactory.store('cars');

  Future<Database> _openDatabase() async {
    final appDocumentDir = await getApplicationDocumentsDirectory();
    final dbPath = appDocumentDir.path;
    final db = await databaseFactoryIo.openDatabase(join(dbPath, 'car_database.db'));

    return db;
  }
  ///Insert Dummy Data
  Future<void> insertCars(List<Car> cars) async {
    final db = await _openDatabase();
    final carJsonList = cars.map((car) => car.toJson()).toList();
    await carStore.addAll(db, carJsonList);
    await db.close();
  }
  /// Add New Data
  Future<void> addCar(Car cars) async {
    final db = await _openDatabase();
    // final carJsonList = cars.map((car) => car.toJson()).toList();
    await carStore.add(db, cars.toJson());
    await db.close();
    UtilOther.showToast('Car added');
  }
  ///Delete Car
  Future<void> removeCar(Car cars) async {
    final db = await _openDatabase();
    final finder = Finder(filter: Filter.equals('id', cars.id));
    await carStore.delete(db,finder: finder);
    await db.close();
    UtilOther.showToast('Car removed');

  }
  ///Update Car
  Future<void> updateCar(Car cars) async {
    final db = await _openDatabase();
    final finder = Finder(filter: Filter.equals('id', cars.id));
    await carStore.update(db,cars.toJson(),finder: finder,);
    await db.close();
    UtilOther.showToast('Car updated');
  }
  ///Get List
  Future<List<Car>> getCars() async {
    final db = await _openDatabase();
    final carJsonList = await carStore.find(db);
    await db.close();

    final cars = carJsonList.map((json) => Car.fromJson(json.value)).toList();
    return cars;
  }

}
///Car Model
class Car {
  final String id;
  final String make;
  final String model;
  final String registrationNo;
  final String color;
  final String category;

  const Car({
    required this.id,
    required this.make,
    required this.model,
    required this.registrationNo,
    required this.color,
    required this.category,
  });
  Map<String, dynamic> toJson() {
    return {
      'id' : id,
      'category': category,
      'color': color,
      'model': model,
      'make': make,
      'registrationNo': registrationNo,
    };
  }

  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
      category: json['category'],
      color: json['color'],
      model: json['model'],
      make: json['make'],
      id: json['id'],
      registrationNo: json['registrationNo'],
    );
  }
  Car copyWith({
    String? id,
    String? make,
    String? model,
    String? registrationNo,
    String? color,
    String? category,
  }) {
    return Car(
      id: id ?? this.id,
      make: make ?? this.make,
      model: model ?? this.model,
      registrationNo: registrationNo ?? this.registrationNo,
      color: color ?? this.color,
      category: category ?? this.category,
    );
  }
}

///Dummy Json
final List<Car> dummyCars = [
  Car(
    id: uuid.v4(),
    category: 'Compact',
    color: 'Red',
    model: 'Toyota Corolla',
    make: 'Toyota',
    registrationNo: 'ABC123',
  ),
  Car(
    id: uuid.v4(),
    category: 'SUV',
    color: 'Blue',
    model: 'Honda CR-V',
    make: 'Honda',
    registrationNo: 'DEF456',
  ),
  Car(
    id: uuid.v4(),
    category: 'Luxury',
    color: 'Black',
    model: 'BMW 7 Series',
    make: 'BMW',
    registrationNo: 'GHI789',
  ),
];

