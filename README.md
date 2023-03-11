
# Cat Bathroom Monitoring System
## Introduction
### What is the purpose of the cat bathroom monitoring system?
This project aims to monitor our family cat Atticus' bathroom behavior with a fully automated system. The idea of this project was formed when Atticus was diagnosed with urinary traction disease in 2019, when our vet suggested that we keep track of his bathroom behavior.

An AI program jetson-inference is utilized to recognize our cat through a camera set up in front of Atticus' litterbox. Every time he uses the litterbox, the time of entry and departure is recorded. The data is automatically transformed and sent to a Postgres database through an **ETL pipeline**. A **data visualization service is set up** to view the data using Metabase. Additionally, graphs of the recorded data can be viewed through a web app.  

*Note: This system is made, assuming that one litterbox is used by one cat.* 

## What did I do to develop this system?
### ***Local setup (Version 1)***

### Step 1: Develop a computer vision software application 
This software application automatically records the timestamps corresponding to each instance of a cat using the litterbox.
#### Refer to [its Github repo](https://github.com/emma-jinger/CatWatcher) for more details.
### Step 2: Set up a data pipeline
The data pipeline watches new data and load it to a database. Design and implement a data pipeline that continuously monitors for incoming data and efficiently loads them into a designated database for further processing and analysis.
#### Refer to [its Github repo](https://github.com/emma-jinger/cat_data) for more details.

### Step 3: Build a web app that will present the data
#### Refer to [its Github repo](https://github.com/emma-jinger/cat_bathroom_monitoring_system_web_app) for more details.

### ***Using Docker (Version 2)***
## What skills did I demonstrate in making this system? 
