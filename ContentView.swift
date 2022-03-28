//
//  ContentView.swift
//  Login
//
//  Created by Zahraa Herz on 28/03/2022.
//

import SwiftUI

struct ContentView: View {
    
    @State private var UserName: String = ""
    @State private var Password: String = ""
    @State private var showAlert : Bool   = false
    @State private var isPassValid : Bool   = false
    @State private var isEmailValid : Bool   = false
        
    @State private var activeAlert: Bool = false
    
    func signIn()
    {
        if(isEmailValid == true && isPassValid == true)
        {
            self.showAlert.toggle()
            

        }
            
    }
    
    func ValidateEmail(_ string: String) -> Bool {
        if string.count > 100 {
            return false
        }
        let emailFormat = "(?:[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}" + "~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\" + "x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[\\p{L}0-9](?:[a-" + "z0-9-]*[\\p{L}0-9])?\\.)+[\\p{L}0-9](?:[\\p{L}0-9-]*[\\p{L}0-9])?|\\[(?:(?:25[0-5" + "]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-" + "9][0-9]?|[\\p{L}0-9-]*[\\p{L}0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21" + "-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
        //let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: string)
    }
    
    func ValidatePassword(_ string: String) -> Bool {
        if string.count < 7
        {
            return false
        }
        else { return true }
    }
    
    var body: some View {
        TextField( "User name 'email address'", text: $UserName , onEditingChanged: { (isChanged) in
               if !isChanged {
                   if self.ValidateEmail(self.UserName) {
                       self.isEmailValid = true
                   } else {
                       self.isEmailValid = false
                   }
               }
           }).padding(12)
             .background(RoundedRectangle(cornerRadius: 4).stroke(self.UserName != "" ? Color("Color") : Color.black.opacity(0.2),lineWidth: 2))
            if !self.isEmailValid {
            Text("Email is Not Valid")
                .font(.callout)
                .foregroundColor(Color.red)}

        TextField( "Password", text: $Password , onEditingChanged: { (isChanged) in
            if !isChanged {
                if self.ValidatePassword(self.Password) {
                    self.isPassValid = true
                } else {
                    self.isPassValid = false
                }
            }})
            .padding(12)
            .background(RoundedRectangle(cornerRadius: 4).stroke(self.Password != "" ? Color("Color") : Color.black.opacity(0.2),lineWidth: 2))
            if !self.isPassValid {
                    Text("Password is Not Valid")
                        .font(.callout)
                        .foregroundColor(Color.red)
                }
        
        Button(
            action:
            {
                self.signIn()
                }
              , label: {
                Text("Sign In")
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .frame(height: 50)
                    .font(.system(size: 17, weight: .bold))
                    .foregroundColor(Color.white)
                    .cornerRadius(5)
                    
                                    }
        ) .background(Color.blue)
            .padding(.vertical,70)
            .alert(isPresented: $showAlert) { Alert(title: Text("Succed"), message: Text(" Login Successfully "), dismissButton: .default(Text("OK")))
                            }
            
        

            
        
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
