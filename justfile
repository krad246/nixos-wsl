top       := (justfile_directory())

# -----------------------------------------------------------------------------

default: 
  just --list

# -----------------------------------------------------------------------------

alias build := compile
alias install := apply

# -----------------------------------------------------------------------------

compile *ARGS: (_parse 'dry-build' ARGS)
test *ARGS: (_parse 'test' ARGS)

apply *ARGS: (_parse 'switch' ARGS)
alias switch := apply

check *ARGS: (compile ARGS)
format *ARGS: (_format ARGS)

clean *ARGS:
	rm -rf -- {{ top }}/.direnv
	nix-collect-garbage -d

# -----------------------------------------------------------------------------

[private]
_format *ARGS:
    @nix fmt {{ ARGS }}

base_args := '--use-remote-sudo \
		--option debugger true \
		--option eval-cache false \
		--option trace-verbose true'

[private]
_parse VERB *ARGS: (_format ARGS) && (_precheck ARGS)
	nixos-rebuild \
	        {{ base_args }} \
		{{ VERB }} {{ ARGS }}

[private]
[no-exit-message]
_precheck *ARGS: (_lint ARGS)

[private]
_lint *ARGS:
    true {{ ARGS }}


