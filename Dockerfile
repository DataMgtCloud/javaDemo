FROM datamgtcloud/basejava

# Copy application code.
COPY dockerBuild /app/
COPY . /app/
WORKDIR /app

RUN assembleService.sh
