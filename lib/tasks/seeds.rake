namespace :seed do
    task admin: :environment do
      # TODO: Multiple if needed
      Admin.create(email: "rothschild@gmail.com", password: "qqqqqq", encrypted_password: "$2a$12$PP7536sjKbxmJzBHjGDwNeCB4HNoO1BZqH1CPU.Mqx7hfUYwVlUfW", username: "welcome", name: "rothschild")
      Admin.create(email: "coffee@gmail.com", password: "qqqqqq", encrypted_password: "$2a$12$PP7536sjKbxmJzBHjGDwNeCB4HNoO1BZqH1CPU.Mqx7hfUYwVlUfW", username: "coffee", name: "Mistubishi")
    end
    
    task book: :environment do
        Book.create({name: 'Artemis Fowl1', author: 'JPJ', publisher: 'Pub1', price: 200.0, stock: 5})
        Book.create({name: 'Artemis Fowl2', author: 'JPJ1', publisher: 'Pub2', price: 200.0, stock: 2})
        Book.create({name: 'Artemis Fowl3', author: 'JPJ', publisher: 'Pub1', price: 230.5, stock: 1})
        Book.create({name: 'Artemis Fowl4', author: 'JPJ2', publisher: 'Pub4', price: 220.0, stock: 16})
        Book.create({name: 'Artemis Fowl5', author: 'JPJ', publisher: 'Pub1', price: 200.0, stock: 3})
        Book.create({name: 'Artemis Fowl6', author: 'JPJ3', publisher: 'Pub5', price: 201.15, stock: 1})
    end
  end
  