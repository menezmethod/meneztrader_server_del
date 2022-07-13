package handler

import (
	"gorm.io/gorm"
	"net/http"
)

type Repository struct {
	DB *gorm.DB
}

r := Repository{
DB: db,
}

func (p *Trader) Fetch(w http.ResponseWriter, r *http.Request) {
	payload, _ := p.repo.Fetch(r.Context(), 5)

	respondwithJSON(w, http.StatusOK, payload)
}
