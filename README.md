# ch.bfh.ios.programming
Simple iOS swift application for educational purpose

### Installation
- clone project from github
```
$ git clone https://github.com/f4nky/ch.bfh.ios.programming.git
```
- Open project in XCode
- Run project with iOS simulator

Note: No need to install/configure the server. REST API can be accessed by a public Digital Ocean server (see chapter 'REST API').

### REST API
#### Base URI
```
http://46.101.106.41/api/v1/
```
#### Periods
```
GET         - /periods/
GET/PUT/DEL - /periods/[id]
```
```
[{
    "id": 1,
    "name": "Saison 16/17"
}]
```
#### events
```
GET         - /events/
GET/PUT/DEL - /events/[id]
```
```
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
GET/PUT/DEL - /event-types/[id]
```
```
[{
    "id": 1,
    "name": "Training",
    "abbr": "T"
}]
```
#### Members
```
GET         - /members/
GET/PUT/DEL - /members/[id]
```
```
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
GET/PUT/DEL - /member-types/[id]
```
```
[{
    "id": 1,
    "name": "TrainerIn",
    "abbr": null
}]
```
#### Attendances
```
GET         - /attendances/
GET         - /attendances/[eventDate]    //Format: YYYY-MM-dd
GET/PUT/DEL - /attendances/[id]
```
```
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
