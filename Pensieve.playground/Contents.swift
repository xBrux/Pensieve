import Pensieve

let db = try! Connection()


let users = Table("users")

let id = Expression<Int64>("id")
let email = Expression<String>("email")
let name = Expression<String?>("name")

try! db.run(users.create { t in
    t.column(id, primaryKey: true)
    t.column(email, unique: true, check: email.like("%@%"))
    t.column(name)
})

let a = users.exists
try? db.scalar(users.exists)

let rowid = try! db.run(users.insert(email <- "alice@mac.com"))
let alice = users.filter(id == rowid)

//for user in db.prepare(users) {
//    print("id: \(user[id]), email: \(user[email])")
//}

let emails = VirtualTable("emails")

let subject = Expression<String?>("subject")
let body = Expression<String?>("body")

try! db.run(emails.create(.FTS4(subject, body)))

try! db.run(emails.insert(
    subject <- "Hello, world!",
    body <- "This is a hello world message."
))

//let row = db.pluck(emails.match("hello"))
//
//let query = db.prepare(emails.match("hello"))
//for row in query {
//    print(row[subject])
//}
