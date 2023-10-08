


// 1


class Book {
    static var uniqueIDCounterBook = 1 
    /*
     es solution internetshi vnaxe
     da ufro martivic
     tuarsebobs mainteresebs D
    */
    var bookID: Int
    var title: String
    var author: String
    var isBorrowed: Bool
    
    init(bookID: Int, title: String, author: String) {
        self.bookID = Book.uniqueIDCounterBook
        Book.uniqueIDCounterBook += 1
        self.title = title
        self.author = author
        self.isBorrowed = false
    }
    
    func borrow() {
        if isBorrowed == false {
            isBorrowed = true
        }else {
            print("it is already borrowed")
        }
    }
    
    func returned() {
        if isBorrowed == true {
            isBorrowed = false
        }else {
            print("is not borrowed")
        }
    }
}



class Owner {
    static var ownerIDCounter = 1
    
    var ownerID: Int
    var name: String
    var borrowedBooks: [Book]
    
    init(ownerID: Int, name: String) {
        self.ownerID = Owner.ownerIDCounter
        Owner.ownerIDCounter += 1
        self.name = name
        self.borrowedBooks = []
    }
    
    func borrowBook(book: Book) {
        if book.isBorrowed == false {
            book.borrow()
            borrowedBooks.append(book)
        } else {
            print("book is already borrowed")
        }
    }
    
    func returnBook(book: Book) {
        if book.isBorrowed == true {
            book.returned()
            borrowedBooks = borrowedBooks.filter { $0.bookID != book.bookID }
        } else {
            print("book is already returend")
        }
    }
}






class Library {
    var booksArr: [Book]
    var ownerArr: [Owner]
    
    init() {
        self.booksArr = []
        self.ownerArr = []
    }
    
    func addBook(book: Book) {
        booksArr.append(book)
    }
    
    func addOwner(owner: Owner) {
        ownerArr.append(owner)
    }
    
    func accesibleBooks() -> [Book] {
        return booksArr.filter{ !$0.isBorrowed }
    }
    
    func takenBooks() -> [Book] {
        return booksArr.filter { $0.isBorrowed }
    }
    
    func findOwner(ownerID: Int) -> Owner? {
        return ownerArr.first { $0.ownerID == ownerID }
    }
    
    func findBooksByOwner(owner: Owner) -> [Book] {
        return owner.borrowedBooks
    }
    
    func takeBookIfFree(book: Book, owner: Owner) {
        if !book.isBorrowed {
            owner.borrowedBooks.append(book)
        } else {
            print("book is not free to take")
        }
    }
    
}


var book1 = Book(bookID: 1, title: "didostatis marjvena", author: "konstantine gamsaxurdia")

var book2 = Book(bookID: 2, title: "The Brothers Karamazov", author: "Fyodor Dostoevsky")

var book3 = Book(bookID: 3, title: "Don Quixote", author: "Miguel de Cervantes")

var book4 = Book(bookID: 4, title: "Ivanhoe", author: "Walter Scott")

var book5 = Book(bookID: 5, title: "მზე, მთვარე და პურის ყანა", author: "თემურ ბაბლუანი")

var book6 = Book(bookID: 6, title: "Hamlet", author: "William Shakespeare")

var book7 = Book(bookID: 7, title: "Flight from the USSR", author: "David Turashvili")

var book8 = Book(bookID: 8, title: "The Big Sleep", author: "Raymond Chandler")


var owner1 = Owner(ownerID: 1, name: "Juan")

var owner2 = Owner(ownerID: 2, name: "Gega")

var owner3 = Owner(ownerID: 3, name: "Kirile")


var library = Library()

library.addBook(book: book1)
library.addBook(book: book2)
library.addBook(book: book3)
library.addBook(book: book4)
library.addBook(book: book5)
library.addBook(book: book6)
library.addBook(book: book7)
library.addBook(book: book8)

library.addOwner(owner: owner1)
library.addOwner(owner: owner2)
library.addOwner(owner: owner3)

owner1.borrowBook(book: book1)
owner1.borrowBook(book: book2)
owner1.borrowBook(book: book3)

owner2.borrowBook(book: book4)
owner2.borrowBook(book: book5)

owner3.borrowBook(book: book6)
owner3.borrowBook(book: book7)

let accessibleBooks = library.accesibleBooks()
for book in accessibleBooks {
    print(book.title)
}

let takenBooks = library.takenBooks()
for book in takenBooks {
    print("\(book.title) is taken")
}

let takenByOwner1 = library.findBooksByOwner(owner: owner1)

for book in takenByOwner1 {
    print(book.title)
}
print()


// 2


class Product {
    static var uniqueIDCounter = 1
    
    var productID: Int
    var name: String
    var price: Double
    
    init(productID: Int, name: String, price: Double) {
        self.productID = Product.uniqueIDCounter
        Product.uniqueIDCounter += 1
        self.name = name
        self.price = price
    }
}


class Cart {
    var cartID: Int
    var items: [Product]
    
    init(cartID: Int) {
        self.cartID = cartID
        self.items = []
    }
    
    func addToCart(product: Product) {
        items.append(product)
    }
    
    func removeFromCart(productID: Int) {
        items = items.filter { $0.productID != productID }
    }
    
    func countFullPrice() -> Double {
        return items.reduce(0, { $0 + $1.price })
    }
}
    


class User {
    var userID: Int
    var username: String
    var cart: Cart
    
    init(userID: Int, username: String) {
        self.userID = userID
        self.username = username
        self.cart = Cart(cartID: userID)
    }
    
    func addCartItem(product: Product) {
        cart.addToCart(product: product)
    }
    
    func removeCartItem(productID: Int) {
        cart.removeFromCart(productID: productID)
    }
    
    func checkout() -> Double {
        let total = cart.countFullPrice()
        cart.items.removeAll()
        print("total is: \(total)")
        
        return total
    }
}



let product1 = Product(productID: 1, name: "bread", price: 1.25)
let product2 = Product(productID: 2, name: "egg", price: 5)
let product3 = Product(productID: 3, name: "ricotta", price: 12.5)
let product4 = Product(productID: 4, name: "spinach", price: 10)


let user1 = User(userID: 1, username: "levaniko")
let user2 = User(userID: 2, username: "elene")

user1.addCartItem(product: product1)
user1.addCartItem(product: product2)

user2.addCartItem(product: product3)
user2.addCartItem(product: product4)


print("\(user1.username)'s cart:")
for product in user1.cart.items {
    print("\(product.name): $\(product.price)")
}
user1.checkout()

print()

print("\(user2.username)'s cart:")
for product in user2.cart.items {
    print("\(product.name): $\(product.price)")
}
user2.checkout()
