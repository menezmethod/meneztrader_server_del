package models

import (
	"gorm.io/gorm"
	"time"
)

type Country struct {
	ID   uint   `json:"id"`
	Name string `json:"name"`
}

type Currency struct {
	ID       uint   `json:"id"`
	Code     string `json:"code"`
	Name     string `json:"name"`
	IsActive bool   `json:"is_active"`
	Details  string `gorm:"type:text" json:"details"`
}

type CurrencyRate struct {
	ID             uint      `json:"id"`
	CurrencyID     uint      `json:"-"`
	Currency       Currency  `gorm:"foreignKey:CurrencyID;references:ID" json:"currency"`
	BaseCurrencyID uint      `gorm:"foreignKey:ID" json:"base_currency_id"`
	BaseCurrency   Currency  `gorm:"foreignKey:BaseCurrencyID;references:ID"`
	Rate           bool      `json:"rate"`
	TS             time.Time `json:"ts"`
}

type CurrencyUsed struct {
	ID         uint      `json:"id"`
	CountryID  uint      `json:"-"`
	Country    Country   `gorm:"foreignKey:CountryID;references:ID" json:"country"`
	CurrencyID uint      `json:"-"`
	Currency   Currency  `gorm:"foreignKey:CurrencyID;references:ID" json:"currency"`
	DateFrom   time.Time `json:"date_from"`
	DateTo     time.Time `json:"date_to"`
}

type Item struct {
	ID         uint     `json:"id"`
	Code       string   `json:"code"`
	IsActive   bool     `json:"is_active"`
	CurrencyID uint     `json:"-"`
	Currency   Currency `gorm:"foreignKey:CurrencyID;references:ID" json:"currency"`
	Details    string   `gorm:"type:text"`
}
type Price struct {
	ID         uint      `json:"id"`
	ItemID     uint      `json:"-"`
	Item       Item      `gorm:"foreignKey:ItemID;references:ID" json:"item_id"`
	CurrencyID uint      `json:"-"`
	Currency   Currency  `gorm:"foreignKey:CurrencyID;references:ID" json:"currency"`
	Buy        bool      `json:"buy"`
	Sell       bool      `json:"sell"`
	TS         time.Time `json:"ts"`
}

type Report struct {
	ID          uint      `json:"id"`
	TradingDate time.Time `json:"trading_date"`
	ItemID      uint      `json:"-"`
	Item        Item      `gorm:"foreignKey:ItemID;references:ID" json:"item"`
	CurrencyID  uint      `json:"-"`
	Currency    Currency  `gorm:"foreignKey:CurrencyID;references:ID" json:"currency"`
	FirstPrice  float32   `json:"first_price" sql:"type:decimal(16,6);"`
	LastPrice   float32   `json:"last_price" sql:"type:decimal(16,6);"`
	MinPrice    float32   `json:"min_price" sql:"type:decimal(16,6);"`
	MaxPrice    float32   `json:"max_price" sql:"type:decimal(16,6);"`
	AvgPrice    float32   `json:"avg_price" sql:"type:decimal(16,6);"`
	TotalAmount float32   `json:"total_amount" sql:"type:decimal(16,6);"`
	Quantity    float32   `json:"quantity" sql:"type:decimal(16,6);"`
}

type Trader struct {
	ID                  uint      `json:"id"`
	FirstName           string    `json:"first_name"`
	LastName            string    `json:"last_name"`
	UserName            string    `json:"user_name"`
	Password            string    `json:"password"`
	Email               *string   `json:"email"`
	ConfirmationCode    string    `json:"confirmation_code"`
	TimeRegistered      time.Time `gorm:"autoCreateTime" json:"time_registered"`
	TimeConfirmed       time.Time `json:"time_confirmed"`
	CountryID           uint      `json:"-"`
	Country             Country   `gorm:"foreignKey:CountryID;references:ID" json:"country"`
	PreferredCurrencyID uint      `json:"-"`
	PreferredCurrency   Currency  `gorm:"foreignKey:PreferredCurrencyID;references:ID;" json:"preferred_currency"`
}

type Trade struct {
	ID          uint   `json:"id"`
	ItemID      uint   `json:"-"`
	Item        Item   `gorm:"foreignKey:ItemID;references:ID" json:"item"`
	SellerID    uint   `json:"-"`
	Seller      Trader `gorm:"foreignKey:SellerID;references:ID" json:"seller"`
	BuyerID     uint   `json:"-"`
	Buyer       Trader `gorm:"foreignKey:BuyerID;references:ID" json:"buyer"`
	Quantity    int    `json:"quantity"`
	UnitPrice   int    `json:"-"`
	Description string `gorm:"type:text" json:"description"`
	OfferID     uint   `son:"-"`
	Offer       Offer  `gorm:"foreignKey:OfferID;references:ID" json:"offer"`
}

type Offer struct {
	ID       uint      `json:"id"`
	TraderID uint      `json:"-"`
	Trader   Trader    `gorm:"foreignKey:TraderID;references:ID" json:"trader"`
	ItemID   uint      `json:"-"`
	Item     Item      `gorm:"foreignKey:ItemID;references:ID" json:"item"`
	Quantity int       `json:"quantity"`
	Buy      bool      `json:"buy"`
	Sell     bool      `json:"sell"`
	Price    float32   `json:"price" sql:"type:decimal(16,6);"`
	TS       time.Time `json:"ts"`
	IsActive bool      `json:"is_active"`
}

type CurrentInventory struct {
	ID       uint    `json:"id"`
	TraderID uint    `json:"-"`
	Trader   Trader  `gorm:"foreignKey:TraderID;references:ID" json:"trader"`
	ItemID   uint    `gorm:"foreignKey:ID" json:"item_id" sql:"type:decimal(16,6);"`
	Item     Item    `gorm:"foreignKey:ItemID;references:ID" json:"item"`
	Quantity float32 `json:"quantity" sql:"type:decimal(16,6);"`
}

func MigrateAll(db *gorm.DB) error {
	err := db.AutoMigrate(&CurrentInventory{}, &Report{}, &CurrencyUsed{}, &CurrencyRate{}, &Trade{}, &Trader{}, &Offer{}, &Item{}, &Price{}, &Country{}, &Currency{})
	return err
}
