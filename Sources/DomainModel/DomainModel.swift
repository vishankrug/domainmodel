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
    
    let title: String
    let type: JobType

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
    
    func raise(byAmount he: Int) -> Int {
        switch self.type {
        case .Hourly(let wage):
            var ans = wage+Double(he)
            ans.round()
            return Int(ans)
        case .Salary(let salary):
            return Int(Int(salary)+he)
        }
    }
    func raise(byAmount he: Double) -> Int {
        switch self.type {
        case .Hourly(let wage):
            var ans = wage+(he)
            ans.round()
            return Int(ans)
        case .Salary(let salary):
            return Int(Double(salary)+he)
        }
    }
    func raise(byPercent he: Double) -> Int {
        switch self.type {
        case .Hourly(let wage):
            var ans = (wage*(he+1.0))
            ans.round()
            return Int(ans)
        case .Salary(let salary):
            return Int(Double(salary)*(he+1.0))
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
        let ans = "[Person: firstName:\(self.firstName) lastName:\(self.lastName) age:\(self.age) job:\(self.job) spouse:\(self.spouse)]"
        return ans
    }
}

////////////////////////////////////
// Family
//
public class Family {
    let members: {
        spouse1: Person,
        spouse2: Person
    }
    
}
