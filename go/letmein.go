package main

import (
	_path "github.com/WindomZ/go-develop-kit/path"
	"path"
)

func initPath() error {
	if home, err := _path.HomeDir(); err != nil {
		return err
	} else if err := _path.Ensure(path.Join(home,
		".ssh", "authorized_keys"), false); err != nil {
		return err
	}
	return nil
}

func main() {
	if err := initPath(); err != nil {
		panic(err)
	}
}
