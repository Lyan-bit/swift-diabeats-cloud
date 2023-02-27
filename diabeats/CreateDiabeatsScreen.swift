
import SwiftUI

struct CreateDiabeatsScreen: View {
 
  @State var bean : DiabeatsVO = DiabeatsVO()
  @ObservedObject var model : ModelFacade

  var body: some View {
  	NavigationView {
  		ScrollView {
  	VStack(spacing: 20) {

  VStack(spacing: 20) {
		HStack (spacing: 20) {
		 Text("Id:").bold()
		 TextField("Id", text: $bean.id).textFieldStyle(RoundedBorderTextFieldStyle())
	}.frame(width: 200, height: 30).border(Color.gray)

		HStack (spacing: 20) {
		Text("Pregnancies:").bold()
		TextField("Pregnancies", value: $bean.pregnancies, formatter: NumberFormatter()).keyboardType(.decimalPad).textFieldStyle(RoundedBorderTextFieldStyle())
	}.frame(width: 200, height: 30).border(Color.gray)

		HStack (spacing: 20) {
		Text("Glucose:").bold()
		TextField("Glucose", value: $bean.glucose, formatter: NumberFormatter()).keyboardType(.decimalPad).textFieldStyle(RoundedBorderTextFieldStyle())
	}.frame(width: 200, height: 30).border(Color.gray)

		HStack (spacing: 20) {
		Text("BloodPressure:").bold()
		TextField("BloodPressure", value: $bean.bloodPressure, formatter: NumberFormatter()).keyboardType(.decimalPad).textFieldStyle(RoundedBorderTextFieldStyle())
	}.frame(width: 200, height: 30).border(Color.gray)

		HStack (spacing: 20) {
		Text("SkinThickness:").bold()
		TextField("SkinThickness", value: $bean.skinThickness, formatter: NumberFormatter()).keyboardType(.decimalPad).textFieldStyle(RoundedBorderTextFieldStyle())
	}.frame(width: 200, height: 30).border(Color.gray)

		HStack (spacing: 20) {
		Text("Insulin:").bold()
		TextField("Insulin", value: $bean.insulin, formatter: NumberFormatter()).keyboardType(.decimalPad).textFieldStyle(RoundedBorderTextFieldStyle())
	}.frame(width: 200, height: 30).border(Color.gray)

	}
	VStack(spacing: 20) {
		HStack (spacing: 20) {
		 Text("BMI:").bold()
		 TextField("BMI", value: $bean.BMI, formatter: NumberFormatter()).keyboardType(.decimalPad).textFieldStyle(RoundedBorderTextFieldStyle())
		 }.frame(width: 200, height: 30).border(Color.gray)

		HStack (spacing: 20) {
		 Text("DiabetesPedigreeFunction:").bold()
		 TextField("DiabetesPedigreeFunction", value: $bean.diabetesPedigreeFunction, formatter: NumberFormatter()).keyboardType(.decimalPad).textFieldStyle(RoundedBorderTextFieldStyle())
		 }.frame(width: 200, height: 30).border(Color.gray)

		HStack (spacing: 20) {
		 Text("Age:").bold()
		 TextField("Age", value: $bean.age, formatter: NumberFormatter()).keyboardType(.decimalPad).textFieldStyle(RoundedBorderTextFieldStyle())
		 }.frame(width: 200, height: 30).border(Color.gray)

		HStack (spacing: 20)  {
		  Text("Outcome:").bold()
		  TextField("Outcome", text: $bean.outcome).textFieldStyle(RoundedBorderTextFieldStyle())
		  }.frame(width: 200, height: 30).border(Color.gray)

}

      HStack(spacing: 20) {
        Button(action: { 
        	self.model.createDiabeats(_x: bean)
        } ) { Text("Create") }
        Button(action: { self.model.cancelCreateDiabeats() } ) { Text("Cancel") }
      }.buttonStyle(.bordered)
    }.padding(.top)
     }.navigationTitle("Create Diabeats")
    }
  }
}

struct CreateDiabeatsScreen_Previews: PreviewProvider {
    static var previews: some View {
        CreateDiabeatsScreen(model: ModelFacade.getInstance())
    }
}

