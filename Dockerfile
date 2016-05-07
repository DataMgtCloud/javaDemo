FROM datamgtcloud/basejava

# Copy application code.
COPY . /app/
WORKDIR /app

RUN assembleService.sh
