//
//  RealmManage.swift
//  CanCook
//
//  Created by paxcreation on 2/18/21.
//
import Realm
import RealmSwift
import RxSwift


class RealmManage {
    
    
    static var shared = RealmManage()
    var realm : Realm!
    init() {
        migrateWithCompletion()
        realm = try! Realm()
    }
    
    func migrateWithCompletion() {
        let config = RLMRealmConfiguration.default()
        config.schemaVersion = 7
        
        config.migrationBlock = { (migration, oldSchemaVersion) in
            if (oldSchemaVersion < 1) {
                // Nothing to do!
                // Realm will automatically detect new properties and removed properties
                // And will update the schema on disk automatically
            }
        }
        
        RLMRealmConfiguration.setDefault(config)
        print("schemaVersion after migration:\(RLMRealmConfiguration.default().schemaVersion)")
        RLMRealm.default()
    }
//    func addModelToRealm(foodModel: FoodModel? = nil, gravyModel: FoodModel? = nil) {
//        var itemAdd: Object?
//        
//        if let food = foodModel {
//            itemAdd = FoodRealm.init(model: food)
//        }
//        
//        if let gravy = gravyModel {
//            itemAdd = GravyRealm.init(model: gravy)
//        }
//        
//        guard let item = itemAdd else {
//            return
//        }
//
//        try! realm.write {
//            realm.add(item)
//            self.getFoodModel()
//            self.getGravyModel()
//        }
//    }
//    
//    func getFoodModel() -> [FoodModel] {
//        let listDiaryRealm = self.getRealm(ofType: FoodRealm.self)
//        var listDiaryModel: [FoodModel] = []
//        for m in listDiaryRealm {
//            guard let model = m.foodData?.toCodableObject() as FoodModel? else{
//                return []
//            }
//            listDiaryModel.append(model)
//        }
//        ListFoodStreaIpl.share.listFood = listDiaryModel
//        return listDiaryModel
//    }
//    
//    func getGravyModel() -> [FoodModel] {
//        let listDiaryRealm = self.getRealm(ofType: GravyRealm.self)
//        var listDiaryModel: [FoodModel] = []
//        for m in listDiaryRealm {
//            guard let model = m.foodData?.toCodableObject() as FoodModel? else{
//                return []
//            }
//            listDiaryModel.append(model)
//        }
//        ListFoodStreaIpl.share.listGravy = listDiaryModel
//        return listDiaryModel
//    }
//    
//    private func getRealm<T: Object>(ofType type: T.Type) -> [T] {
//        let list = realm.objects(T.self).toArray(ofType: T.self)
//        return list
//    }
//    
//    func deleteFood(food: FoodModel) {
//        let item = FoodRealm.init(model: food)
//        let items = self.getRealm(ofType: FoodRealm.self)
//        
//        guard items.count > 0 else {
//            return
//        }
//        
//        if let index = items.firstIndex(where: {$0.id == item.id}) {
//            try! realm.write {
//                realm.delete(items[index])
//                self.getFoodModel()
//            }
//        }
//    }
//    
//    func deleteGravy(gravy: FoodModel) {
//        let item = GravyRealm.init(model: gravy)
//        let items = self.getRealm(ofType: GravyRealm.self)
//        
//        guard items.count > 0 else {
//            return
//        }
//        
//        if let index = items.firstIndex(where: {$0.id == item.id}) {
//            try! realm.write {
//                realm.delete(items[index])
//                self.getGravyModel()
//            }
//        }
//    }
}
extension Results {
    func toArray<T>(ofType: T.Type) -> [T] {
        var array = [T]()
        for i in 0 ..< count {
            if let result = self[i] as? T {
                array.append(result)
            }
        }
        return array
    }
}
extension Data {
    func toCodableObject<T: Codable>() -> T? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .useDefaultKeys
        if let obj = try? decoder.decode(T.self, from: self) {
            return obj
        }
        return nil    }
    
}
enum PushNotificationKeys : String {
    case addDiary = "addDiary"
    case updateSetting = "updateSetting"
    case updateInfomation = "updateInfo"
    case updateImage = "updateImage"
}
