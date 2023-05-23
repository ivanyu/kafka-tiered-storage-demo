# Kafka Tiered Storage Demo

A demo project for Kafka Tiered Storage.

The project uses a Docker image built from https://github.com/aiven/kafka/tree/3.0-2022-03-31-tiered-storage and https://github.com/aiven/tiered-storage-for-apache-kafka/tree/new-implementation.

It contains the local "remote" tier implementation (uses a local directory as a mock remote storage) and the AWS S3 implementation. `compose-local.yaml` is for the former and `compose-s3.yaml` is for the latter. `compose-minio.yaml` is similar to `compose-s3.yaml`, but uses the local S3-compatible Minio storage instead of the real AWS S3.

## Requirements
- `make`
- Kafka distribution for client tools. You can take the latest from https://kafka.apache.org/downloads.
- Docker
- Docker Compose
- Python 3

## Running Demo

### Preparation for S3

If you are running the `compose-s3.yaml` demo, set the following environment variables:
- `KAFKA_RSM_CONFIG_OBJECT_STORAGE_S3_BUCKET_NAME` - the bucket name;
- `KAFKA_RSM_CONFIG_OBJECT_STORAGE_S3_REGION` - the bucket region;
- `KAFKA_RSM_CONFIG_OBJECT_STORAGE_AWS_ACCESS_KEY_ID` - the AWS access key ID;
- `KAFKA_RSM_CONFIG_OBJECT_STORAGE_AWS_SECRET_ACCESS_KEY` - the AWS access secret key.

You can either pass them from your shell or create the `.env` file.

### Preparation for Minio

If you are running the `compose-minio.yaml` demo, you need to create the bucket.

After running `make run-kafka-minio`:
1. Open the Minio console at http://localhost:9090/.
2. Login with `minioadmin:minioadmin`.
3. Go to "Buckets" and create the `test-bucket` bucket.

### Running

1. Set `KAFKA_DIST` in `Makefile` to the location of the Kafka distribution.
2. Run Kafka: `make run-kafka-local` (for the local "remote" tier) or `make run-kafka-s3` (for the AWS S3 remote tier) or `make run-kafka-minio` (for the S3 remote tier backed by the local Minio storage).
3. Create the topic: `make create-topic`.
4. Fill the topic: `make fill-topic`.
5. Wait for a couple of minutes for old segment files in `local-data/topic1-0` to be removed or renamed with `.deleted` suffix.
6. Consume the data: `make consume` (it'll consume the first 10 records).

## Cleaning

To shut down the Docker containers and clean everything, run `sudo make clean`. (`sudo` is needed because files in `local-data` are created as `root`).
