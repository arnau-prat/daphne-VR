#!/bin/bash
source venv/bin/activate
pip install -r requirements.txt
export SECRET_KEY="###########" USER="ubuntu" PASSWORD=""
python manage.py runserver 9002
