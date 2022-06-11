//
//  TimeSetView.swift
//  TeamOXY
//
//  Created by yeekim on 2022/06/10.
//

import SwiftUI

struct TimeSetView: View {
    
    // new picker
    private let data: [[String]] = [
        Array(10...20).map{"\($0)"},
        Array(0...59).map{"\($0)"}
    ]
    
    @State private var selections: [Int] = [10, 0]
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    // PickerVeiw
                    // 커스터마이징 필요
                    PickerView(data: self.data, selections: self.$selections)
                    Text("\(self.data[0][self.selections[0]])분 \(self.data[1][self.selections[1]])초")
                    
                    VStack {
                        Spacer()
                        Button(action: {
                            print("timer start")
                        }) {
                            HStack {
                                Image("🏠")
                                Text("쉬는 시간 시작")
                            }
                            .font(.custom("Pretendard-Black", size: 16))
                            .foregroundColor(.white)
                            .frame(width: 350, height: 55)
                            .background(Color.PrimaryBlue)
                            .clipShape(Capsule())
                        }
                    }
                }
            }
            .navigationBarTitle("쉬는시간 설정", displayMode: .inline)
        }
    }
}

struct PickerView: UIViewRepresentable {
    var data: [[String]]
    @Binding var selections: [Int]
    
    func makeCoordinator() -> PickerView.Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: UIViewRepresentableContext<PickerView>) -> UIPickerView {
        let picker = UIPickerView(frame: .zero)
        
        picker.dataSource = context.coordinator
        picker.delegate = context.coordinator
        
        return picker
    }
    
    func updateUIView(_ view: UIPickerView, context: UIViewRepresentableContext<PickerView>) {
        for i in 0...(self.selections.count - 1) {
            view.selectRow(self.selections[i], inComponent: i, animated: false)
        }
    }
    
    class Coordinator: NSObject, UIPickerViewDataSource, UIPickerViewDelegate {
        var parent: PickerView
        
        init(_ pickerView: PickerView) {
            self.parent = pickerView
        }
        
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return self.parent.data.count
        }
        
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return self.parent.data[component].count
        }
        
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return self.parent.data[component][row]
        }
        
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            self.parent.selections[component] = row
        }
    }
}

struct TimeSetView_Previews: PreviewProvider {
    static var previews: some View {
        TimeSetView()
    }
}
