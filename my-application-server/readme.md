Run the Playbook:
```
ansible-playbook -i ansible/inventory.yml ansible/playbook.yml
 ```

Repository Structure:
```
my-application-server/
├── ansible/
│   ├── playbook.yml
│   ├── inventory.yml
│   ├── roles/
│   │   ├── django/
│   │   │   ├── tasks/
│   │   │   │   ├── main.yml
│   │   │   └── templates/
│   │   │       ├── gunicorn.service.j2
│   │   │       ├── settings.py.j2
│   │   │       └── wsgi.py.j2
│   │   ├── postgresql/
│   │   │   ├── tasks/
│   │   │   │   ├── main.yml
│   │   │   └── templates/
│   │   ├── nginx/
│   │       ├── tasks/
│   │       │   ├── main.yml
│   │       └── templates/
│   │           ├── nginx.conf.j2
├── django_project/
│   ├── manage.py
│   ├── <django_project_name>/
│       ├── settings.py
│       ├── urls.py
│       ├── wsgi.py
│   ├── app/
│       ├── views.py
│       ├── urls.py
├── README.md ```
