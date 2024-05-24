
# Echo a single line documenting the plugin
echo "Convert strings to super or subscripts in unicode"

# Subscript conversion function
subscript() {
  local input="$1"
  local output=""
  for (( i=0; i<${#input}; i++ )); do
    char="${input:$i:1}"
    case "$char" in
      0) output+="₀" ;;
      1) output+="₁" ;;
      2) output+="₂" ;;
      3) output+="₃" ;;
      4) output+="₄" ;;
      5) output+="₅" ;;
      6) output+="₆" ;;
      7) output+="₇" ;;
      8) output+="₈" ;;
      9) output+="₉" ;;
      a) output+="ₐ" ;;
      e) output+="ₑ" ;;
      h) output+="ₕ" ;;
      i) output+="ᵢ" ;;
      j) output+="ⱼ" ;;
      k) output+="ₖ" ;;
      l) output+="ₗ" ;;
      m) output+="ₘ" ;;
      n) output+="ₙ" ;;
      o) output+="ₒ" ;;
      p) output+="ₚ" ;;
      q) output+="q" ;;
      r) output+="ᵣ" ;;
      s) output+="ₛ" ;;
      t) output+="ₜ" ;;
      u) output+="ᵤ" ;;
      v) output+="ᵥ" ;;
      x) output+="ₓ" ;;
      *) output+="$char" ;;
    esac
  done
  echo "$output"
}

# Superscript conversion function
superscript() {
  local input="$1"
  local output=""
  for (( i=0; i<${#input}; i++ )); do
    char="${input:$i:1}"
    case "$char" in
      0) output+="⁰" ;;
      1) output+="¹" ;;
      2) output+="²" ;;
      3) output+="³" ;;
      4) output+="⁴" ;;
      5) output+="⁵" ;;
      6) output+="⁶" ;;
      7) output+="⁷" ;;
      8) output+="⁸" ;;
      9) output+="⁹" ;;
      a) output+="ᵃ" ;;
      b) output+="ᵇ" ;;
      c) output+="ᶜ" ;;
      d) output+="ᵈ" ;;
      e) output+="ᵉ" ;;
      f) output+="ᶠ" ;;
      g) output+="ᵍ" ;;
      h) output+="ʰ" ;;
      i) output+="ⁱ" ;;
      j) output+="ʲ" ;;
      k) output+="ᵏ" ;;
      l) output+="ˡ" ;;
      m) output+="ᵐ" ;;
      n) output+="ⁿ" ;;
      o) output+="ᵒ" ;;
      p) output+="ᵖ" ;;
      q) output+="q" ;;
      r) output+="ʳ" ;;
      s) output+="ˢ" ;;
      t) output+="ᵗ" ;;
      u) output+="ᵘ" ;;
      v) output+="ᵛ" ;;
      w) output+="ʷ" ;;
      x) output+="ˣ" ;;
      y) output+="ʸ" ;;
      z) output+="ᶻ" ;;
      *) output+="$char" ;;
    esac
  done
  echo "$output"
}
