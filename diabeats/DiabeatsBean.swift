
import Foundation

class DiabeatsBean {
	
  var errorList : [String] = [String]()

  init() { }

  func resetData() { 
  	errorList = [String]()
  }

  func isCreateDiabeatsError(id: String, pregnancies: Int, glucose: Int, bloodPressure: Int, skinThickness: Int, insulin: Int, BMI: Double, diabetesPedigreeFunction: Double, age: Int, outcome: String) -> Bool { 
  	resetData() 

    return errorList.count > 0
  }

  func isEditDiabeatsError() -> Bool
    { return false }
          
  func isListDiabeatsError() -> Bool {
    resetData() 
    return false
  }
  
   func isDeleteDiabeatserror() -> Bool
     { return false }

  func errors() -> String {
    var res : String = ""
    for (_,x) in errorList.enumerated()
    { res = res + x + ", " }
    return res
  }

}
