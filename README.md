
# LitterLog - The Fully Automated Cat Bathroom Monitoring System
## Introduction
### What is the purpose of LitterLog?
LitterLog aims to improve the health and well-being of our family cat, Atticus, by monitoring his bathroom behavior with a fully automated system. The idea of this project was formed when Atticus was diagnosed with urinary traction disease in 2019 and our vet suggested that we keep track of his bathroom habits.

### What has been done for the development of LitterLog?
- I have **developed [a software program](https://github.com/emma-jinger/Litterlog-CatWatcher/tree/aadfa7eb1b7098925f2a8226d23947514a762ee3)** that harnesses the power of object detection technology provided by the [jetson-inference library](https://github.com/dusty-nv/jetson-inference). The software integrates with a camera placed in front of Atticus' litterbox, allowing the system to record his entry and departure times whenever he uses the litterbox. 

- Then, I have **designed and implemented [a data pipeline](https://github.com/emma-jinger/LitterLog-DataPipeline/tree/d4c44f7470c6349ac62e4717515655d85f31f98c)** that continuously monitors for incoming data and efficiently loads them into a designated database for further processing and analysis.

- Finally, to enable easy analysis of this data, I have also **designed and developed [a user-friendly web app](https://github.com/emma-jinger/LitterLog-WebApp/tree/65c07feef6b9cb3ee439a9bd975c53307aaee43e)** that displays graphs of Atticus' bathroom behavior.

*Note: This system is made, assuming that one litterbox is used by one cat.* 


## How to Use This Repo?
Assuming the user (developer) has a machine that fulfills the requirements for executing CatWatcher program (Or, if it doesn't, that's okay too. We'll skip this, and feed sample data from the data pipeline part.)

## Clone the Repo
### Make a new working directory
```
mkdir <YOUR_LITTERLOG_WORKING_DIR>
cd <YOUR_LITTERLOG_WORKING_DIR>
```

### Set up a virtual environment on the server (optional)
Create a virtual environment `venv` using the command `python3 -m venv venv` <br>
Activate it using the command `source venv/bin/activate`

### Clone the repo
```
git clone --recursive https://github.com/emma-jinger/LitterLog 
``` 
Note: the `--recursive` option is used to clone the parent repository along with all its submodules, and initialize and update them automatically.

## Set Up the CatWatcher Program to Monitor the Litterbox 
### Clone `jetson-inference` and build it from source
```
sudo apt-get update
sudo apt-get install git cmake libpython3-dev python3-numpy
git clone --recursive https://github.com/dusty-nv/jetson-inference
cd jetson-inference
mkdir build
cd build
cmake ../
make -j$(nproc)
sudo make install
sudo ldconfig
```

### Make a directory under your home directory that the camera outputs data to: 
```
mkdir /home/$USER/cat_watcher_output
```
The CatWatcher program is currently configured to output data to this directory. 
(For my own reference, check if this directory is mounted to the directory `/var/nfs/cat_watcher_output` and how it was done.)

### Execute the CatWatcher program  
Note: This program import `dotenv`. Make sure that this package has been installed beforehand.  
```
python3 ./LitterLog-CatWatcher/CatWatcher.py
```
Now, the CatWatcher program should be running! In reality, it takes time before we get any data from the CatWatcher program. I will provide a sample csv file with recorded data to test the following data pipeline. 

## Set Up the Cat Data Pipeline
### Set up the postgres database
First, change directory to the Root directory of the repo with the command: `cd LitterLog`.<br>
Then, create a `.env` file, with the following information: 
```
DB_USER=your_db_user
DB_PASSWORD=your_db_pw
DB_NAME=your_db_db
PG_VERSION=14.8
```
Please modify the values for `DB_USER`, `DB_PASSWORD`, and `DB_NAME`. Then run the script with: 
```
sudo bash ./db-setup.sh
```
The script installs Postgres and creates a new database with a user and password specified in the provided .env file.

### Install the cat data pipeline package - `CatDataSchema`
```
cd LitterLog-DataPipeline
pip install -e .
```

### Create a `.env` file 
The `.env` file should be created under `CatDataSchema` under `LitterLog-DataPipeline`. In the `.env` file, add the directory we created earlier to the environment variable `CAT_DATA_DMZ`: 
```dotenv
# CAT_DATA_DMZ defines what directory the LitterLog-DataPipeline is monitoring
CAT_DATA_DMZ=/home/$USER/cat_watcher_output
# DATABASE_URL defines where the data pipeline will load the data retrieved
DATABASE_URL = YOUR_DATABASE_URL
``` 

### Run the application `cat_data_watcher` to run the ETL pipeline
```
cat_data_watcher
```
*Note: cat_data_watcher can be [set up as a service](https://github.com/emma-jinger/Set-Up-a-Service-on-Ubuntu) so that this app will always be running in the background.*

## Set Up the Web App 
### Make sure `git`, `Node.js`, and `npm` are installed
```
sudo apt update
sudo apt install git nodejs npm
```
*Note: `nodejs` and `npm` are installed for the web app.*

### Install dependencies and run the web server
Go to the directory ...
```
npm install
npm start
```
Now you should be able to see the web app with this address http://locahost:5001 on your browser.