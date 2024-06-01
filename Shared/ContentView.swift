//
//  ContentView.swift
//  Shared
//
//  Created by Om Gautam on 8/10/22.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        NavigationView{
            
            HomeScreen()
//            BannerAd(unitID: "ca-app-pub-3519678393719526/8483613499")
            
        }
    }
}

struct HomeScreen: View {
    
    var body:some View{
        ZStack{
            Image("background")
                .ignoresSafeArea()
            
            VStack{
    
                Image("animanga_logo")
                    .resizable()
                    .frame(width: 250,
                           height: 250,
                           alignment: .center)
                    .aspectRatio(contentMode: .fit)
                    
                Text("Pick an Anime to Convert:")
                    .font(.system(size: 25,
                                  weight: .regular,
                                  design: .default))
                    .foregroundColor(Color.white)
                    .padding()
                
                // Use Navigation link with destination and label; press enter
                
                // One Piece Navigation Link
                NavigationLink {
                    
                    // Destination
                    ConversionScreen(csvFileName: "onepiece_data",
                                     titleText: "One Piece Converter",
                                     color: Color(hue: 0.492, saturation: 0.806, brightness: 0.771)
                                    )
                    
                } label: {

                    ContinueButton(color: Color(hue: 0.492, saturation: 0.806, brightness: 0.771), text: "One Piece")
                    
                }
                
                // Bleach Navigation Link
                NavigationLink {
                    
                    // Destination
                    ConversionScreen(csvFileName: "bleach_data",
                                     titleText: "Bleach Converter",
                                     color: .purple
                                    )
                    
                } label: {
                    
                    ContinueButton(color: .purple, text: "Bleach")
                    
                }
                
                // Naruto Navigation Link
                NavigationLink {
                    
                    // Destination
                    ConversionScreen(csvFileName: "naruto_data",
                                     titleText: "Naruto Converter",
                                     color: Color(hue: 0.492, saturation: 0.806, brightness: 0.771)
                                    )
                    
                } label: {
                    
                    ContinueButton(color: Color(hue: 0.492, saturation: 0.806, brightness: 0.771), text: "Naruto")

                }
                
                // Naruto Shippuden Navigation Link
                NavigationLink {
                    
                    // Destination
                    ConversionScreen(csvFileName: "narutoshippuden_data",
                                     titleText: "Naruto Shippuden Converter",
                                     color: .purple
                                    )
                    
                } label: {
                    
                    ContinueButton(color: .purple, text: "Naruto Shippuden")
                    
                }
                
                // Ad unit ID goes here
                
                
            }
            
            
            // Give title outside of VStack, but in NavigationView
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal){
                    Text("Animanga Converter")
                        .font(.system(size: 30,
                                      weight: .bold,
                                      design: .default))
                        .foregroundColor(Color.white)
                }
            }
        }
        
    }
}

struct ConversionScreen: View {
        
    let csvFileName: String
    let titleText: String
    let color: Color
    
    @State var input: String = ""
    @State var conversionToggle = true
    @State var splitMangaChapters = ""
    
    var body: some View {
        
        let data = Anime.loadCSV(from: csvFileName)

        // If Statement to determine toggle conversion setting
        if conversionToggle{
            VStack{
                Text(titleText)
                    .font(.system(size: 30,
                                  weight: .semibold,
                                  design: .default))
                    .foregroundColor(Color.black)
                
                Spacer()
                
                Text("Enter Anime Episode:")
                    .font(.system(size: 22,
                                  weight: .regular,
                                  design: .default))
                    .foregroundColor(Color.black)
                
                TextField("", text: $input)
                    .border(.black)
                    .textFieldStyle(.plain)
                    
                                
                Text("Manga Chapter:")
                    .font(.system(size: 22,
                                  weight: .regular,
                                  design: .default))
                    .foregroundColor(Color.black)
                    .padding(.top,30)
                    .padding(.bottom,5)
                
                // Code to convert Anime Episode to Manga Chapter
                ForEach(data) { value in
                    if(value.animeEpisode == input){
                        Text(value.mangaChapter)
                            .font(.system(size: 20,
                                          weight: .light,
                                          design: .default))
                            .foregroundColor(Color.black)
                    }
                }
                
                Spacer()
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(color)
            
        }
        else{
            
            // Code for Manga to Anime Conversion
            
            VStack{
                Text(titleText)
                    .font(.system(size: 30,
                                  weight: .semibold,
                                  design: .default))
                    .foregroundColor(Color.black)
                
                Spacer()
                
                Text("Enter Manga Chapter:")
                    .font(.system(size: 22,
                                  weight: .regular,
                                  design: .default))
                    .foregroundColor(Color.black)
                
                TextField("", text: $input)
                    .border(.black)
                    .textFieldStyle(.plain)
                
                
                Text("Anime Episode:")
                    .font(.system(size: 22,
                                  weight: .regular,
                                  design: .default))
                    .foregroundColor(Color.black)
                    .padding(.top,30)
                    .padding(.bottom,5)
                
                
//                var data2 = splitManga()
//                ForEach(data2){ value in
//                    if(value == input){
//                        Text(data.animeEpisode)
//                            .font(.system(size: 20,
//                                          weight: .light,
//                                          design: .default))
//                            .foregroundColor(Color.black)
//                    }
                
                ForEach(data) { value in
                    if(value.mangaChapter == input){
                        Text(value.animeEpisode)
                            .font(.system(size: 20,
                                          weight: .light,
                                          design: .default))
                            .foregroundColor(Color.black)
                    }
                }
                        
                Spacer()
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(color)
            
        }
        
        Toggle("Click Toggle to Switch between Anime and Manga Conversions",
               isOn: $conversionToggle)
        .background(Color(hue: 0.492, saturation: 0.076, brightness: 0.334))
        .tint(color)
        .font(.system(size: 20,
                          weight: .regular,
                          design: .default))
                .foregroundColor(Color.white)
        
    }
}



// Code to make Buttons
struct ContinueButton: View {
    
    let color: Color
    let text: String
    
    var body: some View{
        Text(text)
            .frame(width: 200,
                   height: 50,
                   alignment: .center)
            .background(color)
            .foregroundColor(.white)
            .cornerRadius(8)
            .padding()
            .font(.system(size:18))
    };
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



