
import Foundation

class ClassifyDiabeatsVO {
  var diabeats : String = ""

  static var defaultInstance : ClassifyDiabeatsVO? = nil
  var errorList : [String] = [String]()

  var result : String = ""

  init() {}
  
  static func defaultClassifyDiabeatsVO() -> ClassifyDiabeatsVO
  { if defaultInstance == nil
    { defaultInstance = ClassifyDiabeatsVO() }
    return defaultInstance!
  }

  init(diabeatsx: String)  {
  diabeats = diabeatsx
  }

  func toString() -> String
  	{ return "" + "diabeats = " + diabeats }

  func getDiabeats() -> Diabeats
  	{ return Diabeats.Diabeats_index[diabeats]! }
			
  func setDiabeats(_x : Diabeats)
  	{ diabeats = _x.id }
			  
  func setResult (_x: String) {
    result = _x }
          
  func resetData()
  	{ errorList = [String]() }

  func isClassifyDiabeatsError() -> Bool
  	{ resetData()
  
 if Diabeats.Diabeats_index[diabeats] == nil
	{ errorList.append("Invalid diabeats id: " + diabeats) }

    if errorList.count > 0
    { return true }
    
    return false
  }

  func errors() -> String
  { var res : String = ""
    for (_,x) in errorList.enumerated()
    { res = res + x + ", " }
    return res
  }

}

