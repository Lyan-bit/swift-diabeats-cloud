
import SwiftUI

struct ListDiabeatsRowScreen: View {
    
    var instance : DiabeatsVO
    @ObservedObject var model : ModelFacade = ModelFacade.getInstance()

      var body: some View { 
      	ScrollView {
    VStack {
        HStack  {
          Text(String(instance.id)).bold()
          Text(String(instance.pregnancies))
          Text(String(instance.glucose))
          Text(String(instance.bloodPressure))
          Text(String(instance.skinThickness))
          Text(String(instance.insulin))
	    }
        HStack {
          Text(String(instance.BMI))
          Text(String(instance.diabetesPedigreeFunction))
          Text(String(instance.age))
          Text(String(instance.outcome))
        }
}.onAppear()


          { model.setSelectedDiabeats(_x: instance) 
          }
        }
      }
    }

    struct ListDiabeatsRowScreen_Previews: PreviewProvider {
      static var previews: some View {
        ListDiabeatsRowScreen(instance: DiabeatsVO(_x: Diabeats_allInstances[0]))
      }
    }

