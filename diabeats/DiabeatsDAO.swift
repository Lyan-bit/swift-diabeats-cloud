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
    { let _x : Diabeats? = Diabeats.Diabeats_index[id]
    if _x == nil 
    { return false }
    return true
  }

  static func getCachedInstance(id : String) -> Diabeats
    { return Diabeats.Diabeats_index[id]! }

  static func parseCSV(_line: String) -> Diabeats?
  { if _line.count == 0
    { return nil }
    let _line1vals : [String] = Ocl.tokeniseCSV(line: _line)
    var diabeatsx : Diabeats? = nil
      diabeatsx = Diabeats.Diabeats_index[_line1vals[0]]
    if diabeatsx == nil
    { diabeatsx = createByPKDiabeats(key: _line1vals[0]) }
    diabeatsx!.id = _line1vals[0]
    diabeatsx!.pregnancies = Int(_line1vals[1]) ?? 0
    diabeatsx!.glucose = Int(_line1vals[2]) ?? 0
    diabeatsx!.bloodPressure = Int(_line1vals[3]) ?? 0
    diabeatsx!.skinThickness = Int(_line1vals[4]) ?? 0
    diabeatsx!.insulin = Int(_line1vals[5]) ?? 0
    diabeatsx!.BMI = Double(_line1vals[6]) ?? 0
    diabeatsx!.diabetesPedigreeFunction = Double(_line1vals[7]) ?? 0
    diabeatsx!.age = Int(_line1vals[8]) ?? 0
    diabeatsx!.outcome = _line1vals[9]

    return diabeatsx
  }

  static func parseJSON(obj : [String : AnyObject]?) -> Diabeats?
  {

    if let jsonObj = obj
    { let id : String? = jsonObj["id"] as! String?
      var _diabeatsx : Diabeats? = Diabeats.Diabeats_index[id!]
      if (_diabeatsx == nil)
      { _diabeatsx = createByPKDiabeats(key: id!) }

       _diabeatsx!.id = jsonObj["id"] as! String
       _diabeatsx!.pregnancies = jsonObj["pregnancies"] as! Int
       _diabeatsx!.glucose = jsonObj["glucose"] as! Int
       _diabeatsx!.bloodPressure = jsonObj["bloodPressure"] as! Int
       _diabeatsx!.skinThickness = jsonObj["skinThickness"] as! Int
       _diabeatsx!.insulin = jsonObj["insulin"] as! Int
       _diabeatsx!.BMI = jsonObj["BMI"] as! Double
       _diabeatsx!.diabetesPedigreeFunction = jsonObj["diabetesPedigreeFunction"] as! Double
       _diabeatsx!.age = jsonObj["age"] as! Int
       _diabeatsx!.outcome = jsonObj["outcome"] as! String
      return _diabeatsx!
    }
    return nil
  }

  static func writeJSON(_x : Diabeats) -> NSDictionary
  { return [    
       "id": _x.id as NSString, 
       "pregnancies": NSNumber(value: _x.pregnancies), 
       "glucose": NSNumber(value: _x.glucose), 
       "bloodPressure": NSNumber(value: _x.bloodPressure), 
       "skinThickness": NSNumber(value: _x.skinThickness), 
       "insulin": NSNumber(value: _x.insulin), 
       "BMI": NSNumber(value: _x.BMI), 
       "diabetesPedigreeFunction": NSNumber(value: _x.diabetesPedigreeFunction), 
       "age": NSNumber(value: _x.age), 
       "outcome": _x.outcome as NSString
     ]
  } 

  static func makeFromCSV(lines: String) -> [Diabeats]
  { var res : [Diabeats] = [Diabeats]()

    if lines.count == 0
    { return res }

    let rows : [String] = Ocl.parseCSVtable(rows: lines)

    for (_,row) in rows.enumerated()
    { if row.count == 0
      { }
      else
      { let _x : Diabeats? = parseCSV(_line: row)
        if (_x != nil)
        { res.append(_x!) }
      }
    }
    return res
  }
}

