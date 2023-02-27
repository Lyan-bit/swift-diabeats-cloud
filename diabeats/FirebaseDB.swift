import UIKit
import FirebaseAuth
import FirebaseDatabase

class FirebaseDB
{ static var instance : FirebaseDB? = nil
  var database : DatabaseReference? = nil

  static func getInstance() -> FirebaseDB
  { if instance == nil
    { instance = FirebaseDB() }
    return instance!
  }

  init() {
	  //cloud database link
      connectByURL("https://diabeats-8bcc9-default-rtdb.firebaseio.com/")
  }

  func connectByURL(_ url: String)
  { self.database = Database.database(url: url).reference()
    if self.database == nil
    { print("Invalid database url")
      return
    }
    self.database?.child("diabeatss").observe(.value,
      with:
      { (change) in
        var _keys : [String] = [String]()
        if let d = change.value as? [String : AnyObject]
        { for (_,v) in d.enumerated()
          { let _einst = v.1 as! [String : AnyObject]
            let _ex : Diabeats? = DiabeatsDAO.parseJSON(obj: _einst)
            _keys.append(_ex!.id)
          }
        }
        var _runtimediabeatss : [Diabeats] = [Diabeats]()
        _runtimediabeatss.append(contentsOf: Diabeats_allInstances)

        for (_,_obj) in _runtimediabeatss.enumerated()
        { if _keys.contains(_obj.id)
          {}
          else
          { killDiabeats(key: _obj.id) }
        }
      })
  }

func persistDiabeats(_x: Diabeats)
{ let _evo = DiabeatsDAO.writeJSON(_x: _x) 
  if let newChild = self.database?.child("diabeatss").child(_x.id)
  { newChild.setValue(_evo) }
}

func deleteDiabeats(_x: Diabeats)
{ if let oldChild = self.database?.child("diabeatss").child(_x.id)
  { oldChild.removeValue() }
}

}
