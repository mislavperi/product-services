package router

import (
	"encoding/gob"
	"net/http"

	"github.com/gin-contrib/sessions"
	"github.com/gin-contrib/sessions/cookie"
	"github.com/gin-gonic/gin"

	"github.com/mislavpericaxilis/product-services/auth/authenticator"
	"github.com/mislavpericaxilis/product-services/auth/web/callback"
	"github.com/mislavpericaxilis/product-services/auth/web/login"
	"github.com/mislavpericaxilis/product-services/auth/web/logout"
	"github.com/mislavpericaxilis/product-services/auth/web/user"
)

// New registers the routes and returns the router.
func New(auth *authenticator.Authenticator) *gin.Engine {
	router := gin.Default()

	// To store custom types in our cookies,
	// we must first register them using gob.Register
	gob.Register(map[string]interface{}{})

	store := cookie.NewStore([]byte("secret"))
	router.Use(sessions.Sessions("auth-session", store))

	router.GET("/", func(c *gin.Context) {
		name := "string"
		c.String(http.StatusOK, "Hello %s", name)
	})
	router.GET("/login", login.Handler(auth))
	router.GET("/callback", callback.Handler(auth))
	router.GET("/user", user.Handler)
	router.GET("/logout", logout.Handler)

	return router
}
