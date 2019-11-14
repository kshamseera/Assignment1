class Appointment
  attr_accessor :doctor_name, :date, :time, :full_name, :mobile_num, :dob, :medicare_num
  def initialize(date,doctor_name,time,full_name,dob,mobile_num,medicare_num)
  @date = date
  @doctor_name = doctor_name
  @time = time
  @full_name = full_name
  @dob = dob
  @mobile_num = mobile_num
  @medicare_num = medicare_num
  end
end
doctor_list = ['Lucy', 'Peter', 'John', 'Sarah']
def home_page
  puts  "\n********Home Page*************\n\n"
  puts "Welcome to Easy Doctor Appointment\n\n"
  puts "What would you like to do?\n\n"
  puts "1.Create\n2.View\n3.Delete\n4.Exit\n\n"
  puts '**********************'
end
def check_availability(doctor_name,date,time,appointments)
    appointments.each do|app|
      if app.doctor_name == doctor_name && app.date == date && app.time == time
        return false
      end
    end
    return true
  end
appointments = []
while true
home_page
option = gets.chomp.capitalize
case option
when "Create"
  puts 'Which date would you like to make the appointment (follow dd/mm/yyyy format)'
  date = gets.chomp
  puts 'Which doctor would you like to make the appointment with? Available doctors are:'
  doctor_list.each do|doc|
  puts doc
  end
  #check how to select from list
  doctor_name = gets.chomp.capitalize
  puts 'What time would you like to make an appointment (follow hh:mm format)'#validation :only 9to5 and time should be9:15,9:30..
  time = gets.chomp.to_i
   ###check availability -to do
   if check_availability(doctor_name,date,time,appointments)
    puts 'Enter your full name'
    full_name = gets.chomp
    puts 'Enter your date of birth (follow dd/mm/yyyy format)'
    dob = gets.chomp
    puts 'Enter your medicare number'
    medicare_num = gets.chomp
    puts 'Enter your mobile number'
    mobile_num = gets.chomp
    puts "Thank you.Appointment is confirmed with below details.\nName:#{full_name}\nDoctor:#{doctor_name}\nDate:#{date}\nTime:#{time}"
    appointment =Appointment.new(date,doctor_name,time,full_name,dob,medicare_num,mobile_num)
    appointments << appointment
    appointments.each do |app|
    puts app.date
    puts app.doctor_name
    puts app.time
    puts app.full_name
    puts app.dob
    puts app.medicare_num
    puts app.mobile_num
    end
   else
    puts "slot not available on that time.try another slot"
  end
when "Exit"
    exit
  end
  end