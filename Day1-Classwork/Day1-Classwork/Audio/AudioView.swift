//
//  AudioView.swift
//  Day1-Classwork
//
//  Created by Samuel Folledo on 4/1/21.
//

import SwiftUI
import AVKit

struct AudioView: View {
    
//    @ObservedObject var spaceViewModel: SpaceViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var audioPlayer: AVPlayer! = AVPlayer()
    @State var audioUrl: URL?
//    @Binding var showSpaceView: Bool
    
//    init(space: Space, showSpaceView: Binding<Bool>) {
//        self.spaceViewModel = SpaceViewModel(space: space)
//        self._showSpaceView = showSpaceView
//        spaceViewModel.addCurrentUserToSpace()
//        spaceViewModel.setupTrackPlayer()
//        spaceViewModel.fetchRaisedHandIds()
//        startSpaceListener()
//        spaceViewModel.startListeners()
//    }
    
    var body: some View {
        VStack{
            Text("Hello world")
            HStack(spacing: 20) {
                Button(action: playButtonTapped) {
                    Text("Play")
                }
                .padding(.bottom, 20)
                
                Button(action: leave) {
                    Text("Leave")
                }
                .padding(.bottom, 20)
            }
        }
        .edgesIgnoringSafeArea(.top)
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }
    
    func playButtonTapped() {
//        guard let _ = audioPlayer,
//              let path = Bundle.main.path(forResource: "music_boundless", ofType: "m4a")
//        else { return }
//        let url = URL(fileURLWithPath: path)
//        let item = AVPlayerItem(url: url)
//        audioPlayer.replaceCurrentItem(with: item)
        guard let audioUrl = URL(string: "https://firebasestorage.googleapis.com/v0/b/multiverse-centralverse.appspot.com/o/tracks%2Fmusic_boundless.m4a?alt=media&token=91a9a866-096e-4b5b-9eb3-f4fcb9f13bbd")
        else {
            return
        }
        let playerItem = AVPlayerItem(url: audioUrl)
        audioPlayer.replaceCurrentItem(with: playerItem)
        
        audioPlayer?.play()
    }
        
        
    func leave() {
        audioPlayer.pause()
        presentationMode.wrappedValue.dismiss()
    }
}

//struct OtherSpaceView_Previews: PreviewProvider {
//    static var previews: some View {
//        OtherSpaceView(space: DummySpaceData.getDummySpaces()[0], showMoreButton: true, showMusicButton: false, showAddFriendsButton: true, showRaiseHandButton: true, showMuteButton: true, activeSpace: true, timeInSeconds: 600)
//    }
//}
