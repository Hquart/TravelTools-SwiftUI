//
//  TranslationView.swift
//  myBaluchon2
//
//  Created by Naji Achkar on 08/02/2021.
//
//Notes:
// No mult line textField available in SwiftUI at this time, we could wrap a UITextView

import SwiftUI
import Combine

struct TranslationView: View {

    @EnvironmentObject var destination: Destination
    @StateObject var viewModel: TranslationViewModel
   
    @State private var isEditing: Bool = false
    
    let alertMessage = "Veuillez saisir du texte à traduire en français"
    ////////////////////////////////////////////////////////////////////////////////////
    // MARK: - BODY
    ////////////////////////////////////////////////////////////////////////////////////
    var body: some View {
        NavigationView {
            VStack {
                //////////////////////////////// LOGO ////////////////////////////////////////////////////
                if isEditing == false {
                    Image("myBaluchon")
                        .position(x: 190, y: 80)
                        .transition(.asymmetric(insertion: .scale, removal: .opacity)) .animation(.easeInOut(duration: 1))
                }
                Spacer(minLength: 100)
                ////////////////////////////////////////////////////////////////////////////////////
                // MARK: - INPUT TEXTFIELD
                ////////////////////////////////////////////////////////////////////////////////////
                TextField("texte à traduire", text: $viewModel.input) { isEditing in
                    self.isEditing = isEditing
//                    if isEditing {
//                        viewModel.input = " "
//                    }
                }
                onCommit: { didAskForTranslation() }
                    .foregroundColor(.appGreen)
                    .padding(.trailing)
                    .font(.system(size: 20, weight: .heavy, design: .default))
                    .frame(width: 300, height: 150, alignment: .center)
                    .background(Image("FRA")
                                    .resizable()
                                    .frame(width: 300, height: 150, alignment: .center)
                                    .opacity(self.isEditing ? 0.2 : 0.8))
                    .multilineTextAlignment(.center)
                    .keyboardType(.default)
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.appGreen, lineWidth: 5))
                    .modifier(ClearButton(text:  $viewModel.input))
                    .transition(.asymmetric(insertion: .scale, removal: .opacity))
                    .animation(.easeInOut(duration: 1))
                ////////////////////////////////////////////////////////////////////////////////////
                // MARK: - TRANSLATE BUTTON
                ////////////////////////////////////////////////////////////////////////////////////
                Spacer(minLength: 20)
                Button(action: { didAskForTranslation() })  {
                    Text("Traduire")
                        .fontWeight(.bold)
                        .font(.title)
                        .padding()
                        .background(Color.gray)
                        .cornerRadius(40)
                        .foregroundColor(.white)
                }
                Spacer(minLength: 20)
                ////////////////////////////////////////////////////////////////////////////////////
                // MARK: - OUTPUT TEXTFIELD
                ////////////////////////////////////////////////////////////////////////////////////
                Text(isEditing ? "" : viewModel.output)
                    .foregroundColor(.appRed)
                    .font(.system(size: 20, weight: .heavy, design: .default))
                    .frame(width: 300, height: 150, alignment: .center)
                    .background(Image("\(Destination.flag[destination.selection])").resizable().frame(width: 300, height: 150, alignment: .center)
                    .opacity(self.isEditing ? 0.8 : 0.2))
                    .multilineTextAlignment(.center)
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.appGreen, lineWidth: 5))
                ///////////////////////////////////////////////////////////////////////////////////////
                Spacer(minLength: 20)
            }
            .navigationBarTitle("Communiquer")
            .transition(.asymmetric(insertion: .scale, removal: .opacity)).animation(.easeInOut(duration: 1))
            Spacer()
        }
        .onAppear(perform: { resetView() })
        .alert(isPresented: $viewModel.showAlert) {
            Alert(title: Text("Texte incorrect"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }
    func resetView() {
        self.isEditing = false
        viewModel.output = ""
        viewModel.input = ""
    }
    func didAskForTranslation() {
        viewModel.destinationSelected = self.destination.selection
        self.isEditing = false
        viewModel.translate()
        hideKeyboard()
    }
}
////////////////////////////////////////////////////////////////////////////////////
// MARK: PREVIEW
////////////////////////////////////////////////////////////////////////////////////
struct TranslationView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TranslationView(viewModel: TranslationViewModel())
                .environmentObject(Destination())
        }
    }
}

