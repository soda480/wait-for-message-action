FROM python:3.9-slim
ENV PYTHONDONTWRITEBYTECODE 1
RUN pip install wait-for-message --upgrade
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]