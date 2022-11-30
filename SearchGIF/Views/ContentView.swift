//
//  ContentView.swift
//  SearchGIF
//
//  Created by Viktorija on 24/11/2022.
//

import SwiftUI
import RxSwift
import RxCocoa
import SDWebImageSwiftUI

struct ContentView: View {
    
    let columns = [
        GridItem(.flexible())
    ]
    static let client = GiphyClient(requestObservable: RequestObservable(config: .default))
    
    @State var gif: GifResponse? = nil
    var disposeBag = DisposeBag()
    @State var isLoading = false
    @State var hasSearchedForSomething = false
    
    var body: some View {
        VStack {
            HStack(spacing: 5.0) {
                SearchField(action: searchGIF)
            }
            HStack(alignment: .center, spacing: 20.0) {
                ButtonStyle(value: "TRENDING", action: searchGIF)
                ButtonStyle(value: "HA-HA", action: searchGIF)
                ButtonStyle(value: "SAD", action: searchGIF)
                ButtonStyle(value: "REACTION", action: searchGIF)
            }
            .font(.caption)
            if (gif != nil && isLoading == false) {
                if (gif!.data.count == 0) {
                    WebImage(url: URL(string: ErrorGif.notFound.rawValue))
                        .resizable()
                        .scaledToFit()
                    Text("Not found")
                        .font(.system(size: 20))
                        .bold()
                        .foregroundColor(.gray)
                } else {
                    GeometryReader {    geometry in
                        ScrollView(.vertical, showsIndicators: true) {
                            LazyVGrid(columns: [
                                GridItem(.flexible()),
                            ]) {
                                ForEach(0..<gif!.data.count) { i in
                                    buildView(index: i, geometry: geometry)
                                }
                            }
                        }
                    }
                }
            }
            else if (hasSearchedForSomething) {
                ZStack {
                    Color(.systemBackground)
                        .ignoresSafeArea()
                        .opacity(0.5)
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .gray))
                        .scaleEffect(3)
                }
            }
            else {
                ZStack {
                    Text("Press any button or input search")
                        .font(.system(size: 20))
                        .bold()
                        .foregroundColor(.gray)
                }
                
            }
        }
    }
    
    
    func buildView(index: Int, geometry: GeometryProxy) -> some View {
        
        return WebImage(url: URL(string:gif!.data[index].getGifURL()))
            .resizable()
            .scaledToFit()
    }
    
    func searchGIF(searchValue: String) {
        hasSearchedForSomething = true
        gif = nil
        let client = ContentView.client
        
        do{
            try client.getGifImages(searchTerm: searchValue).subscribe(
                onNext: { result in
                    self.gif = result
                },
                onError: { error in
                    print(error.localizedDescription)
                },
                onCompleted: {
                    print("Completed event.")
                }).disposed(by: disposeBag)
        }
        catch{
            
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
