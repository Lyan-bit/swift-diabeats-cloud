import Foundation

class DiabeatsDAO
{ static func getURL(command : String?, pars : [String], values : [String]) -> String
  { var res : String = "base url for the data source"
    if command != nil
    { res = res + command! }
    if pars.count == 0
    { return res }
    res = res + "?"
    for (i,v) in pars.enumerated()
    { res = res + v + "=" + values[i]
      if i < pars.count - 1
      { res = res + "&" }
    }
    return res
  }

  static func isCached(id : String) -> Bool
    { let x : Diabeats? = Diabeats.diabeatsIndex[id]
    if x == nil 
    { return false }
    return true
  }

  static func getCachedInstance(id : String) -> Diabeats
    { return Diabeats.diabeatsIndex[id]! }

  static func parseCSV(line: String) -> Diabeats?
  { if line.count == 0
    { return nil }
    let line1vals : [String] = Ocl.tokeniseCSV(line: line)
    var diabeatsx : Diabeats? = nil
      diabeatsx = Diabeats.diabeatsIndex[line1vals[0]]
    if diabeatsx == nil
    { diabeatsx = createByPKDiabeats(key: line1vals[0]) }
    diabeatsx!.id = line1vals[0]
    diabeatsx!.pregnancies = Int(line1vals[1]) ?? 0
    diabeatsx!.glucose = Int(line1vals[2]) ?? 0
    diabeatsx!.bloodPressure = Int(line1vals[3]) ?? 0
    diabeatsx!.skinThickness = Int(line1vals[4]) ?? 0
    diabeatsx!.insulin = Int(line1vals[5]) ?? 0
    diabeatsx!.bmi = Double(line1vals[6]) ?? 0
    diabeatsx!.diabetesPedigreeFunction = Double(line1vals[7]) ?? 0
    diabeatsx!.age = Int(line1vals[8]) ?? 0
    diabeatsx!.outcome = line1vals[9]

    return diabeatsx
  }

  static func parseJSON(obj : [String : AnyObject]?) -> Diabeats?
  {

    if let jsonObj = obj
    { let id : String? = jsonObj["id"] as! String?
      var diabeatsx : Diabeats? = Diabeats.diabeatsIndex[id!]
      if (diabeatsx == nil)
      { diabeatsx = createByPKDiabeats(key: id!) }

       diabeatsx!.id = jsonObj["id"] as! String
       diabeatsx!.pregnancies = jsonObj["pregnancies"] as! Int
       diabeatsx!.glucose = jsonObj["glucose"] as! Int
       diabeatsx!.bloodPressure = jsonObj["bloodPressure"] as! Int
       diabeatsx!.skinThickness = jsonObj["skinThickness"] as! Int
       diabeatsx!.insulin = jsonObj["insulin"] as! Int
       diabeatsx!.bmi = jsonObj["bmi"] as! Double
       diabeatsx!.diabetesPedigreeFunction = jsonObj["diabetesPedigreeFunction"] as! Double
       diabeatsx!.age = jsonObj["age"] as! Int
       diabeatsx!.outcome = jsonObj["outcome"] as! String
      return diabeatsx!
    }
    return nil
  }

  static func writeJSON(x : Diabeats) -> NSDictionary
  { return [    
       "id": x.id as NSString, 
       "pregnancies": NSNumber(value: x.pregnancies), 
       "glucose": NSNumber(value: x.glucose), 
       "bloodPressure": NSNumber(value: x.bloodPressure), 
       "skinThickness": NSNumber(value: x.skinThickness), 
       "insulin": NSNumber(value: x.insulin), 
       "bmi": NSNumber(value: x.bmi), 
       "diabetesPedigreeFunction": NSNumber(value: x.diabetesPedigreeFunction), 
       "age": NSNumber(value: x.age), 
       "outcome": x.outcome as NSString
     ]
  } 

  static func makeFromCSV(lines: String) -> [Diabeats]
  { var res : [Diabeats] = [Diabeats]()

    if lines.count == 0
    { return res }

    let rows : [String] = Ocl.parseCSVtable(rows: lines)

    for (_,row) in rows.enumerated()
    { if row.count == 0 {
    	//check
    }
      else
      { let x : Diabeats? = parseCSV(line: row)
        if (x != nil)
        { res.append(x!) }
      }
    }
    return res
  }
}

