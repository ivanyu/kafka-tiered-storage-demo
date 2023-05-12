# Kafka Tiered Storage Demo

A demo project for Kafka Tiered Storage.

The project uses a Docker image built from https://github.com/aiven/kafka/tree/3.0-2022-03-31-tiered-storage and https://github.com/aiven/tiered-storage-for-apache-kafka/tree/new-implementation.

## Requirements
- `make`
- Kafka distribution for client tools. You can take the latest from https://kafka.apache.org/downloads.
- Docker
- Docker Compose
- Python 3

## Running

1. Set `KAFKA_DIST` in `Makefile` to the location of the Kafka distribution.
2. Run Kafka: `make run-kafka`.
3. Create the topic: `make create-topic`.
4. Fill the topic: `make fill-topic`.
5. Wait for a couple of minutes for old segment files in `local-data/topic1-0` to be removed or renamed with `.deleted` suffix.
6. Consume the data: `make consume`.

## Cleaning

To shut down the Docker containers and clean everything, run `sudo make clean`. (`sudo` is needed because files in `local-data` are created as `root`).
