package config

import (
	"fmt"
	"testing"
)

func TestN(t *testing.T) {
	wantPort := 3333
	t.Setenv("PORT", fmt.Sprint(wantPort))

	got, err := New()
	if err != nil {
		t.Fatalf("cannot create config: %v", err)
	}
	if got.Port != wantPort {
		t.Errorf("want port %v, got %v", wantPort, got)
	}
	wantEnv := "dev"
	if got.Env != wantEnv {
		t.Errorf("want env %v, got %v", wantEnv, got)
	}
}
