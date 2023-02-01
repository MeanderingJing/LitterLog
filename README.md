
# Cat Bathroom Monitoring System
## Introduction
### What is the purpose of the cat bathroom monitoring system?
This project aims to monitor our cat Atticus' bathroom behavior in a fully automated system. The idea of this project was formed when Atticus was diagnosed with urinary traction disease in 2019, when our vet suggested that we keep track of his bathroom behavior.

An AI program jetson-inference is utilized to recognize our cat through a camera set up in front of Atticus' litterbox. Every time he uses the litterbox, the time of entry and departure is recorded. The data is automatically transformed and sent to a Postgres database through an **ETL pipeline**. A **data visualization service is set up** to view the data using Metabase. Additionally, graphs of the recorded data can be viewed through a web app.  

*Note: This system is made, assuming that one litterbox is only used by one cat.* 

## What did I (the developer) do to develop this system?
### Local setup (Version 1)

- start with a program that uses image recognition to monitor the cat and log the data whenever the cat goes to the bathroom (diagram)
Device used: [The NVIDIA® Jetson Nano™ Developer Kit](https://developer.nvidia.com/embedded/learn/get-started-jetson-nano-devkit#write)

- Set up a data pipeline that watches new data and load it to a database. (diagram)
- Build a web app that will present the data (Provide a link after deploying the web app?)

### Using Docker (Version 2)
## What skills did I demonstrate in making this system? 
