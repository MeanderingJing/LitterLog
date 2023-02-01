
# Cat Bathroom Monitoring System
## Introduction
### What is the purpose of the cat bathroom monitoring system?
This project aims to monitor our cat Atticus' bathroom behavior in a fully automated system. The idea of this project was formed when Atticus was diagnosed with urinary traction disease in 2019, when our vet suggested that we keep track of his bathroom behavior.

An AI program jetson-inference is utilized to recognize our cat through a camera set up in front of Atticus' litterbox. Every time he uses the litterbox, the time of entry and departure is recorded. The data is automatically transformed and sent to a Postgres database through an **ETL pipeline**. A **data visualization service is set up** to view the data using Metabase. Additionally, graphs of the recorded data can be viewed through a web app.  

Note: This system is made, assuming that one litterbox is only used by one cat. 

## What did I (the developer) do to develop this system?



## What skills did I demonstrate in making this system? 
