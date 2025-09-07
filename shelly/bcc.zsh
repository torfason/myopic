
# Echo a single line documenting the plugin
echo "Define bcc, wrapping bc for input on command line"

# Define main function, to be called using alias below
_bcc() {
  if [[ $# -eq 0 || "$1" == "-h" || "$1" == "--help" ]]; then
    cat <<'EOF'
bcc - simple wrapper for the bc calculator

Usage:
  bcc <expression>

Examples:

  # Simple expressions work without quotes
  bcc 2+2    → 4
  bcc 17*13  → 221
  bcc 1/3    → .3333

  # More complex expressions require quoting
  bcc "pi(2)"          → 3.14     (use functions)
  bcc "a=2^2; sqrt(a)" → 2.0000   (use variables)
  bcc "scale=6; e(1)"  → 2.718281 (use explicit scale)

Notes:
- Default scale=4 is applied unless you specify your own.
- Supports bc -l math functions: s(), c(), a(), l(), e(), sqrt(), etc.
- For multiple bc commands separated by `;`, quote the expression:
      bcc "scale=4; 10/3"
EOF
    return 0
  fi


  # always prepend scale=4; user-specified scale later will override
  printf "scale=4; %s\n" "$*" | bc -l
}

# Disable globbing when calling bcc
alias bcc='noglob _bcc'
