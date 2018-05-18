# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

Dependence.create(name: "Ingenieria")
Dependence.create(name: "Ciencia")

Admin.create(name: "Julian",lastname: "Garzon",email:"jgarzonj@unal.edu.co",password:"123456",password_confirmation:"123456",dependence_id:1,phone_ext:"1123",permits:"profesor")
User.create(name: "Julian",lastname: "Garzon",email:"jgarzonj@unal.edu.co",password:"123456",password_confirmation:"123456",dependence_id:1,level:"pregrado")
User.create(name: "Bryan",lastname: "Prieto",email:"bfprietoc@unal.edu.co",password:"123456",password_confirmation:"123456",dependence_id:1,level:"pregrado")
User.create(name: "Fredy",lastname: "Cuellar",email:"facuellarg@unal.edu.co",password:"123456",password_confirmation:"123456",dependence_id:1,level:"pregrado")

10.times do
    pass = Faker::Internet.password(8)
    User.create(name: Faker::Name.first_name  ,lastname: Faker::Name.last_name,email:Faker::Internet.unique.safe_email,password: pass,password_confirmation: pass,dependence_id: rand(1..2),level:"pregrado")
end

levels = ["pregrado","postgrado"]


50.times do 
    requirements = []
    required_files = []
    profiles = []
    activities = []

    con = Convocation.new
    con.name = Faker::Educator.course
    con.description = Faker::Dune.quote
    con.level = levels[rand(0..1)]
    con.end_date = Faker::Date.forward(rand(1..60))
    con.admin_id = 1
    con.vacants = rand(1..15)
    con.hours_per_week = rand(5..30)
    con.payout = rand(300000..800000)
    con.duration = rand(15..180)
    con.dependences << Dependence.find(rand(1..2))
    
    if con.save! 
        rand(1..3).times do
            requirements.push(Requirement.create(description: Faker::FamilyGuy.quote,convocation_id: con.id))
            required_files.push(RequiredFile.create(name: Faker::Company.buzzword,convocation_id: con.id))
            profiles.push(Profile.create(description: Faker::Company.profession, convocation_id: con.id))
            activities.push(Activity.create(description: Faker::Company.catch_phrase, convocation_id: con.id))
        end
        con.requirements = requirements
        con.required_files = required_files
        con.profiles = profiles
        con.activities = activities
        
        con.save!
    end
   
end
values_states = ["aprobado","rechazado","interesado"]
20.times do 
    Application.create(user_id: rand(1..13),convocation_id: rand(1..50),state: values_states[rand(0..2)])
end

#Convocation.joins(:dependences).where("convocations.level = (?) AND dependences.id IN (?) AND convocations.payout BETWEEN (?) AND (?) AND convocations.duration BETWEEN (?) AND (?) AND convocations.hours_per_week BETWEEN (?) AND (?)","postgrado",Dependence.all.pluck(:id),Convocation.minimum(:payout),Convocation.maximum(:payout),Convocation.minimum(:duration),Convocation.maximum(:duration),Convocation.minimum(:hours_per_week),Convocation.maximum(:hours_per_week)).order(created_at: :desc).distinct
    
#Convocation.joins(:dependences).where("convocations.level = (?) AND dependences.id IN (?) AND convocations.payout BETWEEN (?) AND (?) AND convocations.duration BETWEEN (?) AND (?) AND convocations.hours_per_week BETWEEN (?) AND (?)","postgrado",[1],Convocation.minimum(:payout),Convocation.maximum(:payout),Convocation.minimum(:duration),Convocation.maximum(:duration),Convocation.minimum(:hours_per_week),Convocation.maximum(:hours_per_week)).order(created_at: :desc).distinct
  