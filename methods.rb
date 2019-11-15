# frozen_string_literal: true

def home_page
  puts "\n********Home Page*************\n\n"
  puts "Welcome to Easy Doctor Appointment\n\n"
  puts '**********************'
  end

# create appointment
def create_details(doctor_name, date, time)
  puts 'Enter your full name'
  full_name = gets.chomp
  puts 'Enter your date of birth (follow dd/mm/yyyy format)'
  dob = gets.chomp
  puts 'Enter your medicare number'
  medicare_num = gets.chomp
  puts 'Enter your mobile number'
  mobile_num = gets.chomp
  appointment = Appointment.new(doctor_name, date, time, full_name, dob, medicare_num, mobile_num)
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
  match_found_flag = false
  appointments.each do |app|
    if app.date == date
      match_found_flag = true
      puts "\nDoctor: #{app.doctor_name} | Patient_Name: #{app.full_name} | Date: #{app.date} | Time: #{app.time}"
    end
  end
  puts 'Sorry! No appointments is there to view' unless match_found_flag
  end

# Delete appointment
def delete_appointment(doctor_name, date, time, appointments)
  appointments.each do |app|
    if app.doctor_name == doctor_name && app.date == date && app.time == time
      appointments.delete(app)
  end
  end
end

# when exit..
def save_and_exit(appointments)
  File.open('details.txt', 'w') do |f|
    appointments.each do |element|
      f.puts("#{element.doctor_name},#{element.date},#{element.time},#{element.full_name},#{element.dob},#{element.medicare_num},#{element.mobile_num}")
    end
  end
end

# read file
def load_records(appointments)
  file = 'details.txt'
  File.readlines(file).each do |line|
    arr = line.chomp.split(',')
    a1 = Appointment.new(arr[0], arr[1], arr[2], arr[3], arr[4], arr[5], arr[6])
    appointments << a1
  end
  puts appointments.to_s
  puts appointments.length
end
