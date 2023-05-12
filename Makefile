KAFKA_DIST = ~/kafka/kafka_2.13-3.4.0

.PHONY: clean
clean:
	docker compose down
	rm -rf local-data remote-data fake-data.json

local-data:
	mkdir local-data

remote-data:
	mkdir remote-data

fake-data.json:
	python3 generate-fake-data.py 1000000 > fake-data.json

.PHONY: run-kafka
run-kafka:
	docker compose up

.PHONY: create-topic
create-topic:
	$(KAFKA_DIST)/bin/kafka-topics.sh --bootstrap-server localhost:9092 \
		--create --topic topic1 \
		--config remote.storage.enable=true \
		--config segment.bytes=512000 \
		--config retention.ms=360000000 \
		--config local.retention.ms=120000
		@# 100 hours and 2 minutes

.PHONY: fill-topic
fill-topic: fake-data.json
	cat fake-data.json | $(KAFKA_DIST)/bin/kafka-console-producer.sh --bootstrap-server localhost:9092 \
		--topic topic1

.PHONY: delete-topic
delete-topic:
	$(KAFKA_DIST)/bin/kafka-topics.sh --bootstrap-server localhost:9092 \
		--delete --topic topic1

.PHONY: consume
consume:
	$(KAFKA_DIST)/bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 \
		--topic topic1 --from-beginning | head