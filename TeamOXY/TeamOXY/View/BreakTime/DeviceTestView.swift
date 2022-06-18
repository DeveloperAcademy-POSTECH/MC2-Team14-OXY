//
//  DeviceTestView.swift
//  TestFirebase
//
//  Created by Minkyeong Ko on 2022/06/15.
//

import SwiftUI

struct DeviceTestView: View {
    
    @State var titleText = ""
    @State var bodyText = ""
    @State var deviceToken = "e-wurymUY0SzpGujs7Y1cU:APA91bHUSRs4mb-YpQ-a-MzQvUmYntk9J0b7Ppp1PyZu9dUbsPQg6vwQdAq5NMAh1NIpDhgLTN-Y70Ls_JQ_vf7DarKIJgJkdRbM0H7k-gG4uKsr5z6Yl8Ebgdll-hXYTmM196QlkUWF"
    
    var body: some View {
        NavigationView {
            
            List {
                
                Section {
                    TextField("", text: $titleText)
                } header: {
                    Text("Message Title")
                }
                
                Section {
                    TextField("", text: $bodyText)
                } header: {
                    Text("Message Body")
                }
                
                Section {
                    TextField("", text: $deviceToken)
                } header: {
                    Text("Device Token")
                }
                
                Button {
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                        sendMessageToDevice()
//                    }
                } label: {
                    Text("Send Push Notification")
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Push Notification")
        }
    }
    
    func sendMessageToDevice() {
//        guard let url = URL(string: "https://fcm.googleapis.com/fcm/send") else {
        guard let url = URL(string: "https://fcm.googleapis.com/fcm/send") else {
            return
        }
        
        let json: [String:Any] = [
            "to": deviceToken,
            "notification": [
                "title": titleText,
                "body": bodyText
            ],
            "data": [
                "user_name": "myName"
            ]
        ]
        
        let serverKey = "AAAANndUIbE:APA91bHBqe3LIWHOYbSPo-ufMGgKjm1znplyv5J_Q70LMXel9noqnHH1FtbVkHEGSFYfeqK_jgOyfsoeoNHFSL6Bb3Z3vPY6BhOs3cEDng3RXWaRLo-UNPnivkeyClkzotMoJy7N1HRc"
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject: json, options: [.prettyPrinted])
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("key=\(serverKey)", forHTTPHeaderField: "Authorization")
        
        let session = URLSession(configuration: .default)
        
        session.dataTask(with: request) { _, _, err in
            if let err = err {
                print(err.localizedDescription)
                return
            }
            
            print("Success")
            DispatchQueue.main.async { [self] in
                titleText = ""
                bodyText = ""
                deviceToken = ""
            }
        }
        .resume()
    }
}

struct DeviceTestView_Previews: PreviewProvider {
    static var previews: some View {
        DeviceTestView()
    }
}
