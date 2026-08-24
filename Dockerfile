FROM python:3.11-slim

# The shipped protobuf generated code (plugins/*_pb2.py) uses the old
# reflection-based API which was removed in protobuf 4.x, so pin the last
# compatible release.
RUN pip install --no-cache-dir "protobuf==3.19.6"

WORKDIR /app
COPY server.py test.py ./
COPY plugins/ ./plugins/

EXPOSE 5566/tcp

# Ensure log output is flushed to the container log stream
ENV PYTHONUNBUFFERED=1

ENTRYPOINT ["python", "server.py"]
