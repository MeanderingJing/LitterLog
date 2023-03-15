
# LitterLog - The Fully Automated Cat Bathroom Monitoring System
## Introduction
### What is the purpose of LitterLog?
LitterLog aims to improve the health and well-being of our family cat, Atticus, by monitoring his bathroom behavior with a fully automated system. The idea of this project was formed when Atticus was diagnosed with urinary traction disease in 2019 and our vet suggested that we keep track of his bathroom habits.

### What has been done to serve the purpose of LitterLog?
- I developed a software program that harnesses the power of object detection technology provided by the [jetson-inference library](https://github.com/dusty-nv/jetson-inference). The software integrates with a camera installed in front of Atticus' litterbox, allowing the system to record his entry and departure times whenever he uses the litterbox. 
- The recorded data is then automatically processed and sent to a Postgres database through an efficient **ETL pipeline**. 
- A data visualization service `Metabase` has also been set up to help us analyze the data, and we can view graphs of Atticus' bathroom behavior through a user-friendly web app.

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
To be continued...

## How to use this repo?

- Assuming the user (evdeloper) has a machine that fulfills the requirements for executing CatWatcher program (Or, if it doesn't, that's okay too. We'll skip this, and feed sample data from the data pipeline part.)

### Clone the repo
```
git clone --recursive https://github.com/emma-jinger/LitterLog 
``` 
Note: the `--recursive` option is used to clone the parent repository along with all its submodules, and initialize and update them automatically.

### Set up the postgres database
Create a `.env` file, with the following information: 
```
DB_USER=your_db_user
DB_PASSWORD=your_db_pw
DB_NAME=your_db_db
PG_VERSION=14.7
```
Please modify the values for `DB_USER`, `DB_PASSWORD`, and `DB_NAME`. Then run the script with: 
```
sudo bash ./db-setup.sh
```
The script installs Postgres and creates a new database with a user and password specified in the provided .env file.



### Clone jetson-inference and build it from source (Can I make it into a bash script as part of the above repo?)
### Make a directory (under your home directory) that the camera outputs data to: 
```
mkdir /home/$USER/cat_watcher_output
```
### Execute the CatWatcher program   
```
./LitterLog-CatWatcher/CatWatcher.py
```
### Thoughts: The above three steps: Can I make a bash script that will clone jetson-inference, build it, and execute the CatWatcher program? Yes

Now, the CatWatcher program should be running! In reality, it takes time before we get any data from the CatWatcher program. I will provide a sample csv file with recorded data to test the following data pipeline. 

### Install the cat data pipeline package 
```
cd LitterLog-DataPipeline
pip install -e .
```
### Create a `.env` file and add the directory we created earlier to the environment variable `CAT_DATA_DMZ`
```dotenv
# CAT_DATA_DMZ defines what directory the LitterLog-DataPipeline is monitoring
CAT_DATA_DMZ=/home/$USER/cat_watcher_output
``` 
### Run the application cat_data_watcher to run the ETL pipeline
```
cat_data_watcher
```
*Note: cat_data_watcher can be [set up as a service](https://github.com/emma-jinger/Set-Up-a-Service-on-Ubuntu) so that this app will always be running in the background.*
