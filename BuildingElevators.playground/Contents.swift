//: Playground - noun: a place where people can play

import UIKit

enum ElevatorStatus {
    case up
    case down
    case idle
}

class Elevator {
    let name: String
    let capacity: Int
    let maxFloor: Int
    let minFloor: Int
    var isFulload: Bool
    var status: ElevatorStatus?
    var currentFloor: Int
    var remainCapacity: Int
    
    init(name: String, capacity: Int, minFloor: Int, maxFloor: Int) {
        self.name = name
        self.capacity = capacity
        self.remainCapacity = capacity
        self.minFloor = minFloor
        self.maxFloor = maxFloor
        self.status = .idle
        self.currentFloor = 0
        self.isFulload = false
    }
    
    func shouldGo(to floor: Int) -> Bool {
        if (isFulload || floor > maxFloor || floor < minFloor || currentFloor == floor) {
            return false
        }
        return true
    }
    
    func canCheckIn(amount: Int) -> Bool {
        return remainCapacity - amount > 0
    }
    
    func go(to floor: Int) {
        if currentFloor < floor {
            status = .up
        }
        else if currentFloor > floor {
            status = .down
        }
        else {
            status = .idle
        }
        currentFloor = floor
    }
    
    func checkOut(amount: Int) {
        remainCapacity += amount
        
        if remainCapacity > capacity {
            remainCapacity = capacity
        }
        
        if remainCapacity == capacity {
            status = .idle
        }
    }
    
    func checkIn(amount: Int) {
        remainCapacity -= amount
    }
}

class Building {
    let elevators:[Elevator] = [Elevator(name: "1", capacity: 10, minFloor: 0, maxFloor: 15), Elevator(name: "2", capacity: 10, minFloor: 0, maxFloor: 15), Elevator(name: "3", capacity: 15, minFloor: 0, maxFloor: 15), Elevator(name: "4", capacity: 15, minFloor: 0, maxFloor: 15)]
    
    func getAvailableElevator() -> Elevator {
        return Elevator(name: "1", capacity: 10, minFloor: 0, maxFloor: 15)
    }
}