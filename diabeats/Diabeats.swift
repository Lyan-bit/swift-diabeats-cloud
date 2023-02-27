
import Foundation

class Diabeats : Decodable {
	
  private static var instance : Diabeats? = nil	
  
  init() { }
  
  init(copyFrom: Diabeats) {
  	self.id = "copy_" + copyFrom.id
  	self.pregnancies = copyFrom.pregnancies
  	self.glucose = copyFrom.glucose
  	self.bloodPressure = copyFrom.bloodPressure
  	self.skinThickness = copyFrom.skinThickness
  	self.insulin = copyFrom.insulin
  	self.BMI = copyFrom.BMI
  	self.diabetesPedigreeFunction = copyFrom.diabetesPedigreeFunction
  	self.age = copyFrom.age
  	self.outcome = copyFrom.outcome
  }
  
  func copy() -> Diabeats
  { let res : Diabeats = Diabeats(copyFrom: self)
  	addDiabeats(instance: res)
  	return res
  }
  
static func defaultInstanceDiabeats() -> Diabeats
    { if (instance == nil)
    { instance = createDiabeats() }
    return instance!
}

deinit
{ killDiabeats(obj: self) }	


  var id: String = ""  /* primary key */
  var pregnancies: Int = 0 
  var glucose: Int = 0 
  var bloodPressure: Int = 0 
  var skinThickness: Int = 0 
  var insulin: Int = 0 
  var BMI: Double = 0.0 
  var diabetesPedigreeFunction: Double = 0.0 
  var age: Int = 0 
  var outcome: String = "" 

  static var Diabeats_index : Dictionary<String,Diabeats> = [String:Diabeats]()

  static func getByPKDiabeats(index : String) -> Diabeats?
  { return Diabeats_index[index] }


}

  var Diabeats_allInstances : [Diabeats] = [Diabeats]()

  func createDiabeats() -> Diabeats
	{ let result : Diabeats = Diabeats()
	  Diabeats_allInstances.append(result)
	  return result }
  
  func addDiabeats(instance : Diabeats)
	{ Diabeats_allInstances.append(instance) }

  func killDiabeats(obj: Diabeats)
	{ Diabeats_allInstances = Diabeats_allInstances.filter{ $0 !== obj } }

  func createByPKDiabeats(key : String) -> Diabeats
	{ var result : Diabeats? = Diabeats.getByPKDiabeats(index: key)
	  if result != nil { return result! }
	  result = Diabeats()
	  Diabeats_allInstances.append(result!)
	  Diabeats.Diabeats_index[key] = result!
	  result!.id = key
	  return result! }

  func killDiabeats(key : String)
	{ Diabeats.Diabeats_index[key] = nil
	  Diabeats_allInstances.removeAll(where: { $0.id == key })
	}
	
	extension Diabeats : Hashable, Identifiable
	{ 
	  static func ==(lhs: Diabeats, rhs: Diabeats) -> Bool
	  {       lhs.id == rhs.id &&
      lhs.pregnancies == rhs.pregnancies &&
      lhs.glucose == rhs.glucose &&
      lhs.bloodPressure == rhs.bloodPressure &&
      lhs.skinThickness == rhs.skinThickness &&
      lhs.insulin == rhs.insulin &&
      lhs.BMI == rhs.BMI &&
      lhs.diabetesPedigreeFunction == rhs.diabetesPedigreeFunction &&
      lhs.age == rhs.age &&
      lhs.outcome == rhs.outcome
	  }
	
	  func hash(into hasher: inout Hasher) {
    	hasher.combine(id)
    	hasher.combine(pregnancies)
    	hasher.combine(glucose)
    	hasher.combine(bloodPressure)
    	hasher.combine(skinThickness)
    	hasher.combine(insulin)
    	hasher.combine(BMI)
    	hasher.combine(diabetesPedigreeFunction)
    	hasher.combine(age)
    	hasher.combine(outcome)
	  }
	}
	

