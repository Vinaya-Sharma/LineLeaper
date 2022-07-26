//
//  ContentView.swift
//  LineJumper
//
//  Created by CoopStudent on 7/23/22.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var SideMenuBar = false

    var body: some View {
    
            VStack{
                if viewModel.userSession == nil {
                    LoginView()
                } else {
            
                    ZStack(alignment:.topLeading){
                        VStack{
                            if let isCustomer = viewModel.currentUser?.isCustomer{
                            HStack{
                                Button {
                                    if isCustomer == "true" {
                                        viewModel.signOut()
                                    } else {
                                        SideMenuBar.toggle()
                                    }
                                } label: {
                                    Image(systemName: isCustomer == "true" ? "arrow.left" : "line.3.horizontal")
                                        .padding(12)
                                        .background(.white)
                                        .foregroundColor(.black)
                                        .cornerRadius(20)
                                        .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color("secondaryBlue").opacity(0.05), lineWidth: 1))
                                        .shadow(color: .gray.opacity(0.2), radius: 3, x: -3, y: 2)
                                }
                                Spacer()
                                
                                Text("67 Skyvalley Dr.")
                                    .foregroundColor(Color("primary"))
                                
                                Spacer()
                                Button {
                                    print("clicking on img")
                                } label: {
                                    Image("profilePic")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 40, height: 40)
                                        .clipShape(RoundedRectangle(cornerRadius:20))
                                        .shadow(color: .gray.opacity(0.2), radius: 3, x: -3, y: 2)
                                }
                            }.padding(.horizontal)
                            }
                            MainTabsView()
                        }
               
                        if SideMenuBar{
                            Color(.black)
                                .opacity(0.25).ignoresSafeArea()
                                .onTapGesture {
                                                    withAnimation(.easeInOut)
                                                    {
                                                        SideMenuBar = false
                                                    }
                                                }.ignoresSafeArea()
                        }
                        
                        SideMenuView()
                                     .frame(width: 300)
                                     .offset(x: SideMenuBar ? 0 : -300, y: 0)
                                     .background(SideMenuBar ? Color.white : Color.clear)
                      }.onAppear{
                          SideMenuBar = false
                }
            }
            }
        }
}
        
    


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(AuthViewModel())
    }
}
