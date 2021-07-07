//
//  ConversionView.swift
//  myBaluchon2
//
//  Created by Naji Achkar on 08/02/2021.
//

import SwiftUI

struct CurrencyView: View {

    @EnvironmentObject var destination: Destination
    @StateObject var viewModel: CurrencyViewModel
    
    @State private var isEditing: Bool = false
    ////////////////////////////////////////////////////////////////////////////////////
    // MARK: - BODY
    ////////////////////////////////////////////////////////////////////////////////////
    var body: some View {
        NavigationView {
            VStack {
                ////////////////////   LOGO //////////////////////
                if isEditing == false {  // while editing the logo disappears
                    Image("myBaluchon")
                        .position(x: 190, y: 80)
                        .transition(.asymmetric(insertion: .scale, removal: .opacity)).animation(.easeInOut(duration: 1))
                }
                Spacer()
                ////////////////////////////////////////////////////////////////////////////////////
                // MARK: - INPUT TEXTFIELD
                ////////////////////////////////////////////////////////////////////////////////////
                TextField("Montant à convertir", text: $viewModel.input) { isEditing in
                    self.isEditing = isEditing
                }
                onCommit: {
                    self.isEditing = false
                    hideKeyboard()
                    viewModel.convert()
                }
                .foregroundColor(.appGreen)
                .font(.system(size: 20, weight: .heavy, design: .default))
                .frame(width: 300, height: 150, alignment: .center)
                .background(Image(systemName: "eurosign.square.fill")
                                .resizable().frame(width: 300, height: 150, alignment: .center)
                                .scaledToFit()
                                .opacity(self.isEditing ? 0.2 : 0.8))
                .foregroundColor(.appLightGrey)
                .multilineTextAlignment(.center)
                .keyboardType(.numberPad)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.appGreen, lineWidth: 5))
                .modifier(ClearButton(text:  $viewModel.input))
                .transition(.asymmetric(insertion: .scale, removal: .opacity)) .animation(.easeInOut(duration: 1))
                ////////////////////////////////////////////////////////////////////////////////////
                // MARK: - CONVERT BUTTON
                //////////////////////////////////////////////////////////////////////////////////
                Spacer(minLength: 20)
                Button(action:  {
                    viewModel.destinationSelected = self.destination.selection
                        self.isEditing = false
                        viewModel.convert()
                        hideKeyboard()
                })
                {
                    Text("Convertir")
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
                        .background(Image(systemName: "\(Destination.currencyImage[destination.selection])")
                                        .resizable()
                                        .frame(width: 300, height: 150, alignment: .center)
                                        .opacity(self.isEditing ? 0.8 : 0.2))
                        .foregroundColor(.appLightGrey)
                        .multilineTextAlignment(.center)
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.appGreen, lineWidth: 5))
                        .font(.system(size: 50)).foregroundColor(.black)
                ///////////////////////////////////////////////////////////////////////////////////////
                Spacer(minLength: 20)
            }
            .navigationBarTitle("Convertir mes €")
            .transition(.asymmetric(insertion: .scale, removal: .opacity)).animation(.easeInOut(duration: 1))
        }
        .onAppear(perform: { resetView()  })
        .alert(isPresented: $viewModel.showAlert) {
            Alert(title: Text("Montant incorrect"), message: Text("Veuillez saisir un montant à convertir en euros, différent de zero"),
                  dismissButton: .default(Text("OK")))
        }
    }
    func resetView() {
        viewModel.destinationSelected = self.destination.selection
        self.isEditing = false
        viewModel.output = ""
        viewModel.input = ""
    }
}
////////////////////////////////////////////////////////////////////////////////////
// MARK: - VIEW MODIFIERS
////////////////////////////////////////////////////////////////////////////////////
struct ClearButton: ViewModifier {
    @Binding var text: String
    
    public func body(content: Content) -> some View {
        ZStack(alignment: .trailing) {
            content
            if !text.isEmpty {
                Button(action: { self.text = "" })  {
                    Image(systemName: "delete.right.fill")
                        .foregroundColor(.black)
                }
                .padding(.trailing, 15)
            }
        }
    }
}
////////////////////////////////////////////////////////////////////////////////////
// MARK: - PREVIEW
////////////////////////////////////////////////////////////////////////////////////
struct CurrencyView_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyView(viewModel: CurrencyViewModel())
            .environmentObject(Destination())
    }
}




