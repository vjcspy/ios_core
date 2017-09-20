//: Playground - noun: a place where people can play

import UIKit

// ------------------------------ Reference Types và Value Types ------------------------------
/*
 Tương tự như các ngôn ngữ khác thì kiểu reference là các biến dùng chung một ô nhớ, còn kiểu value là mỗi variable một ô nhớ khác nhau.
 Khi copy giá trị(hay là gán) thì kiểu value tạo ra một bản copy mới(hay là ô nhớ mới) còn kiểu reference thì chia sẽ lại ô nhớ đó
 => Là kiểu reference thì có thể có nhiều biến tham chiếu đến, còn kiểu value thì không thể, mỗi biến là 1 bản copy duy nhất.
 */

class Dog{
    var name:String = "No Name"
}

var dog1 = Dog()
var dog2 = dog1

dog1.name = "New Name"
assert(dog2.name == "New Name")

var _a1 :Int = 10
var _a2 = _a1

_a1 += 1
assert(_a1 != _a2)

//  ------------------------------ Structure and Class ------------------------------
/*
 Điểm giống nhau giữa class và structure
 - Property
 - Method
 - Initializier
 - Subscript: là câu lệnh con bên trong thuộc tính hoặc hàm
 - Extension: Là khái niệm mới trong swift để có thể mở rọng struct hoặc class sẵn có.
 */
class Employee{
    let name = "David" // property
    var salaryPerDay : Double = 200 // stored property
    
    var salaryPerWeek : Double{ // computed property
        get { // subscripts
            return self.salaryPerDay * 5
        }
    }
    
    init(salaryPerDay: Double) {
        self.salaryPerDay = salaryPerDay
    }
    
    func work() -> String { // Method
        return "I'm working"
    }
}

/*
 Điểm khác nhau:
 - Type: struct là value type còn class là reference type
 - Inheritance: struct không thể kế thừa, còn class có thể
 - Deinitializer: Struct không có hàm destructor chỉ có hàm khởi tạo(inittializier) còn class có đủ
 - Multiple reference(đa tham chiếu): chúng ta có thể có nhiều đối tượng tham chiếu đến class còn struct thì không thể vì nó là value type.
 */

// ------------------------------ Mixing value and reference types ------------------------------
// Reference Types Containing Value Type Properties
struct Address{
    var street: String
    var city: String
}

class Person{
    var name:String
    var address: Address
    
    init(name:String,address:Address) {
        self.name = name
        self.address = address
    }
}

let handico = Address(street: "Phạm Hùng", city: "Hà Nội")
var _em1 = Person(name: "Employee1", address: handico)
var _em2 = Person(name: "Employee2", address: handico)
_em1.address.city = "HCM"
assert(_em2.address.city != _em1.address.city)

// Value Types Containing Reference Types Properties
struct Bill{
    var amount:Int
    var billedTo:Person
}

var _bill1 = Bill(amount: 10, billedTo: _em1)
var _bill2 = _bill1 // Nên nhớ là vì Bill là kiểu value nên theo đó nó phải nằm trong một ô nhớ khác
_bill1.amount = 20
assert(_bill1.amount != _bill2.amount)

_bill1.billedTo.name = "_Employee1"
// Tuy nhiên khi thay đổi property reference thì nó lại làm _bill2 thay đổi theo. Cái này thực chất cũng dễ hiểu bởi vì truyền kiểu reference vào trong class để làm property và nó cũng không phải là chỉ xảy ra trên struct mà class cũng tương tự
assert(_bill2.billedTo.name == _bill1.billedTo.name)

// Có một cách để thay đổi kiểu refercen khi truyền vào( kể cả là struct hay class đểu như thế)

struct Bill2{
    var amount:Int
    var billedTo:Person
    
    init(amount:Int,billedTo:Person) {
        self.amount = amount
        self.billedTo = Person(name: billedTo.name, address: billedTo.address)
    }
}

var _bill3 = Bill2(amount: 10,billedTo:_em1)
var _bill4 = Bill2(amount:20,billedTo:_em1)

_bill3.billedTo.name  = "Bob"
assert(_bill4.billedTo.name != _bill3.billedTo.name)


