//
//  TimeSetView.swift
//  TeamOXY
//
//  Created by yeekim on 2022/06/10.
//

import SwiftUI


struct TimeSetView: View {
    
    // time picker
    private let data: [[String]] = [
        Array(5...30).map{"\($0)"},
        Array(0...59).map{"\($0)"}
    ]
    
    //기본 쉬는 시간 : 10분
    @State private var selections: [Int] = [5, 0]
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    Text("쉬는 시간을 설정해주세요.")
                        .foregroundColor(.DarkGray1)
                        .font(.custom("Pretendard-ExtraBold", size: 18))
                        .offset(y:-230)
                    
                    ZStack {
                        // blue box
                        RoundedRectangle(cornerRadius: 25)
                                        .frame(width: UIScreen.main.bounds.size.width-75, height: 35)
                                        .foregroundColor (.PrimaryBlue)
                        Text("          분                               초")
                        
                        // PickerVeiw
                        PickerView(data: self.data, selections: self.$selections)
                            .frame(width:200)
                            .pickerStyle(WheelPickerStyle())
                    }
                    
                    VStack {
                        Spacer()
                        NavigationLink(destination: BreakTimeView(counter: 0, countTo: (Int(data[0][selections[0]]) ?? 10) * 60 + (Int(data[1][selections[1]]) ?? 0))) {
                            StartTimerButton()
                        }
                    }
                }
            }
            .navigationBarTitle("쉬는시간 설정", displayMode: .inline)
        }
    }
}

struct StartTimerButton: View {
    var body: some View {
        HStack {
            Image("🏡")
            Text("쉬는 시간 시작")
        }
        .font(.custom("Pretendard-Black", size: 16))
        .foregroundColor(.white)
        .frame(width: 350, height: 55)
        .background(Color.PrimaryBlue)
        .clipShape(Capsule())
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
