package router

import (
	"encoding/gob"
	"fmt"
	"io/ioutil"
	"net/http"
	"strings"

	"github.com/gin-contrib/sessions"
	"github.com/gin-contrib/sessions/cookie"
	"github.com/gin-gonic/gin"
)

// New registers the routes and returns the router.
func New() *gin.Engine {
	router := gin.Default()

	// To store custom types in our cookies,
	// we must first register them using gob.Register
	gob.Register(map[string]interface{}{})

	store := cookie.NewStore([]byte("secret"))
	router.Use(sessions.Sessions("auth-session", store))

	router.GET("/", func(c *gin.Context) {

		url := "https://dev-jy4007c0.us.auth0.com/oauth/token"

		fmt.Println(c.Request.Header)

		payload := strings.NewReader("{\"client_id\":\"z9BxQ8d27lxNAGinnTIdtBN7BcVQUtnf\",\"client_secret\":\"iL_jvclxJmmWvnhbO3ruhzzkhKkslErYw5abDnmL95fq27nlD3IA4ZGKqAKY-MpG\",\"audience\":\"https://dev-jy4007c0.us.auth0.com/api/v2/\",\"grant_type\":\"client_credentials\"}")

		req, _ := http.NewRequest("POST", url, payload)

		req.Header.Add("content-type", "application/json")

		res, err := http.DefaultClient.Do(req)
		if err != nil {
			c.String(http.StatusUnauthorized, "Token was invalid")
		}

		defer res.Body.Close()
		body, _ := ioutil.ReadAll(res.Body)

		c.String(http.StatusOK, string(body))
	})

	return router
}
