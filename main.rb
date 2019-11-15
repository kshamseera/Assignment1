# frozen_string_literal: true

require 'tty-font'
require 'tty-prompt'
require_relative 'appointment-class'
require_relative 'methods'

doctor_list = %w[Lucy Peter John Sarah]

appointments = []

#load_records(appointments)

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
    puts 'Please enter doctor name, date and time to delete appointment'
    doctor_name = gets.chomp
    date = gets.chomp
    time = gets.chomp
    delete_appointment(doctor_name, date, time, appointments)
    puts 'Appointment Deleted'
  when 'Exit'
    save_and_exit(appointments)
    exit
  when 'View'
    puts "\nEnter the date would you like to view\n"
    date = gets.chomp
    if view_details(date, appointments)
      puts "\nDoctor: #{appointments.doctor_name} | Patient_Name: #{appointments.full_name} | Date: #{appointments.date} | Time: #{appointments.time}"
    else
      puts 'sorry! No appointments is there to view'
    end
  end
end
