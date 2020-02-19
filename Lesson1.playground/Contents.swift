import UIKit

/*
 4. В чем отличие класса от протокола?

 Ответ:
 Протокол задает структуру объекта, без конкретной реализации полей, свойств и функций. Класс же обязан предоставить реализацию всего перечисленного.
 */

/*
 5. Могут ли реализовывать несколько протоколов:

     a. классы (Class)

     b. структуры (Struct)

     c. перечисления (Enum)

     d. кортежи (Tuples)

 Ответ:
 Классы, структуры и перечисления могут, кортежи в принципе не могут реализовывать протоколы
 */

/*
 6.A Создайте протоколы для игры в шахматы против компьютера: протокол-делегат с функцией, через которую шахматный движок будет сообщать о ходе компьютера (с какой на какую клеточку); протокол для шахматного движка, в который передается ход фигуры игрока (с какой на какую клеточку), Double свойство, возвращающая текущую оценку позиции (без возможности изменения этого свойства) и свойство делегата;
 */

class Cell {
}

class GameField {
    var field: [[Cell]]

    init(rowCount rows: Int, columnCount columns: Int) {
        var gameField: [[Cell]] = []
        for _ in 0..<rows {
            var row: [Cell] = []
            for _ in 0..<columns {
                row.append(Cell())
            }
            gameField.append(row)
        }

        self.field = gameField
    }
}

protocol Moveble {
    func move(from: Cell, to: Cell)
}

protocol AIDelegate: Moveble {
}

protocol PlayerDelegate: Moveble {
    var currentPosition: Double { get }
    var delegate: Any? { get set } // не особо понял, что какой именно тип надо обязать реализовывать в протоколе игрока
}

/*
 6.B Создайте протоколы для компьютерной игры: один протокол для всех, кто может летать (Flyable), второй – для тех, кого можно отрисовывать приложении (Drawable).
 Напишите класс, который реализует эти два протокола
 */

protocol Flyable {
    func fly()
}

class Map {
    func draw(obj: Drawable) {
        print("\(obj) draw")
    }
}

protocol Drawable {
    func draw(in map: Map)
}

class Dragon: Flyable, Drawable {
    func fly() {
        print("Dragon on air")
    }

    func draw(in map: Map) {
        map.draw(obj: self)
    }
}

/*
 7.A Создайте расширение с функцией для CGRect, которая возвращает CGPoint с центром этого CGRect’а
 */

extension CGRect {
    func center() -> CGPoint {
        return CGPoint(x: self.midX, y: self.midY)
    }
}

/*
 7.B Создайте расширение с функцией для CGRect, которая возвращает площадь этого CGRect’а
 */

extension CGRect {
    func square() -> CGFloat {
        return self.width * self.height
    }
}

/*
 7.C Создайте расширение с функцией для UIView, которое анимированно её скрывает (делает alpha = 0)
 */

extension UIView {
    func hiddenAnimate(seconds speed: TimeInterval) {
        UIView.animate(withDuration: speed) {
            self.alpha = 0
        }
    }
}

/*
 7.D Создайте расширение с функцией для протокола Comparable, на вход получает еще два параметра того же типа: первое ограничивает минимальное значение, второе – максимальное; возвращает текущее значение. ограниченное этими двумя параметрами. Пример использования:

 7.bound(minValue: 10, maxValue: 21) -> 10

 7.bound(minValue: 3, maxValue: 6) -> 6

 7.bound(minValue: 3, maxValue: 10) -> 7
 */

extension Comparable {
    func bound<T: Comparable>(minValue: T, maxValue: T) -> T {
        guard let value = self as? T else {
            fatalError("It's not Comparable")
        }
        if value < minValue {
            return minValue
        }
        if value > maxValue {
            return maxValue
        }
        return value
    }
}

7.bound(minValue: 10, maxValue: 21)

7.bound(minValue: 3, maxValue: 6)

7.bound(minValue: 3, maxValue: 10)

/*
 7.E Создайте расширение с функцией для Array, который содержит элементы типа Int: функцию для подсчета суммы всех элементов
 */

extension Array where Element == Int {
    func sumElements() -> Int {
        return self.reduce(0, { $0 + $1 })
    }
}

[1, 2, 3].sumElements()

/*
 8. В чем основная идея Protocol oriented programming?

 Основная идея протокол-ориентированного программирования в разделении всего функционала объектов на атомарные протоколы, и сбор классов, структур и перечисленний посредством реализации этих протоколов
 */
