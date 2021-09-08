//
//  Person.swift
//  MockApp
//
//  Created by Egor Gorskikh on 07.09.2021.
//

import Foundation

class Person {
    
    func release(_ bird: Birdble) {
        guard bird.canFly else { return }
        bird.fly()
    }
    
}
