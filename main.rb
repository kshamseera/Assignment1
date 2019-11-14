# frozen_string_literal: true

require 'tty-prompt'
require_relative 'appointment-class'

doctor_list = %w[Lucy Peter John Sarah]

def home_page
  puts "\n********Home Page*************\n\n"
  puts "Welcome to Easy Doctor Appointment\n\n"
  puts '**********************'
end

def create_details
  
end
#check availability

def check_availability(doctor_name, date, time, appointments)
appointments.each do |app|
  if app.doctor_name == doctor_name && app.date == date && app.time == time
  return false
  end
end
  return true
end
#view details

def view_details(date, appointments)
appointments.each do |app|
  if app.date == date
   puts "\nDoctor: #{app.doctor_name} | Patient_Name: #{app.full_name} | Date: #{app.date} | Time: #{app.time}"
 else
  puts "\nSorry..!! No appointments for that day"
 end
 end
end

def save_and_exit
  File.open("details.txt", "w+") do |f|
  appointments.each { |element| 
  f.write("#{date}")
  f.write("#{doctor_name}")
  f.write("#{time}")
  f.write("#{full_name}")
  f.write("#{dob}")
  f.write("#{medicare_num}")
  f.write("#{mobile_num}") 
}
end
appointments = []
#read file
while true
home_page
prompt = TTY::Prompt.new
option =prompt.select("what would you like to do",["Create", "View", "Delete" ,"Exit"])
case option
when "Create"
  puts 'Which date would you like to make the appointment (follow dd/mm/yyyy format)'
  date = gets.chomp
  puts 'Which doctor would you like to make the appointment with? Available doctors are:'
  doctor_list.each do|doc|
  puts doc
  end
  doctor_name = gets.chomp.capitalize
  puts 'What time would you like to make an appointment (follow hh:mm format)'#validation :only 9to5 and time should be9:15,9:30..
  time = gets.chomp
  if check_availability(doctor_name,date,time,appointments)
   #create_details
  puts 'Enter your full name'
  full_name=gets.chomp
  puts 'Enter your date of birth (follow dd/mm/yyyy format)'
  dob = gets.chomp
  puts 'Enter your medicare number'
  medicare_num = gets.chomp
  puts 'Enter your mobile number'
  mobile_num = gets.chomp
  puts "Thank you.Appointment is confirmed with below details.\n\nName:#{full_name} | Doctor:#{doctor_name}| Date:#{date}\| Time:#{time}"
  appointment =Appointment.new(date,doctor_name,time,full_name,dob,medicare_num,mobile_num)
  appointments << appointment 
  else
   puts "slot not available on that time.try another slot"
  end
when "Delete"
  
when "Exit"
   save_and_exit
   exit
when "View"
  puts "\nEnter the date would you like to view\n"
  date = gets.chomp
  view_details(date,appointments)
end
end
