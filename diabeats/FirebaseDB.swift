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
        var keys : [String] = [String]()
        if let d = change.value as? [String : AnyObject]
        { for (_,v) in d.enumerated()
          { let einst = v.1 as! [String : AnyObject]
            let ex : Diabeats? = DiabeatsDAO.parseJSON(obj: einst)
            keys.append(ex!.id)
          }
        }
        var runtimediabeatss : [Diabeats] = [Diabeats]()
        runtimediabeatss.append(contentsOf: DiabeatsAllInstances)

        for (_,obj) in runtimediabeatss.enumerated()
        { if keys.contains(obj.id) {
        	//check
        }
          else
          { killDiabeats(key: obj.id) }
        }
      })
  }

func persistDiabeats(x: Diabeats)
{ let evo = DiabeatsDAO.writeJSON(x: x) 
  if let newChild = self.database?.child("diabeatss").child(x.id)
  { newChild.setValue(evo) }
}

func deleteDiabeats(x: Diabeats)
{ if let oldChild = self.database?.child("diabeatss").child(x.id)
  { oldChild.removeValue() }
}

}
