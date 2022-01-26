//
//  Model.swift
//  ECalculator
//
//  Created by Admin on 09.01.2022.
//

import Foundation


class Targets {
    var current: Double = 0
    var voltage: Double = 0
    var resistance: Double = 0
    var power: Double = 0
}

class Calculator {
        
    var targets = Targets()

    //Нужен будет для реализации множителей (мили, кило, Мега и т.д.)
    var scale = 1
    
    var selectionC = false
    var selectionV = false
    var selectionR = false
    
    func calculateCharacteristics() {
        // Выбран ток
        if selectionC && targets.resistance != 0 && targets.voltage != 0 {
            targets.current = targets.voltage / targets.resistance
            targets.power = targets.current * targets.voltage
        } else if selectionC && targets.resistance != 0 && targets.power != 0 {
            targets.current = sqrt(targets.power / targets.resistance)
            targets.voltage = targets.current * targets.resistance
        } else if selectionC && targets.voltage != 0 && targets.power != 0 {
            targets.current = targets.power / targets.voltage
            targets.resistance = targets.voltage / targets.current
        // Выбрано напряжение
        } else if selectionV && targets.resistance != 0 && targets.current != 0 {
            targets.voltage = targets.current * targets.resistance
            targets.power = targets.current * targets.voltage
        } else if selectionV && targets.resistance != 0 && targets.power != 0 {
            targets.voltage = targets.power / targets.resistance
            targets.current = targets.power / targets.voltage
        } else if selectionV && targets.current != 0 && targets.power != 0 {
            targets.voltage = targets.power / targets.current
            targets.resistance = targets.power / targets.current
        // Выбрано сопротивление
        } else if selectionR && targets.voltage != 0 && targets.current != 0 {
            targets.resistance = targets.voltage / targets.current
            targets.power = targets.current * targets.voltage
        } else if selectionR && targets.current != 0 && targets.power != 0 {
            targets.resistance = targets.power / pow(targets.current, 2)
            targets.voltage = targets.resistance * targets.current
        } else if selectionR && targets.voltage != 0 && targets.power != 0 {
            targets.resistance = pow(targets.current, 2) / targets.power
            targets.current = targets.voltage / targets.resistance
        }
    }
    
    
    //Нужен, потому что при изменении мощности расчет велся не корректно
    func powerHasChanged() {
        if selectionC && targets.voltage != 0 {
            targets.resistance = pow(targets.voltage, 2) / targets.power
            targets.current = targets.voltage / targets.resistance
        } else if selectionV && targets.power != 0 {
            targets.voltage = sqrt(targets.power * targets.resistance)
            targets.current = targets.voltage / targets.resistance
        } else if selectionR && targets.power != 0 {
            targets.current = targets.power / targets.voltage
            targets.resistance = targets.power / pow(targets.current, 2)
        }
    }
}

