//
//  AuthView.swift
//  notesApp
//
//  Created by Adesh Shah on 2023-11-17.
//

import SwiftUI
import Firebase

struct AuthView: View {
  @State var email = String()
  @State var password = String()
  
  var body: some View {
    VStack {
      
      // Email field
      TextField("Email", text: $email)
        .textInputAutocapitalization(.never)
        .frame(height: 30)
        .padding()
        .background(
          Capsule()
            .foregroundColor(.gray.opacity(0.2))
        )
      
      // Password field
      SecureField("Password", text: $password)
        .frame(height: 30)
        .padding()
        .background(
          Capsule()
            .foregroundColor(.gray.opacity(0.2))
        )
      
      // Buttons
      HStack() {
        Button(action: {
          login()
        }) {
          Text("Login")
        }
        .padding()
        
        Button(action: {
          signUp()
        }){
          Text("Sign Up")
        }
        .padding()
      }
    }
    .padding()
  }
  
  // Login
  func login() {
    Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
      if error != nil {
        print(error?.localizedDescription ?? "")
      } else {
        print("Login successful")
      }
    }
  }
  
  // SignUp
  func signUp(){
    Auth.auth().createUser(withEmail: email, password: password) { result, error in
      if error != nil{
        print(error?.localizedDescription ?? "")
      } else {
        print("Sign Up Successful")
      }
    }
  }
}

#Preview {
  AuthView()
}

