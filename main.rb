# frozen_string_literal: true

require 'TTY-font'
require 'TTY-prompt'
require 'colorize'
# require ‘pastel’
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
  option = prompt.select("\nwhat would you like to do", %w[Create View Delete Exit])
  case option
  when 'Create'
    puts 'Which date would you like to make the appointment (follow dd/mm/yyyy format)'.colorize(:cyan)
    date = gets.chomp
    # puts 'Which doctor would you like to make the appointment with? Available doctors are:'.colorize(:cyan)
    doctor_name = prompt.select('Please select the doctor', %w[Lucy Peter John Sarah])
    # doctor_list.each do |doc|
    #   puts doc
    # end
    # doctor_name = gets.chomp.capitalize
    puts 'What time would you like to make an appointment (follow hh:mm format)'.colorize(:cyan)
    time = gets.chomp
    if time < '9' || time > 5
      puts 'sorry! available booking time :9:00 -5:00'.colorize(:magenta)
      puts 'Please enter another time'.colorize(:cyan)
      time = gets.chomp
    end
    if check_availability(doctor_name, date, time, appointments)
      appointments << create_details(doctor_name, date, time)
      puts "Thank you.Appointment is confirmed with below details.\n\nName:#{appointments.last.full_name} | Doctor:#{doctor_name}|Date:#{date}\| Time:#{time}".colorize(:green)
    else
      puts 'slot not available on that time.try another slot'
    end
  when 'Delete'
    puts 'Please enter doctor name, date and time to delete appointment'.colorize(:cyan)
    doctor_name = gets.chomp
    date = gets.chomp
    time = gets.chomp
    delete_appointment(doctor_name, date, time, appointments)
    puts 'Appointment Deleted'.colorize(:red)
  when 'Exit'
    save_and_exit(appointments)
    exit
  when 'View'
    puts "\nEnter the date would you like to view".colorize(:cyan)
    date = gets.chomp
    view_details(date, appointments)
  end
end
