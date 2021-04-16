struct DomainModel {
    var text = "Hello, World!"
        // Leave this here; this value is also tested in the tests,
        // and serves to make sure that everything is working correctly
        // in the testing harness and framework.
}

////////////////////////////////////
// Money
//
public struct Money{
    let amount: Int
    let currency: String
    
    /*
    static let BRITISH_POUNDS = "GBP"
    static let EURO = "EUR"
    static let CANADIAN_DOLLARS = "CAN"
    static let US_DOLLARS = "USD"
     */

    init(amount am: Int, currency curr: String){
        self.amount = am
        self.currency = curr
    }
    
    func convert(_ new_currency: String) -> Money {
        var new_amount = 0.0
        let cur_amount = Double(amount)
        if(currency == new_currency){
            return Money(amount: amount, currency: currency)
        }else if(new_currency == "GBP"){
            if(currency == "USD"){
                new_amount = cur_amount*(0.5/1)
            } else if (currency == "EUR"){
                new_amount = cur_amount*(0.5/1.5)
            } else if (currency == "CAN"){
                new_amount = cur_amount*(0.5/1.25)
            }
        } else if(new_currency == "USD"){
            if(currency == "GBP"){
                new_amount = cur_amount*(1/0.5)
            } else if (currency == "EUR"){
                new_amount = cur_amount*(1/1.5)
            } else if (currency == "CAN"){
                new_amount = cur_amount*(1/1.25)
            }
        }else if(new_currency == "EUR"){
            if(currency == "GBP"){
                new_amount = cur_amount*(1.5/0.5)
            } else if (currency == "USD"){
                new_amount = cur_amount*(1.5/1)
            } else if (currency == "CAN"){
                new_amount = cur_amount*(1.5/1.25)
            }
        }else if(new_currency == "CAN"){
            if(currency == "GBP"){
                new_amount = cur_amount*(1.25/0.5)
            } else if (currency == "EUR"){
                new_amount = cur_amount*(1.25/1.5)
            } else if (currency == "USD"){
                new_amount = cur_amount*(1.25/1)
            }
        }
        new_amount.round()
        return Money(amount: Int(new_amount), currency:new_currency)
    }
    
    func add(_ money2: Money) -> Money{
        if(self.currency == money2.currency){
            return Money(amount: self.amount+money2.amount, currency:self.currency)
        } else{
            return Money(amount: (money2.convert(self.currency)).amount+money2.amount, currency:money2.currency)
        }
    }
    
    func subtract(_ money2: Money) -> Money{
        if(self.currency == money2.currency){
            return Money(amount: self.amount-money2.amount, currency:self.currency)
        } else{
            
            return Money(amount: money2.amount-(money2.convert(self.currency)).amount, currency:money2.currency)
        }
    }
}

////////////////////////////////////
// Job
//
public class Job {
    public enum JobType {
        case Hourly(Double)
        case Salary(UInt)
    }
    
    var title: String
    var type: JobType

    init(title ti: String, type ty: JobType){
        self.title = ti
        self.type = ty
    }
    
    func calculateIncome(_ hours: Int) -> Int{
        switch self.type {
        case .Hourly(let wage):
            var ans = wage*Double(hours)
            ans.round()
            return Int(ans)
        case .Salary(let salary):
            return Int(salary)
        }
    }
    
    func raise(byAmount amount: Double){
        switch self.type {
        case .Hourly(let wage):
            self.type = JobType.Hourly(wage+amount)
        case .Salary(let salary):
            self.type = JobType.Salary(UInt(Double(salary) + amount))
        }
    }

    func raise(byPercent amount: Double){
        switch self.type {
        case .Hourly(let wage):
            var ans = wage + (wage*(amount))
            ans.round()
            self.type = JobType.Hourly(ans)
        case .Salary(let salary):
            let ans = Double(salary) + Double(salary)*amount
            self.type = JobType.Salary(UInt(ans))
        }
    }
}

////////////////////////////////////
// Person
//
public class Person {
    let firstName: String
    let lastName: String
    let age: Int
    var job: Job? = nil {
        didSet{
            if (age <= 16){
                job = nil
            }
        }
    }
    var spouse: Person? = nil
    
    init(firstName f: String, lastName l: String, age a: Int){
        self.firstName = f
        self.lastName = l
        self.age = a
    }
    
    func toString() -> String{
        let ans = "[Person: firstName:\(self.firstName) lastName:\(self.lastName) age:\(self.age) job:\(String(describing: self.job)) spouse:\(String(describing: self.spouse))]"
        return ans
    }
}

////////////////////////////////////
// Family
//
public class Family {
    var members: [Person]
    
    init(spouse1: Person, spouse2: Person){
        if((spouse1.spouse != nil) || (spouse2.spouse != nil)){
            self.members = []
        }
        spouse1.spouse = spouse2
        spouse2.spouse = spouse1
        self.members = [spouse1, spouse2]
    }
    
    func haveChild(_ child: Person) -> Bool{
        if (self.members[0].age < 21 && self.members[1].age < 21){
            return false
        }
        self.members.append(child)
        return true
    }
    
    func householdIncome() -> Int {
        var sum = 0
        for member in members {
            if (member.job != nil){
                sum = sum + member.job!.calculateIncome(2000)
            }
        }
        return sum
    }
    
}
