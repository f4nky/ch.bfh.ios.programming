# ch.bfh.ios.programming
Simple iOS swift application for educational purpose

### Overview
The app provides the possibility to log and monitor the member attendances for various events.
- reads data from API
- click on event to see and edit the attendances of the members
    - click multiple times on status button to switch between different states
- refresh data by pulling down the table view
- delete items by swiping from right to left
- views for adding new elements

### Screenshots


### Installation
- clone project from github
```
$ git clone https://github.com/f4nky/ch.bfh.ios.programming.git
```
- Open project 'attendanceCheck' in XCode
- Run project with iOS simulator

Note: No need to install/configure the server. REST API can be accessed via a public Digital Ocean server (see chapter 'REST API').

### REST API
#### Base URI
```
http://46.101.106.41/api/v1/
```
#### Periods
```
GET         - /periods/
GET/PUT/DEL - /periods/[id]/
```
```JSON
[{
    "id": 1,
    "name": "Saison 16/17"
}]
```
#### Events
```
GET         - /events/
GET/PUT/DEL - /events/[id]/
```
```JSON
[{
    "id": 1,
    "date": "2016-04-25",
    "description": null,
    "period": {
        "id": 1,
        "name": "Saison 16/17"
    },
    "event_type": {
        "id": 1,
        "name": "Training",
        "abbr": "T"
    }
}]
```
#### Event types
```
GET         - /event-types/
GET/PUT/DEL - /event-types/[id]/
```
```JSON
[{
    "id": 1,
    "name": "Training",
    "abbr": "T"
}]
```
#### Members
```
GET         - /members/
GET/PUT/DEL - /members/[id]/
```
```JSON
[{
    "id": 1,
    "first_name": "John",
    "last_name": "Doe",
    "birth_date": "1985-11-04",
    "member_type": {
        "id": 1,
        "name": "TrainerIn",
        "abbr": null
    }
}]
```
#### Member types
```
GET         - /member-types/
GET/PUT/DEL - /member-types/[id]/
```
```JSON
[{
    "id": 1,
    "name": "TrainerIn",
    "abbr": null
}]
```
#### Attendances
```
GET         - /attendances/
GET         - /attendances/[eventDate]/    //Format: YYYY-MM-dd
GET/PUT/DEL - /attendances/[id]/
```
```JSON
[{
    "id": 1,
    "status": "ANW",
    "event": {
        "id": 1,
        "date": "2016-04-25",
        "description": null,
        "period": {
            "id": 1,
            "name": "Saison 16/17"
        },
        "event_type": {
            "id": 1,
            "name": "Training",
            "abbr": "T"
        }
    },
    "member": {
        "id": 1,
        "first_name": "Michael",
        "last_name": "Fankhauser",
        "birth_date": "1985-11-04",
        "member_type": {
            "id": 1,
            "name": "TrainerIn",
            "abbr": null
        }
    }
}]
```
