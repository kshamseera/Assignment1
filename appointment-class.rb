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