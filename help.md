### Installation 
* Install ruby
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

gems required in this application are:
* colorize 
* tty-prompt
* tty-font
* pastel
for gem installation refer ``` ./build.sh```  file


### system/hardware requirements

* Mac os 

### Features

* Create 
* View
* Delete
* Exit 
* I included two test files. one for checking the availability of appointments. Other one for testing the delete feature