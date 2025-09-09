
# Echo a single line documenting the plugin
echo "Define bcc/bci/bcd, wrappers for bc with preset scale"

# Define main function, to be called using aliases below
_bcc() {

  # Echo usage instructions if -h, --help, or nothing is passed
  if [[ $# -eq 0 || "$1" == "-h" || "$1" == "--help" ]]; then
    cat <<'EOF'
bcc - simple wrapper for the bc calculator

Usage:
  bcc <expression>   (four decimal places, scale=4)
  bci <expression>   (integer mode, scale=0)
  bcd <expression>   (double precision, bc -l sets scale=20)

Examples:

  # Simple expressions
  bcc 2+2    → 4
  bcc 17*13  → 221
  bcc 1/3    → .3333

  # More complex expressions (quote them)
  bcc "pi(2)"          → 3.14
  bcc "a=2^2; sqrt(a)" → 2.0000
  bcc "scale=6; e(1)"  → 2.718281

  # Three scale options (note truncation, not rounding)
  bci 5/3   → 1
  bcc 5/3   → 1.6666
  bcd 5/3   → 1.66666666666666666666

Notes:
- Default scale depends on alias:
    bcc → system default (bc -l sets scale=20)
    bci → integer mode (scale=0)
    bcq → 4 decimal places (scale=4)
- For multiple bc commands separated by `;`, quote the expression:
      bcc "scale=4; 10/3"
- The `%` operator behaves differently if scale≠0.
  This wrapper warns if `%` is used outside integer mode.
EOF
    return 0
  fi

  # Warn about % with scale≠0
  if [[ "$*" == *%* && "$BC_ENV_ARGS" != "-e scale=0" ]]; then
    echo "bcc: warning: '%' used with scale≠0 may give unexpected results" >&2
    echo "              bci is generally recommended when using modulo" >&2
  fi

  # Evaluate expression
  printf "%s\n" "$*" | bc -l
}

# Aliases for different scale modes
alias bcc='BC_ENV_ARGS="-e scale=4" noglob _bcc'
alias bci='BC_ENV_ARGS="-e scale=0" noglob _bcc'
alias bcd='noglob _bcc'
