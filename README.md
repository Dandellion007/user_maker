# User Maker
Test specification

## Create Skill
```sh
curl --location 'localhost:3000/skills/' \
  --header 'Content-Type: application/json' \
  --data '{
    "name": "some_skill"
  }'
```

## Create Interest
```sh
curl --location 'localhost:3000/interests/' \
  --header 'Content-Type: application/json' \
  --data '{
    "name": "some_interest"
  }'
```

## Create User
```sh
curl --location 'localhost:3000/users/' \
  --header 'Content-Type: application/json' \
  --data-raw '{
    "params": {
      "email": "sher@goldner.example",
      "age": 7,
      "gender": "male",
      "name": "Ahmed",
      "surname": "Weber",
      "patronymic": "Emard",
      "nationality": "Czechs",
      "country": "United Arab Emirates",
      "interests": ["some_interest"],
      "skills": "some_skill"
    }
  }'
```
