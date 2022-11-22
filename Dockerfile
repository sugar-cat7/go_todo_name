# デプロイようコンテナに含めるバイナリ生成コンテナ
FROM golang:1.19.3-bullseye as deploy-builder

WORKDIR /app

COPY go.mod go.sum ./

RUN go mod download

COPY . .
RUN go build -trimpath -ldflags "-w -s" -o app

# デプロイ用コンテナ
FROM debian:bullseye-slim as deploy

RUN app-get update

COPY --from=deploy-builder /app/app .

CMD [ "./app" ]

# ローカル開発環境
FROM golang:1.19.3 as dev
WORKDIR /app
RUN go install github.com/cosmtrek/air@latest
CMD [ "air" ]
