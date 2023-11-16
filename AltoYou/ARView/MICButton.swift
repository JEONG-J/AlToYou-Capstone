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
        audioFilename = documentPath.appendingPathComponent("recording.wav")
        print(documentPath)
        print(audioFilename!)
        
        let settings: [String: Any] = [
               AVFormatIDKey: Int(kAudioFormatLinearPCM), // WAV format
               AVSampleRateKey: 24000, // Sample rate typical for WAV files
               AVNumberOfChannelsKey: 1, // Mono audio
               AVLinearPCMBitDepthKey: 16, // Typical bit depth for WAV
               AVLinearPCMIsBigEndianKey: false, // Endianness
               AVLinearPCMIsFloatKey: false // PCM format
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
        sendAudioFileToServer(audioFilename)
    }
    
    func sendAudioFileToServer(_ fileUrl: URL?) {
        guard let fileUrl = fileUrl else { return }
        
        // 서버의 엔드포인트 URL
        let uploadURL = "http://13.124.7.35:8080/api/conversation/audio/test"
        
            AF.upload(multipartFormData: { multipartFormData in
                multipartFormData.append(fileUrl, withName: "audioFile", fileName: "recording.wav", mimeType: "audio/wav")
            }, to: uploadURL)
            .responseDecodable(of: GetVoice.self) { response in
                switch response.result {
                case .success(let getVoiceResponse):
                    playVoice(from: getVoiceResponse.url ?? "")
                case .failure(let error):
                    print("파일 전송 실패: \(error)")
                }
            }
    }
}
