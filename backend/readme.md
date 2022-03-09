# Expense Tracker

### :small_red_triangle: About
The backend for the expense tracker app is made :building_construction: using:
 - :1st_place_medal: `python` : The programming languge used
 - :2nd_place_medal: `django` : The framework for develping the backend
   
### :bookmark_tabs: Back-End
The backend section for the expense tracker.This section contains the django app with two app `authentication` and `api` .

#### :rescue_worker_helmet: Authentication
The authentication app contains the following routes :arrow_right:
- > create
- > token
- > refresh
- > change_password

#### :adhesive_bandage:api
The api app contains the following routes :arrow_lower_right:
- > info
- >sources
- > income
- >categories
### :construction: Usage 

Clone this repo 
```bash
    git clone https://github.com/tuuhin/expense_tracker.git
```
This is the main repository contains both the frontend  and backend 
```bash
    cd backend 
```
```bash
    pip install -r requirements.txt
```
```bash
    python manage.py migrate
```
```bash
    python manage.py runserver 
```
