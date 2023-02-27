
import Foundation

class DiabeatsVO : Hashable, Identifiable, Decodable, Encodable {

  var id: String = ""
  var pregnancies: Int = 0
  var glucose: Int = 0
  var bloodPressure: Int = 0
  var skinThickness: Int = 0
  var insulin: Int = 0
  var BMI: Double = 0.0
  var diabetesPedigreeFunction: Double = 0.0
  var age: Int = 0
  var outcome: String = ""

  static var defaultInstance : DiabeatsVO? = nil
  var errorList : [String] = [String]()

  init() {}

  static func defaultDiabeatsVO() -> DiabeatsVO
  { if defaultInstance == nil
    { defaultInstance = DiabeatsVO() }
    return defaultInstance!
  }

  init(idx: String, pregnanciesx: Int, glucosex: Int, bloodPressurex: Int, skinThicknessx: Int, insulinx: Int, BMIx: Double, diabetesPedigreeFunctionx: Double, agex: Int, outcomex: String)  {
    id = idx
    pregnancies = pregnanciesx
    glucose = glucosex
    bloodPressure = bloodPressurex
    skinThickness = skinThicknessx
    insulin = insulinx
    BMI = BMIx
    diabetesPedigreeFunction = diabetesPedigreeFunctionx
    age = agex
    outcome = outcomex
  }

  init(_x : Diabeats)  {
    id = _x.id
    pregnancies = _x.pregnancies
    glucose = _x.glucose
    bloodPressure = _x.bloodPressure
    skinThickness = _x.skinThickness
    insulin = _x.insulin
    BMI = _x.BMI
    diabetesPedigreeFunction = _x.diabetesPedigreeFunction
    age = _x.age
    outcome = _x.outcome
  }

  func toString() -> String
  { return " id= \(id), pregnancies= \(pregnancies), glucose= \(glucose), bloodPressure= \(bloodPressure), skinThickness= \(skinThickness), insulin= \(insulin), BMI= \(BMI), diabetesPedigreeFunction= \(diabetesPedigreeFunction), age= \(age), outcome= \(outcome) "
  }

  func getId() -> String
	  { return id }
	
  func setId(_x : String)
	  { id = _x }
	  
  func getPregnancies() -> Int
	  { return pregnancies }
	
  func setPregnancies(_x : Int)
	  { pregnancies = _x }
	  
  func getGlucose() -> Int
	  { return glucose }
	
  func setGlucose(_x : Int)
	  { glucose = _x }
	  
  func getBloodPressure() -> Int
	  { return bloodPressure }
	
  func setBloodPressure(_x : Int)
	  { bloodPressure = _x }
	  
  func getSkinThickness() -> Int
	  { return skinThickness }
	
  func setSkinThickness(_x : Int)
	  { skinThickness = _x }
	  
  func getInsulin() -> Int
	  { return insulin }
	
  func setInsulin(_x : Int)
	  { insulin = _x }
	  
  func getBMI() -> Double
	  { return BMI }
	
  func setBMI(_x : Double)
	  { BMI = _x }
	  
  func getDiabetesPedigreeFunction() -> Double
	  { return diabetesPedigreeFunction }
	
  func setDiabetesPedigreeFunction(_x : Double)
	  { diabetesPedigreeFunction = _x }
	  
  func getAge() -> Int
	  { return age }
	
  func setAge(_x : Int)
	  { age = _x }
	  
  func getOutcome() -> String
	  { return outcome }
	
  func setOutcome(_x : String)
	  { outcome = _x }
	  

  static func ==(lhs: DiabeatsVO, rhs: DiabeatsVO) -> Bool
  { return
      lhs.id == rhs.id &&
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
