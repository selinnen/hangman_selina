//
//  ContentView.swift
//  Hangman
//
//  Created by Lauren Go on 2020/09/29.
//

import SwiftUI

struct ContentView: View {
    
    // TODO: an ObservedObject for the HangmanViewModel
    @ObservedObject var hang = HangmanViewModel()
    
    // TODO: Build the Hangman view!
    // 1. 2D array of letter values for user inputs and the keyboard.
    let alp = [["a", "b", "c", "d", "e", "f", "g"], ["h", "i", "j", "k", "l", "m", "n"], ["o", "p", "q", "r", "s", "t", "u"], ["v", "w", "x", "y", "z"]]
    var body: some View {
        VStack {
            HStack{
                //Logo for the game
                Image("hangman_logo")
                    .resizable().aspectRatio(contentMode: .fit).frame(width:160, height:100, alignment: .topLeading)
                Text("").frame(width:70)
                //Button for restarting the game
                Button (action: {hang.restart()}){
                    Text("Restart").frame(alignment:.trailing)
                }
            }
            // 2. Image that updates based on the HangmanViewModel"s incorrect guesses count.
            Image("hangman" + String(hang.incorrectGuesses)).resizable().aspectRatio(contentMode: .fit).frame(width:180, height:180, alignment: .center)
            //The current state of the game including the correct guesses you made
            Text(hang.displayWord)
                .font(.largeTitle)
                .fontWeight(.thin)
            // 3. Text that displays the incorrect guesses and updates based on the HangmanViewModel"s incorrect guesses array.
            Text("Incorrect Guesses: " + String(hang.incorrectGuessesArr))
                .font(.body)
                .multilineTextAlignment(.leading)
            //keyboard view for input
            KeyboardButtonView(hang: hang, alp:alp)
        }
        // 5. Add an alert.
        .alert(isPresented: $hang.gameOver) {
            Alert(title: Text("Game Over"), message: Text(hang.getFinalMessage()), dismissButton: .default(Text("Ok")))
        }
    }
}

// TODO: Create KeyboardButtonView struct.
// Reference the CalculatorButtonView struct we created for the calculator app in lecture demos as it ~very~ similar.
struct KeyboardButtonView: View {
    @ObservedObject var hang: HangmanViewModel
    let alp:[[String]]
    init(hang: HangmanViewModel, alp: [[String]]) {
        self.hang = hang
        self.alp = alp
    }
    var body: some View {
        VStack (spacing:10){
            HStack{
                //Using a foreach loop to loop over all the letters in the first row
                ForEach(alp[0], id: \.self) { cur in
                    Button(action: {
                        self.hang.makeGuess(guess: Character(cur))
                    }) {
                        Text(cur.uppercased())
                            .frame(width:38, height:30)
                    }
                }
            }
            
            HStack{
                //Using a foreach loop to loop over all the letters in the second row
                ForEach(alp[1], id: \.self) { cur in
                    Button(action: {
                        self.hang.makeGuess(guess: Character(cur))
                    }) {
                        Text(cur.uppercased())
                            .frame(width:38, height:30)
                    }
                }
            }
            
            HStack{
                //Using a foreach loop to loop over all the letters in the third row
                ForEach(alp[2], id: \.self) { cur in
                    Button(action: {
                        self.hang.makeGuess(guess: Character(cur))
                    }) {
                        Text(cur.uppercased())
                            .frame(width:38, height:30)
                    }
                }
            }
            
            HStack{
                //Using a foreach loop to loop over all the letters in the fourth row
                ForEach(alp[3], id: \.self) { cur in
                    Button(action: {
                        self.hang.makeGuess(guess: Character(cur))
                    }) {
                        Text(cur.uppercased())
                            .frame(width:45, height:30)
                    }
                }
            }
        }
        .frame(minWidth: 0,
               maxWidth: .infinity,
               minHeight: 0,
               maxHeight: .infinity,
               alignment: .bottom)
        .padding(.bottom, 20)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
