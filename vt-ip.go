package main

import (
	"bufio"
	"fmt"
	"io"
	"log"
	"net/http"
	"os"
	"path/filepath"
	"time"
)

func main() {
	if len(os.Args) < 2 || len(os.Args) > 3 {
		log.Println("Usage: vt-ip <ip | '-'> [--no-cache]")
		return
	}

	ipSource := os.Args[1]
	noCache := len(os.Args) == 3 && os.Args[2] == "--no-cache"

	cacheDir := filepath.Join(os.Getenv("HOME"), ".local", "share", "ipvt")
	if err := os.MkdirAll(cacheDir, 0755); err != nil {
		log.Println("Failed to create cache directory:", err)
		return
	}

	first := true
	rateLimiter := time.NewTicker(15 * time.Second)
	defer rateLimiter.Stop()

	if ipSource == "-" {
		scanner := bufio.NewScanner(os.Stdin)
		for scanner.Scan() {
			ip := scanner.Text()
			if ip == "" {
				continue
			}
			if !first {
				<-rateLimiter.C // Wait for the rate limiter
			}
			first = false
			if cached := processIP(ip, noCache, cacheDir); cached {
				first = true
			}

		}
		if err := scanner.Err(); err != nil {
			log.Println("Error reading from stdin:", err)
		}
	} else {
		processIP(ipSource, noCache, cacheDir)
	}
}

func processIP(ip string, noCache bool, cacheDir string) bool {
	cacheFile := filepath.Join(cacheDir, ip+".json")

	if !noCache {
		if data, err := os.ReadFile(cacheFile); err == nil {
			fmt.Println(string(data))
			return true
		}
	}

	url := "https://www.virustotal.com/api/v3/ip_addresses/" + ip
	req, err := http.NewRequest("GET", url, nil)
	if err != nil {
		log.Println("Failed to create request:", err)
		return false
	}

	apikey := os.Getenv("VT_API_KEY")
	if apikey == "" {
		log.Println("VT_API_KEY is not set")
		os.Exit(1)
	}

	req.Header.Add("accept", "application/json")
	req.Header.Add("x-apikey", apikey)

	res, err := http.DefaultClient.Do(req)
	if err != nil {
		log.Println("Failed to execute request:", err)
		return false
	}
	defer res.Body.Close()

	if res.StatusCode != http.StatusOK {
		fmt.Printf("Failed to get data: %s\n", res.Status)
		return false
	}

	body, err := io.ReadAll(res.Body)
	if err != nil {
		log.Println("Failed to read response body:", err)
		return false
	}

	fmt.Println(string(body))

	if err := os.WriteFile(cacheFile, body, 0644); err != nil {
		log.Println("Failed to write cache file:", err)
		return false
	}

	return false
}
