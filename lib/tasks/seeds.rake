namespace :seed do
  task admin: :environment do
    # TODO: Multiple if needed
    Admin.create(email: "chocolate@gmail.com", password: "qqqqqq", encrypted_password: "$2a$12$PP7536sjKbxmJzBHjGDwNeCB4HNoO1BZqH1CPU.Mqx7hfUYwVlUfW", username: "chocolate", name: "chocolate")
    Admin.create(email: "coffee@gmail.com", password: "qqqqqq", encrypted_password: "$2a$12$PP7536sjKbxmJzBHjGDwNeCB4HNoO1BZqH1CPU.Mqx7hfUYwVlUfW", username: "coffee", name: "coffee")
  end
  
  task book: :environment do
      Book.create({name: 'Artemis Fowl', author: 'Eoin Colfer', publisher: 'Pub1', price: 150.0, stock: 45})
      Book.create({name: 'Mocha', author: 'Barista', publisher: 'Pub2', price: 200.0, stock: 20})
      Book.create({name: 'Leather', author: 'DrSnake', publisher: 'Pub1', price: 230.0, stock: 50})
      Book.create({name: 'Global Warming', author: 'WeirdGuy', publisher: 'Pub4', price: 220.0, stock: 40})
      Book.create({name: 'Random Book', author: 'TheGuy', publisher: 'Pub1', price: 200.0, stock: 30})
      Book.create({name: 'Transformers', author: 'ACDC', publisher: 'Pub5', price: 100.00, stock: 40})
  end
end
