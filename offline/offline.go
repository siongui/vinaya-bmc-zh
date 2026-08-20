// https://www.google.com/search?q=golang+embed+entire+static+website+into+single+executable

package main

import (
	"embed"
	"io/fs"
	"net/http"
)

// Declare the embedded filesystem.
// The comment below tells Go to recursively embed everything inside the 'output/' folder.
//
//go:embed output/*
var staticAssets embed.FS

func main() {
	// Trim the "output" prefix so files are served directly from the root (e.g., /index.html)
	publicFS, err := fs.Sub(staticAssets, "output")
	if err != nil {
		panic(err)
	}

	// Create a standard HTTP file server handler using our embedded filesystem
	fileServer := http.FileServer(http.FS(publicFS))

	// Serve the static files on the root path
	http.Handle("/", fileServer)

	println("Server starting on http://localhost:8080/ ...")
	if err := http.ListenAndServe(":8080", nil); err != nil {
		panic(err)
	}
}
