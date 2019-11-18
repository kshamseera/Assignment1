# frozen_string_literal: true

require 'TTY-prompt'
require 'colorize'
require 'pastel'

require_relative 'appointment-class'
require_relative 'methods'

# doctor_list = %w[Lucy Peter John Sarah]

appointments = []

load_records(appointments)
def gets
  STDIN.gets
end
home_page
loop do
 
  prompt = TTY::Prompt.new
  option = prompt.select('CHOICE: '.colorize(:cyan), %w[Create View Delete Exit])
  case option
  when 'Create'
    time_flag
    date = prompt.ask('Which date would you like to make the appointment (follow dd/mm/yyyy format)'.colorize(:cyan),required: true)
    doctor_name = prompt.select('Please select the doctor'.colorize(:cyan), %w[Lucy Peter John Sarah])
    time = prompt.ask('What time would you like to make an appointment (follow hh:mm format)'.colorize(:cyan),required: true).to_i
    if time <= 9 || time >= 5
      puts 'sorry! available booking time :9:00 AM - 5:00 PM '.colorize(:red)
      time = prompt.ask('Please enter another time'.colorize(:cyan),required: true)
    end
    if check_availability(doctor_name, date, time, appointments)
      appointments << create_details(doctor_name, date, time)
      puts "\nThank you.Appointment is confirmed with below details\n".colorize(:magenta)
      puts "Name:#{appointments.last.full_name} | Doctor:#{doctor_name}|Date:#{date}\| Time:#{time}\n".colorize(:green)
    else
      puts "\nslot not available on that time.try another slot".colorize(:red)
    end
  when 'View'
    date = prompt.ask('Enter the date would you like to view'.colorize(:cyan),required: true)
    view_details(date, appointments)
  when 'Delete'
    doctor_name = prompt.ask('Please enter the doctor name to delete the appointment'.colorize(:cyan),required: true)
    date = prompt.ask('Please enter the date to delete the appointment'.colorize(:cyan),required: true)
    time = prompt.ask('Please enter the time to delete the appointment'.colorize(:cyan),required: true)
    if delete_appointment(doctor_name, date, time, appointments)
      puts 'No matching appointment found.Delete failed !'.colorize(:red)
    else
      puts 'Appointment Deleted'.colorize(:green)
    end
  when 'Exit'
    save_and_exit(appointments)
    exit

  end
end
