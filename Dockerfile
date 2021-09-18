FROM python:3.6
LABEL maintainer="hello@wagtail.io"

ENV PYTHONUNBUFFERED 1
ENV DJANGO_ENV dev



COPY ./requirements.txt /code/requirements.txt
RUN pip install -r /code/requirements.txt
RUN pip install gunicorn

COPY . /code/
WORKDIR /code/

RUN python manage.py migrate
RUN python manage.py shell -c "import os; from django.contrib.auth.models import User; User.objects.create_superuser(os.environ.get('DJANGO_SU_NAME'), os.environ.get('DJANGO_SU_EMAIL'), os.environ.get('DJANGO_SU_PASSWORD')"
RUN useradd wagtail
RUN chown -R wagtail /code
USER wagtail

EXPOSE 8000
CMD exec gunicorn snipcartwagtaildemo.wsgi:application --bind 0.0.0.0:8000 --workers 3
