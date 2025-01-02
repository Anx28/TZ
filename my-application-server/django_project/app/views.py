from django.http import JsonResponse
import subprocess

def healthcheck(request):
    status = {
        "nginx": check_service("nginx"),
        "django": True,
        "postgresql": check_service("postgresql")
    }
    return JsonResponse(status)

def check_service(service_name):
    try:
        subprocess.run(["systemctl", "is-active", "--quiet", service_name], check=True)
        return True
    except subprocess.CalledProcessError:
        return False
