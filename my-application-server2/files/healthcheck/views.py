from django.http import JsonResponse
from django.db import connections
from django.db.utils import OperationalError
import subprocess
import requests

def healthcheck(request):
    # Проверка PostgreSQL
    db_healthy = True
    try:
        connections['default'].cursor()  # Пробуем создать курсор к БД
    except OperationalError:
        db_healthy = False  # Если не получилось - БД недоступна

    # Проверка nginx
    nginx_healthy = False
    try:
        # Проверяем статус службы nginx через systemctl
        result = subprocess.run(['systemctl', 'is-active', 'nginx'], 
                              capture_output=True, text=True)
        nginx_healthy = result.stdout.strip() == 'active'
    except:
        pass

    # Django уже работает, раз отвечает
    django_healthy = True

    # Формируем ответ
    status = {
        'status': 'healthy' if all([db_healthy, nginx_healthy, django_healthy]) else 'unhealthy',
        'components': {
            'postgresql': 'up' if db_healthy else 'down',
            'nginx': 'up' if nginx_healthy else 'down',
            'django': 'up' if django_healthy else 'down'
        }
    }

    return JsonResponse(status)
