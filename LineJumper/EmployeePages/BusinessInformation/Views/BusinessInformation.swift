//
//  BusinessInformation.swift
//  LineJumper
//
//  Created by CoopStudent on 7/26/22.
//

import SwiftUI

struct BusinessInformation: View {
    @EnvironmentObject var viewModel: AuthViewModel;
    

    @State private var companyColor1 =
    Color(.sRGB, red: 0.98, green: 0.9, blue: 0.2);
    @State private var companyColor2 =
    Color(.sRGB, red: 0.98, green: 0.9, blue: 0.2);
    @State private var companyColor3 =
    Color(.sRGB, red: 0.98, green: 0.9, blue: 0.2);
    @State private var description: String = "type here";
    @State private var companyName = "";
    @State private var address = "";
    @State private var showImagePicker = false
    @State private var showLogoPicker  = false
    @State private var selectedImage: UIImage?
    @State private var selectedLogo: UIImage?
    @State private var companyImage: Image?
    @State private var companyLogo: Image?

    var body: some View {
        
        VStack(alignment:.leading){
            ScrollView{
                if let currentCompany = viewModel.currentCompany {
                VStack(alignment:.leading){
                    
                    Text("Business Information")
                        .font(.title2)
                        .bold()
                        .foregroundColor(Color("primaryBlue"))
                        .padding(.top)
                    
                    //image uploader
                    Button{
                        showImagePicker = true
                    }
                    label:{
                        if currentCompany.picture == nil{
                            
                            VStack(alignment:.center){
                                if let companyImage = companyImage {
                                    companyImage
                                        .resizable()
                                        .cornerRadius(20)
                                        .frame(width: 300, height: 250)
                          
                                    }
                                else {
                                        UploaderSquare(width: 300, height: 250, roundness: 20)
                                            .shadow(color: Color("primary"), radius: 2, x: 0, y: 0)
                                            .padding()
                                    }
                            }
                            
                        } else {
                            Image(currentCompany.picture ?? "https://iconape.com/wp-content/png_logo_vector/upload-5.png")
                                .resizable()
                                .frame(width: 300, height: 250)
                                .cornerRadius(20)
                                .shadow(color: Color("primary"), radius: 2, x: 0, y: 0)
                                .padding()
                        }
                    }
                    .sheet(isPresented: $showImagePicker, onDismiss: loadImage) {
                                    ImagePicker(selectedImage: $selectedImage)
                                }
                    
                    Text("Business Image")
                        .foregroundColor(Color("primaryBlue"))
                        .font(.subheadline).bold()
                    
                    VStack(spacing:10){
                        CustomInputField(image: "person", placeholder: "Company Name", text: $companyName)
                        CustomInputField(image: "mappin.and.ellipse", placeholder: "Address", text: $address)
                        
                    }.padding()
       
                    
                    //company colors
                    HStack(alignment:.center){
                        Text("Company Colours")
                            .foregroundColor(Color("primaryBlue"))
                            .font(.subheadline).bold()
                            .frame(width: 127)
                
                        ColorPicker("", selection: $companyColor1)
                        ColorPicker("", selection: $companyColor2)
                        ColorPicker("", selection: $companyColor3)
                    }.padding(.trailing, 50)
                    
                    //logo and description
                    HStack{
                        //logo uploader
                        VStack{
                            
                            // image uploader - logo
                            Button{
                                showLogoPicker = true
                            }
                            label:{
                                if currentCompany.logo == nil{
                                    
                                    VStack(alignment:.center){
                                        if let companyLogo = companyLogo {
                                            companyLogo
                                                .resizable()
                                                .cornerRadius(20)
                                                .frame(width: 100, height: 100)
                                  
                                            }
                                        else {
                                            UploaderSquare(width: 100, height: 100, roundness: 20)
                                                .shadow(color: Color("primary"), radius: 2, x: 0, y: 0)
                                                .padding()
                                            }
                                    }
                                    
                                } else {
                                    Image(currentCompany.logo ?? "https://iconape.com/wp-content/png_logo_vector/upload-5.png")
                                        .resizable()
                                        .frame(width: 100, height: 100)
                                        .cornerRadius(20)
                                        .shadow(color: Color("primary"), radius: 2, x: 0, y: 0)
                                        .padding()
                                }
                            }
                            .sheet(isPresented: $showLogoPicker, onDismiss: loadLogo) {
                                            ImagePicker(selectedImage: $selectedLogo)
                                        }
                            
                           
                            Text("Business Image")
                                .foregroundColor(Color("primaryBlue"))
                                .font(.subheadline).bold()
                        }
                        
                        //description
                        VStack{
                            ZStack{
                            TextEditor(text: $description)
                                .padding()
                                .frame(width: 150, height: 100)
               
                                RoundedRectangle(cornerRadius: 20).stroke(Color("primary"))
                                .padding()
                                .shadow(color: Color("primary"), radius: 2, x: 0, y: 0)
                                
                            }
                            Text("Business Description")
                                .foregroundColor(Color("primaryBlue"))
                                .font(.subheadline).bold()
                        }
                    }
                    
                    Button{
                        let data = [
                            "companyName" : companyName ,
                            "address" : address,
                            "description" : description,
                        ]
                        
                        viewModel.uploadPhoto(selectedImage!, logo: selectedLogo!, Data: data)
                        
                    }label: {
                        ManageButton(theText: "Save Changes", theColor: "primary").padding(.vertical)
                    }
                    
                    
                    Text("Your Managers")
                        .font(.title2)
                        .bold()
                        .foregroundColor(Color("primaryBlue"))
                        .padding(.top)
                    ScrollView(.horizontal){
                        HStack(spacing:15){
                            UploaderSquare(width: 80, height: 80, roundness: 100)
                                .clipShape(Capsule())
                                .shadow(color: Color("primary"), radius: 2, x: 0, y: 0)
                                        
                            ForEach(0 ..< 7, id: \.self){
                                _ in
                                employeeBubble()
                                    .shadow(color: Color("primaryBlue"), radius: 2, x: 0, y: 0)
                                    .padding(.vertical)
                            }
                            
                        }.padding(.horizontal)
                    }.padding(.trailing, 35)
                    
      
                }.padding(.horizontal)
                }}
            }
            
    }
    
    func loadImage(){
          guard let selectedImage = selectedImage else {return}
        companyImage = Image(uiImage: selectedImage)
      }
    
    func loadLogo(){
          guard let selectedLogo = selectedLogo else {return}
        companyLogo = Image(uiImage: selectedLogo)
      }
}

struct BusinessInformation_Previews: PreviewProvider {
    static var previews: some View {
        BusinessInformation()
    }
}
