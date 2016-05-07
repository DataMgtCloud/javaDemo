FROM datamgtcloud/basejava

# Copy application code.
COPY . /app/
WORKDIR /app

CMD ["./assembleService.sh"]
