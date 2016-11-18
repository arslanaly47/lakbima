# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
production_department = Department.create(name: "Production")
sales_department      = Department.create(name: "Sales")
management_department = Department.create(name: "Management")


JobTitle.create(name: "Chef")
