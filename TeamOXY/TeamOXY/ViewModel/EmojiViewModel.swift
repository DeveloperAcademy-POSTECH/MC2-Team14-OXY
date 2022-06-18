//
//  EmojiViewModel.swift
//  TeamOXY
//
//  Created by ParkJunHyuk on 2022/06/12.
//

import SwiftUI
import Firebase

class EmojiViewModel : ObservableObject{
    @Published var emojiCount_1 : Int
    @Published var emojiCount_2 : Int
    @Published var emojiCount_3 : Int
    @Published var emojiCount_4 : Int
    @Published var emojiCount_5 : Int
    @Published var emojiCount_6 : Int
    @Published var emojiCount_7 : Int
    @Published var emojiCount_8 : Int
    @Published var emojiCount_9 : Int
    @Published var emojiCount_10 : Int
    @Published var emojiCount_11 : Int
    @Published var emojiCount_12 : Int
    @Published var emojiCount_13 : Int
    @Published var emojiCount_14 : Int
    @Published var emojiCount_15 : Int
    
    // 로딩시 클래스 초기화로 애니메이션 작동을 막기 위해 변수 설정
    @Published var isLoading : Bool = false
    
    // FireStore에서 데이터를 받아오고 저장할 변수
    @Published var messages : [ReactionEmoji] = []
    
    private var db = Firestore.firestore()
    
    let emojis = ["🤔","👎","👍","🤩","🫠", "🔥","❤️","😱","🤭","🥱","👀","✅","🙅","🎉","😂"]
    
    // FireStore Collection, Document 이름
    let selectedCollection1 = "rooms"
    let selectedDocument1 = "익명의 호랑이 방"
    let selecetedCollection2 = "reactionEmojis"
    
    
    init() {
        self.emojiCount_1 = 0
        self.emojiCount_2 = 0
        self.emojiCount_3 = 0
        self.emojiCount_4 = 0
        self.emojiCount_5 = 0
        self.emojiCount_6 = 0
        self.emojiCount_7 = 0
        self.emojiCount_8 = 0
        self.emojiCount_9 = 0
        self.emojiCount_10 = 0
        self.emojiCount_11 = 0
        self.emojiCount_12 = 0
        self.emojiCount_13 = 0
        self.emojiCount_14 = 0
        self.emojiCount_15 = 0
        
        receiveEmojiCount()
        
        // 0.5 초의 차이를 두어 뷰가 로드 되자마자 이모지가 터지는 애니메이션을 막음
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.isLoading = true
        }
    }
    
    // Firestore Document 를 설정하기 위한 함수
    func setDocument (_ emojis : [String]) {
        
        print("setup")
        
        for emoji in emojis {
            db.collection("\(selectedCollection1)").document("\(selectedDocument1)").collection("\(selecetedCollection2)").document("\(emoji)").setData([
                "reaction_num" : emoji,
                "reaction_count" : 0 // FieldValue.increment(Int64(1))
            ]) { err in
                if let err = err {
                    print("Error writing document: \(err)")
                } else {
                    print("Document successfully written!")
                }
            }
        }
    }
    
    // Firestore 데이터 불러오기 ( 데이터가 잘들어가는지 확인 )
    func getEmojiCount() {
        
        db.collection("\(selectedCollection1)").document("\(selectedDocument1)").collection("\(selecetedCollection2)").addSnapshotListener {(querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            
            self.messages = documents.map { (QueryDocumentSnapshot) -> ReactionEmoji in
                let data = QueryDocumentSnapshot.data()
                
                // 데이터는 string 에서 any로 매핑 된다 즉 , any에서 올바른 유형으로 변환 시켜야 한다
                let reaction_num = data["reaction_num"] as? String ?? ""
                let reaction_count = data["reaction_count"] as? Int ?? 0
                
                return ReactionEmoji(reaction_num: reaction_num, reaction_count: reaction_count)
            }
        }
    }
    
    // FireStore 에 필드 값을 1씩 증가 시키기 -> 값이 변할때 애니메이션이 동작
    func update( _ emoji : String) {
        
        print("업데이트")
        
        let emojiCountUpdate = db.collection("\(selectedCollection1)").document("\(selectedDocument1)").collection("\(selecetedCollection2)").document("\(emoji)")
        
        emojiCountUpdate.updateData([
            "reaction_num" : emoji,
            "reaction_count" : FieldValue.increment(Int64(1))
        ])
        
        getEmojiCount()
    }
    
    // FireStore 에 변경사항이 있을때 자동으로 실행
    func receiveEmojiCount() {

        print("변경사항 발생")

        db.collection("\(selectedCollection1)").document("\(selectedDocument1)").collection("\(selecetedCollection2)").document("🤔")
            .addSnapshotListener { documentSnapshot, error in
              guard let document = documentSnapshot else {
                print("Error fetching document: \(error!)")
                return
              }
              guard let data = document.data() else {
                print("Document data was empty.")
                return
              }

                print("\(self.isLoading)")

                if self.isLoading {
                    let reaction_count = data["reaction_count"] as? Int ?? 0


                    self.emojiCount_1 = reaction_count
                    print("첫번째 : \(self.emojiCount_1)")
                }
            }

        db.collection("\(selectedCollection1)").document("\(selectedDocument1)").collection("\(selecetedCollection2)").document("👎")
            .addSnapshotListener { documentSnapshot, error in
              guard let document = documentSnapshot else {
                print("Error fetching document: \(error!)")
                return
              }
              guard let data = document.data() else {
                print("Document data was empty.")
                return
              }


                if self.isLoading {
                    let reaction_count = data["reaction_count"] as? Int ?? 0

                    self.emojiCount_2 = reaction_count
                    print("두번째 : \(self.emojiCount_2)")
                }
            }

        db.collection("\(selectedCollection1)").document("\(selectedDocument1)").collection("\(selecetedCollection2)").document("👍")
            .addSnapshotListener { documentSnapshot, error in
              guard let document = documentSnapshot else {
                print("Error fetching document: \(error!)")
                return
              }
              guard let data = document.data() else {
                print("Document data was empty.")
                return
              }

                if self.isLoading {
                    let reaction_count = data["reaction_count"] as? Int ?? 0

                    self.emojiCount_3 = reaction_count
                    print("세번째 : \(self.emojiCount_3)")
                }
            }

        db.collection("\(selectedCollection1)").document("\(selectedDocument1)").collection("\(selecetedCollection2)").document("🤩")
            .addSnapshotListener { documentSnapshot, error in
              guard let document = documentSnapshot else {
                print("Error fetching document: \(error!)")
                return
              }
              guard let data = document.data() else {
                print("Document data was empty.")
                return
              }

                if self.isLoading {
                    let reaction_count = data["reaction_count"] as? Int ?? 0

                    self.emojiCount_4 = reaction_count
                    print("네번째 : \(self.emojiCount_4)")
                }
            }

        db.collection("\(selectedCollection1)").document("\(selectedDocument1)").collection("\(selecetedCollection2)").document("🫠")
            .addSnapshotListener { documentSnapshot, error in
              guard let document = documentSnapshot else {
                print("Error fetching document: \(error!)")
                return
              }
              guard let data = document.data() else {
                print("Document data was empty.")
                return
              }

                if self.isLoading {
                    let reaction_count = data["reaction_count"] as? Int ?? 0

                    self.emojiCount_5 = reaction_count
                    print("다섯번째 : \(self.emojiCount_5)")
                }
            }

        db.collection("\(selectedCollection1)").document("\(selectedDocument1)").collection("\(selecetedCollection2)").document("🔥")
            .addSnapshotListener { documentSnapshot, error in
              guard let document = documentSnapshot else {
                print("Error fetching document: \(error!)")
                return
              }
              guard let data = document.data() else {
                print("Document data was empty.")
                return
              }

                if self.isLoading {
                    let reaction_count = data["reaction_count"] as? Int ?? 0

                    self.emojiCount_6 = reaction_count
                    print("여섯번째 : \(self.emojiCount_6)")
                }
            }

        db.collection("\(selectedCollection1)").document("\(selectedDocument1)").collection("\(selecetedCollection2)").document("❤️")
            .addSnapshotListener { documentSnapshot, error in
              guard let document = documentSnapshot else {
                print("Error fetching document: \(error!)")
                return
              }
              guard let data = document.data() else {
                print("Document data was empty.")
                return
              }

                if self.isLoading {
                    let reaction_count = data["reaction_count"] as? Int ?? 0

                    self.emojiCount_7 = reaction_count
                    print("일곱번째 : \(self.emojiCount_7)")
                }
            }

        db.collection("\(selectedCollection1)").document("\(selectedDocument1)").collection("\(selecetedCollection2)").document("😱")
            .addSnapshotListener { documentSnapshot, error in
              guard let document = documentSnapshot else {
                print("Error fetching document: \(error!)")
                return
              }
              guard let data = document.data() else {
                print("Document data was empty.")
                return
              }

                if self.isLoading {
                    let reaction_count = data["reaction_count"] as? Int ?? 0

                    self.emojiCount_8 = reaction_count
                    print("여덟번째 : \(self.emojiCount_8)")
                }
            }

        db.collection("\(selectedCollection1)").document("\(selectedDocument1)").collection("\(selecetedCollection2)").document("🤭")
            .addSnapshotListener { documentSnapshot, error in
              guard let document = documentSnapshot else {
                print("Error fetching document: \(error!)")
                return
              }
              guard let data = document.data() else {
                print("Document data was empty.")
                return
              }

                if self.isLoading {
                    let reaction_count = data["reaction_count"] as? Int ?? 0

                    self.emojiCount_9 = reaction_count
                    print("아홉번째 : \(self.emojiCount_9)")
                }
            }

        db.collection("\(selectedCollection1)").document("\(selectedDocument1)").collection("\(selecetedCollection2)").document("🥱")
            .addSnapshotListener { documentSnapshot, error in
              guard let document = documentSnapshot else {
                print("Error fetching document: \(error!)")
                return
              }
              guard let data = document.data() else {
                print("Document data was empty.")
                return
              }

                if self.isLoading {
                    let reaction_count = data["reaction_count"] as? Int ?? 0

                    self.emojiCount_10 = reaction_count
                    print("열번째 : \(self.emojiCount_10)")
                }
            }

        db.collection("\(selectedCollection1)").document("\(selectedDocument1)").collection("\(selecetedCollection2)").document("👀")
            .addSnapshotListener { documentSnapshot, error in
              guard let document = documentSnapshot else {
                print("Error fetching document: \(error!)")
                return
              }
              guard let data = document.data() else {
                print("Document data was empty.")
                return
              }

                if self.isLoading {
                    let reaction_count = data["reaction_count"] as? Int ?? 0

                    self.emojiCount_11 = reaction_count
                    print("열한번째 : \(self.emojiCount_11)")
                }
            }

        db.collection("\(selectedCollection1)").document("\(selectedDocument1)").collection("\(selecetedCollection2)").document("✅")
            .addSnapshotListener { documentSnapshot, error in
              guard let document = documentSnapshot else {
                print("Error fetching document: \(error!)")
                return
              }
              guard let data = document.data() else {
                print("Document data was empty.")
                return
              }

                if self.isLoading {
                    let reaction_count = data["reaction_count"] as? Int ?? 0

                    self.emojiCount_12 = reaction_count
                    print("열두번째 : \(self.emojiCount_12)")
                }
            }

        db.collection("\(selectedCollection1)").document("\(selectedDocument1)").collection("\(selecetedCollection2)").document("🙅")
            .addSnapshotListener { documentSnapshot, error in
              guard let document = documentSnapshot else {
                print("Error fetching document: \(error!)")
                return
              }
              guard let data = document.data() else {
                print("Document data was empty.")
                return
              }

                if self.isLoading {
                    let reaction_count = data["reaction_count"] as? Int ?? 0

                    self.emojiCount_13 = reaction_count
                    print("열세번째 : \(self.emojiCount_13)")
                }
            }

        db.collection("\(selectedCollection1)").document("\(selectedDocument1)").collection("\(selecetedCollection2)").document("🎉")
            .addSnapshotListener { documentSnapshot, error in
              guard let document = documentSnapshot else {
                print("Error fetching document: \(error!)")
                return
              }
              guard let data = document.data() else {
                print("Document data was empty.")
                return
              }

                if self.isLoading {
                    let reaction_count = data["reaction_count"] as? Int ?? 0

                    self.emojiCount_14 = reaction_count
                    print("열네번째 : \(self.emojiCount_14)")
                }
            }

        db.collection("\(selectedCollection1)").document("\(selectedDocument1)").collection("\(selecetedCollection2)").document("😂")
            .addSnapshotListener { documentSnapshot, error in
              guard let document = documentSnapshot else {
                print("Error fetching document: \(error!)")
                return
              }
              guard let data = document.data() else {
                print("Document data was empty.")
                return
              }

                if self.isLoading {
                    let reaction_count = data["reaction_count"] as? Int ?? 0

                    self.emojiCount_15 = reaction_count
                    print("열다섯번째 : \(self.emojiCount_15)")
                }
            }
    }
}
