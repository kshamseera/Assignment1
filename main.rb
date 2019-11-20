# frozen_string_literal: true

require 'TTY-prompt'
require 'colorize'

require_relative 'appointment-class'
require_relative 'methods'

appointments = []

start_time = ARGV[0].to_i || 5.00
end_time = ARGV[1].to_i || 17.00
doctor_list = %w[Lucy Peter John Sarah]

load_records(appointments)

def gets
  STDIN.gets
end
loop do
  home_page
  prompt = TTY::Prompt.new
  option = prompt.select('CHOICE: '.colorize(:cyan), %w[Create View Delete Exit])
  case option
  when 'Create'
    time = 0
    puts "\nAVAILABLE BOOKING TIME: #{start_time} - #{end_time} \n".colorize(:magenta)
    date = prompt.ask('Which date would you like to make the appointment (follow dd/mm/yyyy format)'.colorize(:cyan), required: true)
    doctor_name = prompt.select('Please select the doctor'.colorize(:cyan), doctor_list)
    loop do
      time = prompt.ask('What time would you like to make an appointment (follow hh.mm format)'.colorize(:cyan), required: true).to_i
      if time < start_time || time > end_time
        puts "sorry! available booking time #{start_time} - #{end_time}".colorize(:red)
      else
        break
      end
    end
    if check_availability(doctor_name, date, time, appointments)
      appointments << create_details(doctor_name, date, time)
      puts "\nThank you.Appointment is confirmed with below details\n".colorize(:magenta)
      puts "Name:#{appointments.last.full_name} | Doctor:#{doctor_name}|Date:#{date}\| Time:#{time}\n".colorize(:green)
    else
      puts "\nSlot is not available on selected time. Please try another slot".colorize(:red)
    end
  when 'View'
    date = prompt.ask('Enter the date would you like to view'.colorize(:cyan), required: true)
    view_details(date, appointments)
  when 'Delete'
    doctor_name = prompt.select('Please select the doctor to delete'.colorize(:cyan), doctor_list)
    date = prompt.ask('Please enter the date to delete the appointment'.colorize(:cyan), required: true)
    time = prompt.ask('Please enter the time to delete the appointment'.colorize(:cyan), required: true)
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
