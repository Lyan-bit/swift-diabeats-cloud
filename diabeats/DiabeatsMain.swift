              
              
import SwiftUI
import Firebase

@main 
struct diabeatsMain : App {
			
	init() {
	    FirebaseApp.configure()
	       }

	var body: some Scene {
	        WindowGroup {
	            ContentView(model: ModelFacade.getInstance())
	        }
	    }
	} 
