import SwiftUI
import AVFoundation
import Alamofire



struct MICButton: View {
    @State private var isRecording = false
    @StateObject private var audioRecorderWrapper = AudioRecorderWrapper()
    
    var body: some View {
        Button(action: toggleMicrophone) {
            Image(isRecording ? "stopmicrophone" : "microphone")
                .resizable()
                .frame(width: 150, height: 150)
                .font(.largeTitle)
                .padding()
                .foregroundColor(.white)
        }
    }
    
    private func toggleMicrophone() {
        isRecording.toggle()
        if isRecording {
            audioRecorderWrapper.startRecording()
        } else {
            audioRecorderWrapper.stopRecording()
        }
    }
}

class AudioRecorderWrapper: ObservableObject {
    var audioRecorder: AVAudioRecorder?
    var audioPlayer: AVAudioPlayer?
    var audioFilename: URL?
    
    func startRecording() {
        let recordingSession = AVAudioSession.sharedInstance()
        try? recordingSession.setCategory(.playAndRecord, mode: .default)
        try? recordingSession.setActive(true)
        
        let documentPath = FileManager.default.urls(for:.documentDirectory, in: .userDomainMask)[0]
        audioFilename = documentPath.appendingPathComponent("recording.m4a")
        print(documentPath)
        print(audioFilename!)
        
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        do{
            audioRecorder = try AVAudioRecorder(url: audioFilename!, settings: settings)
            audioRecorder?.record()
        } catch{
            fatalError("error")
        }
    }
    
    func stopRecording() {
        audioRecorder?.stop()
        audioRecorder = nil
        playRecordedAudio()
        sendAudioFileToServer(audioFilename)
    }
    
    private func playRecordedAudio() {
            guard let audioFilename = audioFilename else { return }

            do {
                audioPlayer = try AVAudioPlayer(contentsOf: audioFilename)
                audioPlayer?.play()
            } catch {
                print("재생 중 오류 발생: \(error)")
            }
        }
    
    func sendAudioFileToServer(_ fileUrl: URL?) {
        guard let fileUrl = fileUrl else { return }
        
        // 서버의 엔드포인트 URL
        let uploadURL = "http://13.124.7.35:8080/api/conversation/audio/test"
        
        AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(fileUrl, withName: "audioFile", fileName: "recording.m4a", mimeType: "audio/MPEG-4")
        }, to: uploadURL)
        .response { response in
            switch response.result {
            case .success(let responseData):
                print("파일 전송 성공: \(String(describing: responseData))")
            case .failure(let error):
                print("파일 전송 실패: \(error)")
            }
        }
    }
}
/*
 struct MICButton_Previews: PreviewProvider {
 static var previews: some View {
 MICButton()
    }
 }
 
*/
