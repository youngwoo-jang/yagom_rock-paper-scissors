//
//  RockPaperScissors - main.swift
//  Created by yagom. 
//  Copyright © yagom academy. All rights reserved.
// 

import Foundation

enum Player {
    case computer
    case user
}

enum MatchResult {
    case computerWins
    case userWins
    case draw
}

enum Hand {
    case scissor
    case rock
    case paper
    case stop
    case none
    
    init(_ number: String) {
        switch number {
        case "0":
            self = .stop
        case "1":
            self = .scissor
        case "2":
            self = .rock
        case "3":
            self = .paper
        default:
            self = .none
        }
    }
    
    init(_ number: Int) {
        switch number {
        case 0:
            self = .stop
        case 1:
            self = .scissor
        case 2:
            self = .rock
        case 3:
            self = .paper
        default:
            self = .none
        }
    }
}

func runRockPaperScissors() {
    printGameNotice()
    
    let computersHand: Hand = generateRandomHand()
    var (usersHand, validationResult) = receiveUsersHand()
    
    while validationResult == false {
        print("잘못된 입력입니다. 다시 시도해주세요.")
        printGameNotice()
        (usersHand, validationResult) = receiveUsersHand()
    }
    
    if usersHand == .stop {
        print("게임 종료")
    } else {
        let matchResult = decideWinner(between: computersHand, and: usersHand)
        printWinner(of: matchResult)
    }
}

func printGameNotice() {
    print("가위(1), 바위(2), 보(3)! <종료 : 0>", terminator: " : ")
}

func generateRandomHand() -> Hand {
    let randomNumber: Int = Int.random(in: 1...3)
    
    return Hand(randomNumber)
}

func receiveUsersHand() -> (Hand, Bool) {
    guard let userInput = readLine() else {
        return (.none, false)
    }
    
    let validationResult = verify(userInput: userInput)
    let usersHand = Hand(userInput)
    
    return (usersHand, validationResult)
}

func convertToInteger(from userInput: String) -> Int? {
    return Int(userInput)
}

func verify(userInput: String) -> Bool {
    guard let integerUserInput = convertToInteger(from: userInput) else {
        return false
    }
    
    if integerUserInput >= 0 && integerUserInput <= 3 {
        return true
    } else {
        return false
    }
}

func decideWinner(between computersHand: Hand, and usersHand: Hand) -> MatchResult {
    if computersHand == usersHand {
        return MatchResult.draw
    }
    
    switch (computersHand, usersHand) {
    case (.rock, .scissor), (.scissor, .paper), (.paper, .rock):
        return MatchResult.computerWins
    case (.rock, .paper), (.scissor, .rock), (.paper, .scissor):
        return MatchResult.userWins
    default:
        return MatchResult.draw
    }
}

func printWinner(of matchResult: MatchResult) {
    if matchResult == MatchResult.computerWins{
        print("""
            졌습니다!
            게임 종료
            """)
    } else if matchResult == MatchResult.userWins {
        print("""
            이겼습니다!
            게임 종료
            """)
    } else {
        print("비겼습니다!")
        runRockPaperScissors()
    }
}

runRockPaperScissors()


