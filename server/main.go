package main

import (
	"database/sql"
	"fmt"
	"net/http"
	"os"

	"github.com/gin-gonic/gin"
	_ "github.com/lib/pq"
)

func main() {
	dbHost := os.Getenv("DATABASE_HOST")
	dbPort := os.Getenv("DATABASE_PORT")
	dbUser := os.Getenv("DATABASE_USER")
	dbPassword := os.Getenv("DATABASE_PASSWORD")
	dbName := os.Getenv("DATABASE_NAME")
	passphrase := os.Getenv("PASSPHRASE")

	if dbHost == "" || dbPort == "" || dbUser == "" || dbPassword == "" || dbName == "" || passphrase == "" {
		fmt.Println("Errore: alcune variabili ambiente mancanti.")
		os.Exit(1)
	}

	dbURL := fmt.Sprintf("host=%s port=%s user=%s password=%s dbname=%s sslmode=disable",
		dbHost, dbPort, dbUser, dbPassword, dbName)

	db, err := sql.Open("postgres", dbURL)
	if err != nil {
		panic("Errore apertura connessione al database: " + err.Error())
	}
	defer db.Close()

	r := gin.Default()

	// Test route
	r.GET("/", func(c *gin.Context) {
		c.JSON(http.StatusOK, gin.H{"message": "Passy Server è attivo!"})
	})

	// Aggiungi qui altre route per gestione credenziali, sync, etc.

	r.Run(":3000")
}
