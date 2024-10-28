.PHONY: build
build:
	go build -o output/bin/mike cmd/mike/main/main.go

.PHONY: gen
gen:
	go get -u ./...
	go mod tidy
	go generate ./...
	go test -v ./...

.PHONY: image
image:
	docker build --push -t njpowell/mike .

.PHONY: helm
helm:
	helm install mike ./charts/mike

.PHONY: uhelm
uhelm:
	helm uninstall mike

.PHONY: ksecret
ksecret:
	kubectl create secret generic ngrok --from-literal=NGROK_AUTHTOKEN=$(NGROK_AUTHTOKEN)