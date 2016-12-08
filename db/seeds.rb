# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

AccountMainType.create(name: "Assets", description: "Something owned or controlled by an entity")
AccountMainType.create(name: "Liabilities", description: "Economic obligations of an entity.")
AccountMainType.create(name: "Equity", description: "The value of assets after deducting the value of all liabilites.")
AccountMainType.create(name: "Income", description: "The company's earnings and common examples.")
AccountMainType.create(name: "Expense", description: "The company's expenditures.")
