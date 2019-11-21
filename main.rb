# frozen_string_literal: true

require_relative 'appointment-class'
require_relative 'methods'

appointments = []

start_time = ARGV[0] || 9.0
start_time = start_time.to_i
end_time = ARGV[1] || 17.0
end_time = end_time.to_i
doctor_list = %w[Lucy Peter John Sarah]

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
    time = 0
    puts "\nAVAILABLE BOOKING TIME: #{start_time} - #{end_time} \n".colorize(:magenta)
    date = prompt.ask('Which Date Would You Like To Make The Appointment (follow dd/mm/yyyy format)'.colorize(:cyan), required: true)
    doctor_name = prompt.select('Please Select The Doctor'.colorize(:cyan), doctor_list)
    loop do
      time = prompt.ask('What Time Would You Like To Make An Appointment (follow hh.mm format)'.colorize(:cyan), required: true)
      time_num = time.to_i
      if time_num < start_time || time_num > end_time
        puts "Sorry! Available Booking Time #{start_time} - #{end_time}".colorize(:red)
      else
        break
      end
    end
    if check_availability(doctor_name, date, time, appointments)
      appointments << create_details(doctor_name, date, time)
      puts "\nThank You.Appointment Is Confirmed With Below Details\n".colorize(:magenta)
      puts "Name:#{appointments.last.full_name} | Doctor:#{doctor_name}|Date:#{date}\| Time:#{time}\n".colorize(:green)
    else
      puts "\nSlot Is Not Available On Selected Time. Please Try Another Slot".colorize(:red)
    end
  when 'View'
    date = prompt.ask('Enter The Date Would You Like To View'.colorize(:cyan), required: true)
    view_details(date, appointments)
  when 'Delete'
    # puts "Not implemented yet"
    doctor_name = prompt.select('Please Select The Doctor To Delete'.colorize(:cyan), doctor_list)
    date = prompt.ask('Please Enter The Date To Delete The Appointment'.colorize(:cyan), required: true)
    time = prompt.ask('Please Enter The Time To Delete The Appointment'.colorize(:cyan), required: true)
    if delete_appointment(doctor_name, date, time, appointments)
      puts 'No Available Appointments To Delete'.colorize(:red)
    else
      puts 'Appointment Deleted'.colorize(:green)
    end
  when 'Exit'
    save_and_exit(appointments)
    exit

  end
end
