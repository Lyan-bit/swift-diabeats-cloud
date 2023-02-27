	                  
import Foundation
import SwiftUI

/* This code requires OclFile.swift */

func initialiseOclFile()
{ 
  //let systemIn = createByPKOclFile(key: "System.in")
  //let systemOut = createByPKOclFile(key: "System.out")
  //let systemErr = createByPKOclFile(key: "System.err")
}

/* This metatype code requires OclType.swift */

func initialiseOclType()
{ let intOclType = createByPKOclType(key: "int")
  intOclType.actualMetatype = Int.self
  let doubleOclType = createByPKOclType(key: "double")
  doubleOclType.actualMetatype = Double.self
  let longOclType = createByPKOclType(key: "long")
  longOclType.actualMetatype = Int64.self
  let stringOclType = createByPKOclType(key: "String")
  stringOclType.actualMetatype = String.self
  let sequenceOclType = createByPKOclType(key: "Sequence")
  sequenceOclType.actualMetatype = type(of: [])
  let anyset : Set<AnyHashable> = Set<AnyHashable>()
  let setOclType = createByPKOclType(key: "Set")
  setOclType.actualMetatype = type(of: anyset)
  let mapOclType = createByPKOclType(key: "Map")
  mapOclType.actualMetatype = type(of: [:])
  let voidOclType = createByPKOclType(key: "void")
  voidOclType.actualMetatype = Void.self
	
  let diabeatsOclType = createByPKOclType(key: "Diabeats")
  diabeatsOclType.actualMetatype = Diabeats.self

  let diabeatsId = createOclAttribute()
  	  diabeatsId.name = "id"
  	  diabeatsId.type = stringOclType
  	  diabeatsOclType.attributes.append(diabeatsId)
  let diabeatsPregnancies = createOclAttribute()
  	  diabeatsPregnancies.name = "pregnancies"
  	  diabeatsPregnancies.type = intOclType
  	  diabeatsOclType.attributes.append(diabeatsPregnancies)
  let diabeatsGlucose = createOclAttribute()
  	  diabeatsGlucose.name = "glucose"
  	  diabeatsGlucose.type = intOclType
  	  diabeatsOclType.attributes.append(diabeatsGlucose)
  let diabeatsBloodPressure = createOclAttribute()
  	  diabeatsBloodPressure.name = "bloodPressure"
  	  diabeatsBloodPressure.type = intOclType
  	  diabeatsOclType.attributes.append(diabeatsBloodPressure)
  let diabeatsSkinThickness = createOclAttribute()
  	  diabeatsSkinThickness.name = "skinThickness"
  	  diabeatsSkinThickness.type = intOclType
  	  diabeatsOclType.attributes.append(diabeatsSkinThickness)
  let diabeatsInsulin = createOclAttribute()
  	  diabeatsInsulin.name = "insulin"
  	  diabeatsInsulin.type = intOclType
  	  diabeatsOclType.attributes.append(diabeatsInsulin)
  let diabeatsBmi = createOclAttribute()
  	  diabeatsBmi.name = "bmi"
  	  diabeatsBmi.type = doubleOclType
  	  diabeatsOclType.attributes.append(diabeatsBmi)
  let diabeatsDiabetesPedigreeFunction = createOclAttribute()
  	  diabeatsDiabetesPedigreeFunction.name = "diabetesPedigreeFunction"
  	  diabeatsDiabetesPedigreeFunction.type = doubleOclType
  	  diabeatsOclType.attributes.append(diabeatsDiabetesPedigreeFunction)
  let diabeatsAge = createOclAttribute()
  	  diabeatsAge.name = "age"
  	  diabeatsAge.type = intOclType
  	  diabeatsOclType.attributes.append(diabeatsAge)
  let diabeatsOutcome = createOclAttribute()
  	  diabeatsOutcome.name = "outcome"
  	  diabeatsOutcome.type = stringOclType
  	  diabeatsOclType.attributes.append(diabeatsOutcome)
}

func instanceFromJSON(typeName: String, json: String) -> AnyObject?
	{ let jdata = json.data(using: .utf8)!
	  let decoder = JSONDecoder()
	  if typeName == "String"
	  { let x = try? decoder.decode(String.self, from: jdata)
	      return x as AnyObject
	  }
if typeName == "Diabeats"
  { let x = try? decoder.decode(Diabeats.self, from: jdata) 
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
		// init
	}
	      
	@Published var currentDiabeats : DiabeatsVO? = DiabeatsVO.defaultDiabeatsVO()
	@Published var currentDiabeatss : [DiabeatsVO] = [DiabeatsVO]()

	func createDiabeats(x : DiabeatsVO) {
		   if let obj = getDiabeatsByPK(val: x.id)
		   { cdb.persistDiabeats(x: obj) }
		   else {
		   let item : Diabeats = createByPKDiabeats(key: x.id)
		 item.id = x.getId()
		 item.pregnancies = x.getPregnancies()
		 item.glucose = x.getGlucose()
		 item.bloodPressure = x.getBloodPressure()
		 item.skinThickness = x.getSkinThickness()
		 item.insulin = x.getInsulin()
		 item.bmi = x.getBmi()
		 item.diabetesPedigreeFunction = x.getDiabetesPedigreeFunction()
		 item.age = x.getAge()
		 item.outcome = x.getOutcome()
		   cdb.persistDiabeats(x: item)
		   }
	     currentDiabeats = x
	}

	func cancelCreateDiabeats() {
		//cancel function
	}

    func classifyDiabeats(x : String) -> String {
        guard let diabeats = getDiabeatsByPK(val: x)
        else {
            return "Please selsect valid id"
        }
        
        guard let result = self.modelParser?.runModel(
          input0: Float((diabeats.pregnancies - 0) / (17 - 0)),
          input1: Float((diabeats.glucose - 0) / (199 - 0)),
          input2: Float((diabeats.bloodPressure - 0) / (122 - 0)),
          input3: Float((diabeats.skinThickness - 0) / (99 - 0)),
          input4: Float((diabeats.insulin - 0) / (846 - 0)),
          input5: Float((diabeats.bmi - 0) / (67.1 - 0)),
          input6: Float((diabeats.diabetesPedigreeFunction - 0.78) / (2.42 - 0.78)),
          input7: Float((diabeats.age - 21) / (81 - 21))
        ) else{
            return "Error"
        }
        
        diabeats.outcome = result
        persistDiabeats(x: diabeats)
        
        return result
	}
	
	func cancelClassifyDiabeats() {
		//cancel function
	}
	    


    func listDiabeats() -> [DiabeatsVO] {
		currentDiabeatss = [DiabeatsVO]()
		let list : [Diabeats] = DiabeatsAllInstances
		for (_,x) in list.enumerated()
		{ currentDiabeatss.append(DiabeatsVO(x: x)) }
		return currentDiabeatss
	}
			
	func loadDiabeats() {
		let res : [DiabeatsVO] = listDiabeats()
		
		for (_,x) in res.enumerated() {
			let obj = createByPKDiabeats(key: x.id)
	        obj.id = x.getId()
        obj.pregnancies = x.getPregnancies()
        obj.glucose = x.getGlucose()
        obj.bloodPressure = x.getBloodPressure()
        obj.skinThickness = x.getSkinThickness()
        obj.insulin = x.getInsulin()
        obj.bmi = x.getBmi()
        obj.diabetesPedigreeFunction = x.getDiabetesPedigreeFunction()
        obj.age = x.getAge()
        obj.outcome = x.getOutcome()
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
			
    func searchByDiabeatsid(val : String) -> [DiabeatsVO] {
	    var resultList: [DiabeatsVO] = [DiabeatsVO]()
	    let list : [Diabeats] = DiabeatsAllInstances
	    for (_,x) in list.enumerated() {
	    	if (x.id == val) {
	    		resultList.append(DiabeatsVO(x: x))
	    	}
	    }
	  return resultList
	}
	
    func searchByDiabeatspregnancies(val : Int) -> [DiabeatsVO] {
	    var resultList: [DiabeatsVO] = [DiabeatsVO]()
	    let list : [Diabeats] = DiabeatsAllInstances
	    for (_,x) in list.enumerated() {
	    	if (x.pregnancies == val) {
	    		resultList.append(DiabeatsVO(x: x))
	    	}
	    }
	  return resultList
	}
	
    func searchByDiabeatsglucose(val : Int) -> [DiabeatsVO] {
	    var resultList: [DiabeatsVO] = [DiabeatsVO]()
	    let list : [Diabeats] = DiabeatsAllInstances
	    for (_,x) in list.enumerated() {
	    	if (x.glucose == val) {
	    		resultList.append(DiabeatsVO(x: x))
	    	}
	    }
	  return resultList
	}
	
    func searchByDiabeatsbloodPressure(val : Int) -> [DiabeatsVO] {
	    var resultList: [DiabeatsVO] = [DiabeatsVO]()
	    let list : [Diabeats] = DiabeatsAllInstances
	    for (_,x) in list.enumerated() {
	    	if (x.bloodPressure == val) {
	    		resultList.append(DiabeatsVO(x: x))
	    	}
	    }
	  return resultList
	}
	
    func searchByDiabeatsskinThickness(val : Int) -> [DiabeatsVO] {
	    var resultList: [DiabeatsVO] = [DiabeatsVO]()
	    let list : [Diabeats] = DiabeatsAllInstances
	    for (_,x) in list.enumerated() {
	    	if (x.skinThickness == val) {
	    		resultList.append(DiabeatsVO(x: x))
	    	}
	    }
	  return resultList
	}
	
    func searchByDiabeatsinsulin(val : Int) -> [DiabeatsVO] {
	    var resultList: [DiabeatsVO] = [DiabeatsVO]()
	    let list : [Diabeats] = DiabeatsAllInstances
	    for (_,x) in list.enumerated() {
	    	if (x.insulin == val) {
	    		resultList.append(DiabeatsVO(x: x))
	    	}
	    }
	  return resultList
	}
	
    func searchByDiabeatsbmi(val : Double) -> [DiabeatsVO] {
	    var resultList: [DiabeatsVO] = [DiabeatsVO]()
	    let list : [Diabeats] = DiabeatsAllInstances
	    for (_,x) in list.enumerated() {
	    	if (x.bmi == val) {
	    		resultList.append(DiabeatsVO(x: x))
	    	}
	    }
	  return resultList
	}
	
    func searchByDiabeatsdiabetesPedigreeFunction(val : Double) -> [DiabeatsVO] {
	    var resultList: [DiabeatsVO] = [DiabeatsVO]()
	    let list : [Diabeats] = DiabeatsAllInstances
	    for (_,x) in list.enumerated() {
	    	if (x.diabetesPedigreeFunction == val) {
	    		resultList.append(DiabeatsVO(x: x))
	    	}
	    }
	  return resultList
	}
	
    func searchByDiabeatsage(val : Int) -> [DiabeatsVO] {
	    var resultList: [DiabeatsVO] = [DiabeatsVO]()
	    let list : [Diabeats] = DiabeatsAllInstances
	    for (_,x) in list.enumerated() {
	    	if (x.age == val) {
	    		resultList.append(DiabeatsVO(x: x))
	    	}
	    }
	  return resultList
	}
	
    func searchByDiabeatsoutcome(val : String) -> [DiabeatsVO] {
	    var resultList: [DiabeatsVO] = [DiabeatsVO]()
	    let list : [Diabeats] = DiabeatsAllInstances
	    for (_,x) in list.enumerated() {
	    	if (x.outcome == val) {
	    		resultList.append(DiabeatsVO(x: x))
	    	}
	    }
	  return resultList
	}
	
		
	func getDiabeatsByPK(val: String) -> Diabeats?
		{ return Diabeats.diabeatsIndex[val] }
			
	func retrieveDiabeats(val: String) -> Diabeats?
			{ return Diabeats.diabeatsIndex[val] }
			
	func allDiabeatsids() -> [String] {
			var res : [String] = [String]()
			for (_,item) in currentDiabeatss.enumerated()
			{ res.append(item.id + "") }
			return res
	}
			
	func setSelectedDiabeats(x : DiabeatsVO)
		{ currentDiabeats = x }
			
	func setSelectedDiabeats(i : Int) {
		if i < currentDiabeatss.count
		{ currentDiabeats = currentDiabeatss[i] }
	}
			
	func getSelectedDiabeats() -> DiabeatsVO?
		{ return currentDiabeats }
			
	func persistDiabeats(x : Diabeats) {
		let vo : DiabeatsVO = DiabeatsVO(x: x)
		cdb.persistDiabeats(x: x)
		currentDiabeats = vo
	}
		
	func editDiabeats(x : DiabeatsVO) {
		if let obj = getDiabeatsByPK(val: x.id) {
		 obj.id = x.getId()
		 obj.pregnancies = x.getPregnancies()
		 obj.glucose = x.getGlucose()
		 obj.bloodPressure = x.getBloodPressure()
		 obj.skinThickness = x.getSkinThickness()
		 obj.insulin = x.getInsulin()
		 obj.bmi = x.getBmi()
		 obj.diabetesPedigreeFunction = x.getDiabetesPedigreeFunction()
		 obj.age = x.getAge()
		 obj.outcome = x.getOutcome()
		cdb.persistDiabeats(x: obj)
		}
	    currentDiabeats = x
	}
			
	}
