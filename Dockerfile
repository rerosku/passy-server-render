# Usa un'immagine ufficiale di Go per compilare l'app
FROM golang:1.21 AS builder

# Imposta la directory di lavoro
WORKDIR /app

# Copia i file del server
COPY ./server/ .

# Scarica le dipendenze
RUN go mod tidy

# Compila il server Passy
RUN go build -o passy-server .

# Crea un'immagine più leggera per il runtime
FROM debian:bookworm-slim

# Imposta la directory di lavoro
WORKDIR /app

# Copia l'eseguibile dal builder
COPY --from=builder /app/passy-server .

# Espone la porta su cui il server Passy ascolta
EXPOSE 3000

# Comando di avvio
CMD ["./passy-server"]
