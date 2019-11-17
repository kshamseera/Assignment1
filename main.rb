# frozen_string_literal: true

require 'TTY-prompt'
require 'colorize'
require 'pastel'
# font = TTY::Font.new(:doom)
# puts font.write(“WELCOME”)
# pastel = Pastel.new
# puts pastel.yellow(font.write(“DOOM”))

require_relative 'appointment-class'
require_relative 'methods'

# doctor_list = %w[Lucy Peter John Sarah]

appointments = []

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
    # name = prompt.ask("What is your name?")
    date = prompt.ask('Which date would you like to make the appointment (follow dd/mm/yyyy format)'.colorize(:cyan))
    doctor_name = prompt.select('Please select the doctor'.colorize(:cyan), %w[Lucy Peter John Sarah])
    time = prompt.ask('What time would you like to make an appointment (follow hh:mm format)'.colorize(:cyan)).to_i
    # time = time.to_i
    if time <= 9 || time >= 5
      puts 'sorry! available booking time :9:00 AM - 5:00 PM '.colorize(:red)
      time = prompt.ask('Please enter another time'.colorize(:cyan))
    end
    if check_availability(doctor_name, date, time, appointments)
      appointments << create_details(doctor_name, date, time)
      puts "Thank you.Appointment is confirmed with below details.\n\nName:#{appointments.last.full_name} | Doctor:#{doctor_name}|Date:#{date}\| Time:#{time}".colorize(:green)
    else
      puts 'slot not available on that time.try another slot'.colorize(:red)
    end
  when 'Delete'
    doctor_name = prompt.ask('Please enter the doctor name to delete the appointment').colorize(:cyan)
    date = prompt.ask('Please enter the date to delete the appointment').colorize(:cyan)
    time = prompt.ask('Please enter the time to delete the appointment').colorize(:cyan)
    if delete_appointment(doctor_name, date, time, appointments)
      puts 'Appointment Deleted'.colorize(:green)
    else
      puts 'No matching appointment found.Delete failed !'.colorize(:red)
    end
  when 'Exit'
    save_and_exit(appointments)
    exit
  when 'View'
    date = prompt.ask("Enter the date would you like to view".colorize(:cyan))
    view_details(date, appointments)
  end
end
