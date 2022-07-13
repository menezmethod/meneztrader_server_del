package main

import (
	"github.com/go-chi/chi"
	"log"
	"meneztrader_server/database"
	"meneztrader_server/models"
	"os"

	"github.com/joho/godotenv"
	"gorm.io/gorm"
)

var router *chi.Mux

type Repository struct {
	DB *gorm.DB
}

func routers() *chi.Mux {
	//router.Get("/traders", AllPosts)
	//router.Get("/posts/{id}", DetailPost)
	//router.Post("/posts", CreatePost)
	//router.Put("/posts/{id}", UpdatePost)
	//router.Delete("/posts/{id}", DeletePost)

	return router
}

func main() {
	err := godotenv.Load(".env")
	if err != nil {
		log.Fatal(err)
	}
	config := &database.Config{
		Host:     os.Getenv("DB_HOST"),
		Port:     os.Getenv("DB_PORT"),
		Password: os.Getenv("DB_PASS"),
		User:     os.Getenv("DB_USER"),
		SSLMode:  os.Getenv("DB_SSLMODE"),
		DBName:   os.Getenv("DB_NAME"),
	}

	db, err := database.NewConnection(config)

	if err != nil {
		log.Fatal("could not load the database")
	}
	err = models.MigrateAll(db)
	if err != nil {
		log.Fatal("could not migrate db")
	}

	r := Repository{
		DB: db,
	}
	app := fiber.New()
	r.SetupRoutes(app)
	err = app.Listen(":8080")
	if err != nil {
		log.Fatal("could not start server")
	}
}
