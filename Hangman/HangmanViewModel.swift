//
//  HangmanState.swift
//  Hangman
//
//  Created by Lauren Go on 2020/09/29.
//

import Foundation

class HangmanViewModel : ObservableObject {
    
    // TODO: Add @Published properties used to control apperance of ContentView:
    // 1. Number of incorrect guesses. To be used for the hangman image, checking win/lose states, etc.
    @Published var incorrectGuesses: Int!
    // 2. Incorrect guesses. An array that stores the incorrectly guessed characters.
    @Published var incorrectGuessesArr: [Character]!
    // 3. Progress towards the phrase. A string that starts as "-" and updates with each correct guess.
    @Published var displayWord: String!
    // 4. Game status. Boolean of whether or not the game is over.
    @Published var gameOver: Bool!
    // TODO: Add variables to handle game logic:
    // 1. The phrase to be guessed by the user randomly chosen from the phrases array.
    // 2. Add phrases to the phrases array to customize your experience or just have some fun!
    let phrases: [String] = ["hello", "goodbye", "bears", "corona", "covid", "facemask", "macbook", "oski", "flower boutique", "jazz", "nail polish", "eyedrop", "screen protector", "examination"] // you can change these
    var phrase: String!
    
    /** Initializes a new game. */
    init() {
        restart()
    }
    
    /*
     Select one word from the phrases
     */
    func randomPhrase() -> String {
        let number = Int.random(in: 0...self.phrases.count-1)
        return self.phrases[number]
    }
    
    /** Resets model properties to restart game. */
    func restart() {
        // TODO: This function resets the game to its initial state. Think about what variables and @Published properties should look like when starting a new game. Here are some things to think about:
        // 1. Randomly select a new phrase from the phrases array and set the game phrase.
        // 2. Reset your progress string to reflect the initial state of this newly selected phrase.
        // 3. Reset other things to reflect the intial state like incorrect guesses, number of incorrect guesses, game status, etc.
        self.phrase = randomPhrase()
        self.displayWord = String(phrase.map{elem in
                                    if elem == " " { return " " } else { return Character("-") }})
        self.incorrectGuesses = 0
        self.incorrectGuessesArr = []
        self.gameOver = false
    }
    
    /**
     Checks if the game has reached a lose state.
     - Returns: A Boolean for if the user won or not and has guesses left.
     */
    public func didLose() -> Bool {
        // TODO: This function should check the number of incorrect guesses to determine if the user has lost the game.
        if (self.incorrectGuesses == 6) {
            return true
        }
        return false
    }
    
    /**
     Checks if the game has reached a win state.
     - Returns: A Boolean for if the user won or not and has guesses left.
     */
    public func didWin() -> Bool {
        // TODO: This function should check the number of incorrect guesses and the progress variable to determine if the user has won the game.
        if didLose() == false && self.phrase == self.displayWord {
            return true
        }
        return false
    }
    
    /**
     Processes the user's guess.
     - Parameter guess letter: Character for the letter that is being guessed.
     */
    func makeGuess(guess: Character) {
        // TODO: Update variables and parameters to reflect the user's input.
        // 1. Check that the user has not already guessed the letter.
        // 2. If the phrase contains the guessed letter, update the progress string to show that letter.
        // 3. If the phrase does not contain the guessed letter, add the letter to the incorrect guesses array and iterate the incorrect guesses count.
        
        if didLose() == false && didWin() == false && self.incorrectGuessesArr.contains(guess) == false && self.displayWord.contains(guess) == false {
            if self.phrase.contains(guess) {
                for i in 0...self.phrase.count-1 {
                    if self.phrase[self.phrase.index(self.phrase.startIndex, offsetBy:i)] == guess {
                        self.displayWord.remove(at: self.displayWord.index(self.displayWord.startIndex, offsetBy: i))
                        self.displayWord.insert(guess, at:self.displayWord.index(self.displayWord.startIndex, offsetBy: i))
                    }
                }
            } else {
                self.incorrectGuessesArr.append(guess)
                self.incorrectGuesses += 1
            }
        }
        if didLose() || didWin() {
            self.gameOver = true
        }
    }
    
    /**
     Returns a message to notify the winner if they won or not
     - Returns: Message depending on whether they won or not
     */
    public func getFinalMessage() -> String {
        // TODO: Check the game state using the didWin/didLose functions and return an appropriate string.
        if didLose() {
            return "Sorry you have lost the game."
        }
        if didWin() {
            return "Congrats! You win!"
        }
        return ""
    }
}
