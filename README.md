# README
# colorado-breweries

This is a Ruby on Rails API only API to search for breweries in the state of Colorado.  The data I am using is sourced from `https://www.openbrewerydb.org/`, a free open API that has brewery info for the United States.  Per their documentation most of the data is from Summer 2018 so it will likely be a little out of date but for demonstration purposes it will suffice.  I have set my app's database up to only hold databases's in Colorado because I live in Colorado.

This app does utilize CircleCI for CI/CD purposes to run the test suite on every Pull Requests from Github.  If the tests pass on CircleCI then the app is automatically deployed to Heroku to be live on the internet.

This is the backend engine fueling Hitch, a web application that connects users to similar routes and can help get vehicles off the road. The application is built with service oriented architecture and this app does most of the heavy lifting (see [Project Architecture](#project-architecture)). The backend communicates with the frontend using 5 API JSON endpoints. It stores all our information in our databases.

The API endpoints allow other apps to store Users, Ridedays, Rides, Vehciles, and Friends.  There is functionality on the backend to find matching routes requests all the zipcodes near your specific destination/origin and grabs users with matching routes in those specific areas. 


### Created by:
- [Jake Volpe](https://github.com/javolpe) | [LinkedIn](https://www.linkedin.com/in/jake-volpe-bb602b126/)

### Base URL
[co-breweries](https://co-breweries.herokuapp.com)


#### Built With
* [Ruby on Rails](https://rubyonrails.org)
* [postgresql](https://www.postgresql.org/)
* [rspec](https://rspec.info/)

This project was tested with:
* RSpec version 3.10
* [Postman](https://www.postman.com/) Explore and test the API endpoints using Postman, and use Postman’s CLI to execute collections directly from the command-line.

## Contents
- [Getting Started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [Installing](#installing)
- [Endpoints](#endpoints)  
- [Database Schema](#database-schema)  
- [Testing](#testing)
- [Roadmap](#roadmap)



### Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system. Endpoints can be added. If you plan to use this engine with the frontend web application, if the endpoints are changed subsequent updates will be necessary on the Frontend repository code.

#### Prerequisites

* __Ruby__

  - The project is built with rubyonrails using __ruby version 2.5.3p105__, you must install ruby on your local machine first. Please visit the [ruby](https://www.ruby-lang.org/en/documentation/installation/) home page to get set up. _Please ensure you install the version of ruby noted above._

* __Rails__
  ```sh
  gem install rails --version 5.2.5
  ```

* __Postgres database__
  - Visit the [postgresapp](https://postgresapp.com/downloads.html) homepage and follow their instructions to download the latest version of Postgres app.


#### Installing

1. Clone the repo
  ```
  $ git clone https://github.com/javolpe/colorado_breweries
  ```

2. Bundle Install
  ```
  $ bundle install
  ```

3. Create, migrate and seed rails database
  ```
  $ rails db:{create,migrate,seed}
  ```

4. Set up Environment Variables:
  No environment variables are required as OpenBrewery does not require an API Key

  The seeds file will reach out to the API and seed your database with all breweries in Colorado from OpenBrewery.  The tests utilize a collection of handmade mock Brewery objects that are located in spec_helper.  They are just for testing purposes and do not reflect real world data accurately. If you would like to use the real world simply go into the test files and change the neccessary lines to use the method in the seeds file vs the method in spec_helper.

### Endpoints
| HTTP verbs | Paths  | Used for |
| ---------- | ------ | --------:|
| GET | /api/v1/breweries | Returns back serialized brewery objects, filtered and sorted based on the search. |

https://co-breweries.herokuapp.com - base URL


This is the only endpoint but it does do some heavy lifting.  There are currently eight (8) query params that can be added to this GET request.  If no query params are given you will be returned back 20 serialized objects. Additionally all 8 params may be used at once if desired.
The query params are:
* filter_name: "string"
* filter_postal_code: "string"
* filter_brewery_type: "string"
* filter_city: "string"
* sort_name: boolean
* sort_postal_code: boolean
* sort_brewery_type: boolean
* sort_city: boolean

The filter params will limit the results you get back.  All filter params are cross-referenced with the appropriate database fields as substring and case insesnsitive searches.
Brewery types are mirco, nano, regional, brewpub, large, planning, bar, contract, propietor, closed.
To connect the front end there would be 4 text input fields where the user can enter any text they wish to filter and search for breweries based on those 4 attributes.  If the user filters for something that does not exist and no breweries are found an appropriate message will be sent to the Front End.

The sort params are envisioned as check_boxes on the front end so if checked the value received by the Back End would be "true" (i.e. `sort_name: "true"`).  If more than one sort param is selected then they are sorted together (i.e. if sort_brewery_type and sort_postal_code are both selected, breweries in the same zip code will be orderd by brewery_type).

### Searches Table
The first step in the controller action for finding breweries is to record unique searches.  I debated heavily on whether or not to create an endpoint to expose the searches table but decided against as I felt that data shouldn't be exposed via API but rather as an admin pulling that data on a set schedule behind the scenes.  The searches table will only save unique requests based on params inputed to the above GET endpoint but if a request has the exact same param types and values as a previous request, a counter on that search record will be incremented by one.  My thinking here is that if a search is very popular and the same query params/values are being searched for that is also telling us data we want to track.



### Database Schema
![colorado-breweries](https://i.ibb.co/KFSsPdh/co-breweries-db.png)


### Testing
##### Running Tests
- To run the full test suite run the below in your terminal:
```
$ bundle exec rspec
```
- To run an individual test file run the below in tour terminal:
```
$ bundle exec rspec <file path>
```
for example: `bundle exec rspec spec/requests/api/vi/breweries/index_spec.rb`



### Roadmap
Future iterations I would love to start with adding in authentication to be able to track searches as they relate to a user.  Seeing the types of searches a user makes is crucially important to seeing what the user cares about, how often they use the app, and even what time of day they routinely make searches.  All of that data is INVALUABLE information to improving our app and user experience.


#### Credits
OpenBreweryDB for building such a cool API.  The link to their repo is [OpenBrewery Github](https://github.com/openbrewerydb/openbrewerydb) and they did great work.
Turing School of Software and Design.  Too many individuals to list out and thank but they are a fantastic program and I would recommend them to anyone who is sufficiently motivated to learn web development and willing to put in the work.
