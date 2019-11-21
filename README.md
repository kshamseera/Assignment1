
# Terminal Application - Easy Doctor Appointment 
----

Easy Doctor appointment is a terminal application to help doctors and clinics for hassle-free appointment booking of their patients. Main Feature of this application are create new appointment, view all appointments and delete appointment.


This application is developed using ruby language.


### Installation 
* Install ruby 2.5
For Installation click here [ruby](https://www.ruby-lang.org/en/downloads/)

    ```
    chmod +x ./build.sh
    ./build.sh 
    cd dist
    ```

run: ```ruby main.rb <start_time> <end_time>```

Program accept optional arguments for start and end time. if no value specified start time is defaulted to 09.00 and end time is defaulted to 17.00

    examples:

    ruby main.rb 
    ruby main.rb  08.00 16.00



### Dependencies

gems required in the applications are:
* colorize 
* tty-prompt
* tty-font
* pastel
for gem installation refer ``` ./build.sh```  file


### system/hardware requirements

* Mac os 

### Features

* create 
* view
* delete
* exit 


