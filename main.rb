# frozen_string_literal: true

require 'tty-prompt'
require_relative 'appointment-class'

doctor_list = %w[Lucy Peter John Sarah]


def home_page
  puts "\n********Home Page*************\n\n"
  puts "Welcome to Easy Doctor Appointment\n\n"
  puts '**********************'
end

def create_details(doctor_name, date, time)
  puts 'Enter your full name'
      full_name = gets.chomp
      puts 'Enter your date of birth (follow dd/mm/yyyy format)'
      dob = gets.chomp
      puts 'Enter your medicare number'
      medicare_num = gets.chomp
      puts 'Enter your mobile number'
      mobile_num = gets.chomp
      appointment = Appointment.new(doctor_name,date,time,full_name, dob, medicare_num, mobile_num)
end
# check availability

def check_availability(doctor_name, date, time, appointments)
  appointments.each do |app|
    if app.doctor_name == doctor_name && app.date == date && app.time == time
      return false
    end
  end
  true
end
# view details

def view_details(date, appointments)
  appointments.each do |app|
    if app.date == date
      puts "\nDoctor: #{app.doctor_name} | Patient_Name: #{app.full_name} | Date: #{app.date} | Time: #{app.time}"
    else
      puts "\nSorry..!! No appointments for that day"
   end
  end
end

def save_and_exit(appointments)
  # File.open('details.txt', 'w+') do |f|
  File.open('details.txt', 'a') do |f|
    appointments.each do |element|
      f.write(element.date + ", ") 
      f.write(element.doctor_name + ", ")
      f.write(element.time + ", ") 
      f.write(element.full_name + ", ") 
      f.write(element.dob + ", ") 
      f.write(element.medicare_num + ", ")
      f.write(element.mobile_num + "\n")
    end
  end
end
appointments = []
# read file
file = 'details.txt'
File.read(file).each_line do |line|
  arr= line.split(",")
  puts arr
end

loop do
  home_page
  prompt = TTY::Prompt.new
  option = prompt.select('what would you like to do', %w[Create View Delete Exit])
  case option
  when 'Create'
    puts 'Which date would you like to make the appointment (follow dd/mm/yyyy format)'
    date = gets.chomp
    puts 'Which doctor would you like to make the appointment with? Available doctors are:'
    doctor_list.each do |doc|
      puts doc
    end
    doctor_name = gets.chomp.capitalize
    puts 'What time would you like to make an appointment (follow hh:mm format)' # validation :only 9to5 and time should be9:15,9:30..
    time = gets.chomp
    if check_availability(doctor_name, date, time, appointments)
      appointments << create_details(doctor_name, date, time)
      puts "Thank you.Appointment is confirmed with below details.\n\nName:#{appointments.last.full_name} | Doctor:#{doctor_name}| Date:#{date}\| Time:#{time}"
      
    else
      puts 'slot not available on that time.try another slot'
    end
  when 'Delete'

  when 'Exit'
    save_and_exit(appointments)
    exit
  when 'View'
    puts "\nEnter the date would you like to view\n"
    date = gets.chomp
    view_details(date, appointments)
  end
end
