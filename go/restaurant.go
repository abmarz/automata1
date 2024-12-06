package main

import (
	"log"
	"math/rand"
	"sync"
	"sync/atomic"
	"time"
)

func do(seconds int, action ...any) {
	log.Println(action...)
	randomMillis := 500*seconds + rand.Intn(500*seconds)
	time.Sleep(time.Duration(randomMillis) * time.Millisecond)
}

type Order struct {
	id         uint64
	customer   string
	reply      chan *Order
	preparedBy string
}

var nextID atomic.Uint64

var Waiter = make(chan *Order, 3)

func Cook(name string) {
	log.Println(name, "is starting")
	for {
		var order *Order = <-Waiter
		do(10, name, "is cooking order", order.id, "for", order.customer) // Done with Dr. Toal in office hours
		order.preparedBy = name
		order.reply <- order
	}
}

func Customer(name string, wg *sync.WaitGroup) {
	defer wg.Done()
	ch := make(chan *Order)
	for mealsEaten := 0; mealsEaten < 5; {
		order := &Order{id: nextID.Add(1), customer: name, reply: ch} // Done with Dr. Toal in office hours
		log.Println(name, "is placing order", order.id)
		select {
		case Waiter <- order:
			order = <-order.reply
			log.Println(name, "is eating order")
			mealsEaten += 1
		case <-time.After(7 * time.Second):
			log.Println(name, "is waiting too long, abandoning order")
		}
	}
	log.Println(name, "had enogh meals and is leaving the restaurant") // Done with Dr. Toal in office hours
	wg.Done()
}

func main() {
	customers := [10]string{
		"Ani", "Bai", "Cat", "Dao", "Eve", "Fay", "Gus", "Hua", "Iza", "Jai",
	}
	var wg sync.WaitGroup
	for _, customer := range customers {
		wg.Add(1)
		go Customer(customer, &wg)

	}
	go Cook("Remy")
	go Cook("Linguini")
	go Cook("Colette")

	wg.Wait()

	log.Println("Restaurant is closing")
}
