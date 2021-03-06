# Coder Factory Academy Major Project #2
Deployed application: https://syd-explorer.herokuapp.com/

## Project Brief
Design, build, deploy and present a two-way application which will impress either Barack Obama, Rupert Murdoch or Bill/Melinda Gates

## Decision
I decided to make an application to impress Barack Obama. Michelle Obama had an initiative named “Let’s Move” which was aimed at encouraging a healthy lifestyle for children.

## Application
The application’s name is SYD Explorer which is a web application aimed at children to encourage them to participate in outdoor activities. I feel that as technology progresses and computers/smartphones have become a big part of our daily lives, the time we spend outdoors has significantly decreased. Engaging in outdoor activities is not only good for our physical health, but also is beneficial for our mental health. This application gives children an incentive to participate in outdoor activities by gamifying the experience of physically attending an event.

## Goal
Once logged in as a newly registered user, the user will be presented with a blank map of Sydney on the dashboard. Each time the user attends an event, a pin will be dropped on the location where the event was held. The aim of the application is to get the map as filled up as possible with the pin drops.

## Technology Stack
- Ruby on Rails
- Javascript

## Gems/Libraries/APIs
-	Carrierwave (image uploads for event thumbnails)
-	Geocoder (for calculation of latitude/longitude
-	Scrollbar Rails (styling of scroll bar)
-	Angular Bootstrap Calendar
-	Google Maps API

## Design process

### Brainstorming
Brainstormed the different users (parents, children, organisers, administrators), features, etc.
![Alt Brainstorming](/readme/brainstorm.png?raw=true)

### Entity Relationship Diagram
Used www.draw.io for Entity Relationship Diagram.
![Alt Entity Relationship Diagram](/readme/erd.png?raw=true)

## Screenshots

### Login Page
Users are required to login to start using the application. There are 4 different types of users which are: parents, children, organisers, administrators.
![Alt Login Page](/readme/login.png?raw=true)

### Signup Page
Parents are able to sign up through this page. Once they are signed up, they are able to sign up their children via the dashboard.
![Alt Signup Page](/readme/signup.png?raw=true)

### Dashboard
A summary of the important information is displayed in the dashboard. The items displayed will depend on the type of user that is logged in.
![Alt Dashboard](/readme/dashboard.png?raw=true)
