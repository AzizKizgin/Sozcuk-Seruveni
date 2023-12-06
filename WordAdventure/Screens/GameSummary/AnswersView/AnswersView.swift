//
//  AnswersView.swift
//  WordAdventure
//
//  Created by Aziz Kızgın on 2.12.2023.
//

import SwiftUI

struct AnswersView: View {
    let questions: [Question]
    @State var expandedItem: String = ""
    var body: some View {
        ScrollView{
            ForEach(letters, id: \.self){ letter in
                let item = questions.first(where: {
                    $0.letter == letter
                }) ?? Question(
                    letter: "",
                    meaning: "",
                    word: ""
                )
                VStack{
                    Button(action: {onItemPress(itemLetter: letter)}, label: {
                        HStack{
                            getIcon(answerState: item.answerState)
                            Text(item.word)
                            Spacer()
                            Text(item.letter.localizedUppercased())
                            Image(systemName: "chevron.down")
                        }
                        .fontWeight(.bold)
                        .foregroundStyle(.accent)
                        .contentShape(Rectangle())
                        .padding(5)
                    })
                    .buttonStyle(.plain)
                }
                if expandedItem == letter {
                    VStack(alignment:.leading,spacing:15){
                        HStack(alignment: .top){
                            Text("Soru:")
                                .bold()
                            Text(item.meaning)
                        }
                        HStack(alignment: .top){
                            Text("Doğru Cevap:")
                                .bold()
                            Text(item.word)
                        }
                        HStack(alignment: .top){
                            Text("Cevabın:")
                                .bold()
                            Text(item.userAnswer)
                                .foregroundStyle(getColor(answerState: item.answerState))
                        }
                    }
                    .padding(.horizontal)
                    .frame(maxWidth:.infinity, alignment: .leading)
                }
            }
            .padding()
        }
    }
}

extension AnswersView{
    func getIcon(answerState: Int) -> some View{
        var image = "arrowshape.forward.circle.fill"
        var color: Color = .yellow
        switch answerState{
        case AnswerState.isCorrect:
            image = "checkmark.circle.fill"
            color = .green
        case AnswerState.isWrong:
            image = "multiply.circle.fill"
            color = .red
        case AnswerState.isPassed:
            image = "arrowshape.forward.circle.fill"
            color = .yellow
        case AnswerState.none:
            image = "arrowshape.forward.circle.fill"
            color = .yellow
        default:
            image = "arrowshape.forward.circle.fill"
            color = .yellow
        }
        return Image(systemName: image)
            .font(.title)
            .foregroundStyle(color)
    }
    
    func getColor(answerState: Int) -> Color{
        switch answerState{
        case AnswerState.isCorrect:
            return .green
        case AnswerState.isWrong:
            return .red
        case AnswerState.isPassed:
            return .yellow
        case AnswerState.none:
            return .black
        default:
            return .yellow
        }
    }
    
    func onItemPress(itemLetter: String){
        withAnimation{
            if expandedItem == itemLetter{
                expandedItem = ""
            }
            else {
                expandedItem = itemLetter
            }
        }
    }
}

#Preview {
    NavigationStack{
        AnswersView(questions: fakeDataWithAnswer)
    }
}
