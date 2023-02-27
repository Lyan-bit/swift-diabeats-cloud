	                  
import Foundation
import SwiftUI

/* This code requires OclFile.swift */

func initialiseOclFile()
{ let systemIn = createByPKOclFile(key: "System.in")
  let systemOut = createByPKOclFile(key: "System.out")
  let systemErr = createByPKOclFile(key: "System.err")
}

/* This metatype code requires OclType.swift */

func initialiseOclType()
{ let int_OclType = createByPKOclType(key: "int")
  int_OclType.actualMetatype = Int.self
  let double_OclType = createByPKOclType(key: "double")
  double_OclType.actualMetatype = Double.self
  let long_OclType = createByPKOclType(key: "long")
  long_OclType.actualMetatype = Int64.self
  let string_OclType = createByPKOclType(key: "String")
  string_OclType.actualMetatype = String.self
  let sequence_OclType = createByPKOclType(key: "Sequence")
  sequence_OclType.actualMetatype = type(of: [])
  let _anyset : Set<AnyHashable> = Set<AnyHashable>()
  let set_OclType = createByPKOclType(key: "Set")
  set_OclType.actualMetatype = type(of: _anyset)
  let map_OclType = createByPKOclType(key: "Map")
  map_OclType.actualMetatype = type(of: [:])
  let void_OclType = createByPKOclType(key: "void")
  void_OclType.actualMetatype = Void.self
	
  let diabeats_OclType = createByPKOclType(key: "Diabeats")
  diabeats_OclType.actualMetatype = Diabeats.self

  let diabeats_id = createOclAttribute()
  	  diabeats_id.name = "id"
  	  diabeats_id.type = string_OclType
  	  diabeats_OclType.attributes.append(diabeats_id)
  let diabeats_pregnancies = createOclAttribute()
  	  diabeats_pregnancies.name = "pregnancies"
  	  diabeats_pregnancies.type = int_OclType
  	  diabeats_OclType.attributes.append(diabeats_pregnancies)
  let diabeats_glucose = createOclAttribute()
  	  diabeats_glucose.name = "glucose"
  	  diabeats_glucose.type = int_OclType
  	  diabeats_OclType.attributes.append(diabeats_glucose)
  let diabeats_bloodPressure = createOclAttribute()
  	  diabeats_bloodPressure.name = "bloodPressure"
  	  diabeats_bloodPressure.type = int_OclType
  	  diabeats_OclType.attributes.append(diabeats_bloodPressure)
  let diabeats_skinThickness = createOclAttribute()
  	  diabeats_skinThickness.name = "skinThickness"
  	  diabeats_skinThickness.type = int_OclType
  	  diabeats_OclType.attributes.append(diabeats_skinThickness)
  let diabeats_insulin = createOclAttribute()
  	  diabeats_insulin.name = "insulin"
  	  diabeats_insulin.type = int_OclType
  	  diabeats_OclType.attributes.append(diabeats_insulin)
  let diabeats_BMI = createOclAttribute()
  	  diabeats_BMI.name = "BMI"
  	  diabeats_BMI.type = double_OclType
  	  diabeats_OclType.attributes.append(diabeats_BMI)
  let diabeats_diabetesPedigreeFunction = createOclAttribute()
  	  diabeats_diabetesPedigreeFunction.name = "diabetesPedigreeFunction"
  	  diabeats_diabetesPedigreeFunction.type = double_OclType
  	  diabeats_OclType.attributes.append(diabeats_diabetesPedigreeFunction)
  let diabeats_age = createOclAttribute()
  	  diabeats_age.name = "age"
  	  diabeats_age.type = int_OclType
  	  diabeats_OclType.attributes.append(diabeats_age)
  let diabeats_outcome = createOclAttribute()
  	  diabeats_outcome.name = "outcome"
  	  diabeats_outcome.type = string_OclType
  	  diabeats_OclType.attributes.append(diabeats_outcome)
}

func instanceFromJSON(typeName: String, json: String) -> AnyObject?
	{ let jdata = json.data(using: .utf8)!
	  let decoder = JSONDecoder()
	  if typeName == "String"
	  { let x = try! decoder.decode(String.self, from: jdata)
	      return x as AnyObject
	  }
if typeName == "Diabeats"
  { let x = try! decoder.decode(Diabeats.self, from: jdata) 
  return x
}
  return nil
	}

class ModelFacade : ObservableObject {
		                      
	static var instance : ModelFacade? = nil
	var cdb : FirebaseDB = FirebaseDB.getInstance()
	private var modelParser : ModelParser? = ModelParser(modelFileInfo: ModelFile.modelInfo)
	var fileSystem : FileAccessor = FileAccessor()

	static func getInstance() -> ModelFacade { 
		if instance == nil
	     { instance = ModelFacade() 
	       initialiseOclFile()
	       initialiseOclType() }
	    return instance! }
	                          
	init() { 
	}
	      
	@Published var currentDiabeats : DiabeatsVO? = DiabeatsVO.defaultDiabeatsVO()
	@Published var currentDiabeatss : [DiabeatsVO] = [DiabeatsVO]()

	func createDiabeats(_x : DiabeatsVO) {
		   if let _obj = getDiabeatsByPK(_val: _x.id)
		   { cdb.persistDiabeats(_x: _obj) }
		   else {
		   let _item : Diabeats = createByPKDiabeats(key: _x.id)
		 _item.id = _x.getId()
		 _item.pregnancies = _x.getPregnancies()
		 _item.glucose = _x.getGlucose()
		 _item.bloodPressure = _x.getBloodPressure()
		 _item.skinThickness = _x.getSkinThickness()
		 _item.insulin = _x.getInsulin()
		 _item.BMI = _x.getBMI()
		 _item.diabetesPedigreeFunction = _x.getDiabetesPedigreeFunction()
		 _item.age = _x.getAge()
		 _item.outcome = _x.getOutcome()
		   cdb.persistDiabeats(_x: _item)
		   }
	     currentDiabeats = _x
	}

	func cancelCreateDiabeats() {}

    func classifyDiabeats(_x : String) -> String {
        guard let diabeats = getDiabeatsByPK(_val: _x)
        else {
            return "Please selsect valid id"
        }
        
        guard let result = self.modelParser?.runModel(
          input0: Float((diabeats.pregnancies - 0) / (17 - 0)),
          input1: Float((diabeats.glucose - 0) / (199 - 0)),
          input2: Float((diabeats.bloodPressure - 0) / (122 - 0)),
          input3: Float((diabeats.skinThickness - 0) / (99 - 0)),
          input4: Float((diabeats.insulin - 0) / (846 - 0)),
          input5: Float((diabeats.BMI - 0) / (67.1 - 0)),
          input6: Float((diabeats.diabetesPedigreeFunction - 0.78) / (2.42 - 0.78)),
          input7: Float((diabeats.age - 21) / (81 - 21))
        ) else{
            return "Error"
        }
        
        diabeats.outcome = result
        persistDiabeats(_x: diabeats)
        
        return result
	}
	
	func cancelClassifyDiabeats() {}
	    


    func listDiabeats() -> [DiabeatsVO] {
		currentDiabeatss = [DiabeatsVO]()
		let _list : [Diabeats] = Diabeats_allInstances
		for (_,x) in _list.enumerated()
		{ currentDiabeatss.append(DiabeatsVO(_x: x)) }
		return currentDiabeatss
	}
			
	func loadDiabeats() {
		let res : [DiabeatsVO] = listDiabeats()
		
		for (_,_x) in res.enumerated() {
			let _obj = createByPKDiabeats(key: _x.id)
	        _obj.id = _x.getId()
        _obj.pregnancies = _x.getPregnancies()
        _obj.glucose = _x.getGlucose()
        _obj.bloodPressure = _x.getBloodPressure()
        _obj.skinThickness = _x.getSkinThickness()
        _obj.insulin = _x.getInsulin()
        _obj.BMI = _x.getBMI()
        _obj.diabetesPedigreeFunction = _x.getDiabetesPedigreeFunction()
        _obj.age = _x.getAge()
        _obj.outcome = _x.getOutcome()
			}
		 currentDiabeats = res.first
		 currentDiabeatss = res
	}
		
	func stringListDiabeats() -> [String] { 
		var res : [String] = [String]()
		for (_,obj) in currentDiabeatss.enumerated()
		{ res.append(obj.toString()) }
		return res
	}
			
    func searchByDiabeatsid(_val : String) -> [DiabeatsVO] {
	    var resultList: [DiabeatsVO] = [DiabeatsVO]()
	    let _list : [Diabeats] = Diabeats_allInstances
	    for (_,x) in _list.enumerated() {
	    	if (x.id == _val) {
	    		resultList.append(DiabeatsVO(_x: x))
	    	}
	    }
	  return resultList
	}
	
    func searchByDiabeatspregnancies(_val : Int) -> [DiabeatsVO] {
	    var resultList: [DiabeatsVO] = [DiabeatsVO]()
	    let _list : [Diabeats] = Diabeats_allInstances
	    for (_,x) in _list.enumerated() {
	    	if (x.pregnancies == _val) {
	    		resultList.append(DiabeatsVO(_x: x))
	    	}
	    }
	  return resultList
	}
	
    func searchByDiabeatsglucose(_val : Int) -> [DiabeatsVO] {
	    var resultList: [DiabeatsVO] = [DiabeatsVO]()
	    let _list : [Diabeats] = Diabeats_allInstances
	    for (_,x) in _list.enumerated() {
	    	if (x.glucose == _val) {
	    		resultList.append(DiabeatsVO(_x: x))
	    	}
	    }
	  return resultList
	}
	
    func searchByDiabeatsbloodPressure(_val : Int) -> [DiabeatsVO] {
	    var resultList: [DiabeatsVO] = [DiabeatsVO]()
	    let _list : [Diabeats] = Diabeats_allInstances
	    for (_,x) in _list.enumerated() {
	    	if (x.bloodPressure == _val) {
	    		resultList.append(DiabeatsVO(_x: x))
	    	}
	    }
	  return resultList
	}
	
    func searchByDiabeatsskinThickness(_val : Int) -> [DiabeatsVO] {
	    var resultList: [DiabeatsVO] = [DiabeatsVO]()
	    let _list : [Diabeats] = Diabeats_allInstances
	    for (_,x) in _list.enumerated() {
	    	if (x.skinThickness == _val) {
	    		resultList.append(DiabeatsVO(_x: x))
	    	}
	    }
	  return resultList
	}
	
    func searchByDiabeatsinsulin(_val : Int) -> [DiabeatsVO] {
	    var resultList: [DiabeatsVO] = [DiabeatsVO]()
	    let _list : [Diabeats] = Diabeats_allInstances
	    for (_,x) in _list.enumerated() {
	    	if (x.insulin == _val) {
	    		resultList.append(DiabeatsVO(_x: x))
	    	}
	    }
	  return resultList
	}
	
    func searchByDiabeatsBMI(_val : Double) -> [DiabeatsVO] {
	    var resultList: [DiabeatsVO] = [DiabeatsVO]()
	    let _list : [Diabeats] = Diabeats_allInstances
	    for (_,x) in _list.enumerated() {
	    	if (x.BMI == _val) {
	    		resultList.append(DiabeatsVO(_x: x))
	    	}
	    }
	  return resultList
	}
	
    func searchByDiabeatsdiabetesPedigreeFunction(_val : Double) -> [DiabeatsVO] {
	    var resultList: [DiabeatsVO] = [DiabeatsVO]()
	    let _list : [Diabeats] = Diabeats_allInstances
	    for (_,x) in _list.enumerated() {
	    	if (x.diabetesPedigreeFunction == _val) {
	    		resultList.append(DiabeatsVO(_x: x))
	    	}
	    }
	  return resultList
	}
	
    func searchByDiabeatsage(_val : Int) -> [DiabeatsVO] {
	    var resultList: [DiabeatsVO] = [DiabeatsVO]()
	    let _list : [Diabeats] = Diabeats_allInstances
	    for (_,x) in _list.enumerated() {
	    	if (x.age == _val) {
	    		resultList.append(DiabeatsVO(_x: x))
	    	}
	    }
	  return resultList
	}
	
    func searchByDiabeatsoutcome(_val : String) -> [DiabeatsVO] {
	    var resultList: [DiabeatsVO] = [DiabeatsVO]()
	    let _list : [Diabeats] = Diabeats_allInstances
	    for (_,x) in _list.enumerated() {
	    	if (x.outcome == _val) {
	    		resultList.append(DiabeatsVO(_x: x))
	    	}
	    }
	  return resultList
	}
	
		
	func getDiabeatsByPK(_val: String) -> Diabeats?
		{ return Diabeats.Diabeats_index[_val] }
			
	func retrieveDiabeats(_val: String) -> Diabeats?
			{ return Diabeats.Diabeats_index[_val] }
			
	func allDiabeatsids() -> [String] {
			var res : [String] = [String]()
			for (_,_item) in currentDiabeatss.enumerated()
			{ res.append(_item.id + "") }
			return res
	}
			
	func setSelectedDiabeats(_x : DiabeatsVO)
		{ currentDiabeats = _x }
			
	func setSelectedDiabeats(i : Int) {
		if i < currentDiabeatss.count
		{ currentDiabeats = currentDiabeatss[i] }
	}
			
	func getSelectedDiabeats() -> DiabeatsVO?
		{ return currentDiabeats }
			
	func persistDiabeats(_x : Diabeats) {
		let _vo : DiabeatsVO = DiabeatsVO(_x: _x)
		cdb.persistDiabeats(_x: _x)
		currentDiabeats = _vo
	}
		
	func editDiabeats(_x : DiabeatsVO) {
		if let _obj = getDiabeatsByPK(_val: _x.id) {
		 _obj.id = _x.getId()
		 _obj.pregnancies = _x.getPregnancies()
		 _obj.glucose = _x.getGlucose()
		 _obj.bloodPressure = _x.getBloodPressure()
		 _obj.skinThickness = _x.getSkinThickness()
		 _obj.insulin = _x.getInsulin()
		 _obj.BMI = _x.getBMI()
		 _obj.diabetesPedigreeFunction = _x.getDiabetesPedigreeFunction()
		 _obj.age = _x.getAge()
		 _obj.outcome = _x.getOutcome()
		cdb.persistDiabeats(_x: _obj)
		}
	    currentDiabeats = _x
	}
			
	}
