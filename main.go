package main

import (
	"log"
	"math/rand"
	"net/http"
	"os"
	"time"
)

var message string

func init() {
	baseStr := "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
	seed := rand.NewSource(time.Now().UnixNano()) //用指定值创建一个随机数种子
	r := rand.New(seed)
	randIndex := r.Intn(len(baseStr))
	message = baseStr[randIndex:randIndex+1]
}

func main() {
	http.HandleFunc("/", func(writer http.ResponseWriter, request *http.Request) {
		if _, err := writer.Write([]byte(message + "\n")); err != nil {
			log.Println(err.Error())
		}
	})
	listenAddr := os.Getenv("HTTP_PORT")
	if listenAddr == "" {
		listenAddr = ":8080"
	}
	log.Printf("will listening at %s", listenAddr)
	if err := http.ListenAndServe(listenAddr, nil); err != nil {
		log.Panicln(err.Error())
	}
}
