#!/data/data/com.termux/files/usr/bin/bash
# ═══════════════════════════════════════════════════════════
#   NECRO SOURCE PROXY FREE — INSTALLER v2
#   © 2026 NecroTeam
# ═══════════════════════════════════════════════════════════

R='\033[0m'; B='\033[1m'; D='\033[2m'
CY='\033[38;5;51m'; NE='\033[38;5;46m'; PK='\033[38;5;212m'
IC='\033[38;5;123m'; GD='\033[38;5;220m'; GR='\033[38;5;121m'
CR='\033[38;5;203m'; VI='\033[38;5;141m'

# ─── Spinner animasi ───
_SP='⠋⠙⠹⠸⠼⠴⠦⠧⠇⠏'

spin_start() {
  local msg="$1"
  echo -ne "  ${CY}▸${R} ${msg}  "
  ( while :; do
      for ((i=0;i<${#_SP};i++)); do
        echo -ne "\b${GD}${_SP:$i:1}${R}"
        sleep 0.08
      done
    done ) &
  SP_PID=$!
}

spin_stop() {
  kill "$SP_PID" 2>/dev/null
  wait "$SP_PID" 2>/dev/null
  echo -ne "\r  ${GR}✓${R} ${1}\n"
}

step() {
  echo ""
  echo -e "  ${PK}${B}┌─[${1}]───────────────${R}"
  echo -e "  ${PK}${B}│${R} ${IC}${2}${R}"
  echo -e "  ${PK}${B}└─────────────────────${R}"
}

bar() {
  local pct=$1
  local total=40
  local fill=$((pct * total / 100))
  local empty=$((total - fill))
  local f="${NE}$(printf '█%.0s' $(seq 1 $fill 2>/dev/null))"
  local e="${VI}$(printf '░%.0s' $(seq 1 $empty 2>/dev/null))"
  echo -ne "  ${CY}[${R}${f}${e}${CY}]${R} ${GD}${pct}%${R}"
}

# ═══════════════════════════════════════════════════════════
clear
echo ""
echo -e "  ${CY}${B}   ███╗   ██╗███████╗ ██████╗██████╗  ██████╗${R}"
echo -e "  ${PK}${B}   ████╗  ██║██╔════╝██╔════╝██╔══██╗██╔═══██╗${R}"
echo -e "  ${VI}${B}   ██╔██╗ ██║█████╗  ██║     ██████╔╝██║   ██║${R}"
echo -e "  ${NE}${B}   ██║ ╚████║███████╗╚██████╗██║  ██║╚██████╔╝${R}"
echo -e "  ${GR}${B}   ╚═╝  ╚═══╝╚══════╝ ╚═════╝╚═╝  ╚═╝ ╚═════╝${R}"
echo ""
echo -e "  ${PK}${B}◆ NECRO SOURCE PROXY FREE${R}  ${D}│ INSTALLER v2${R}"
echo -e "  ${VI}─────────────────────────────────────────────${R}"
echo ""
echo -e "  ${IC}▸ User    :${R} ${GD}$USER${R}"
echo -e "  ${IC}▸ Device  :${R} ${GD}$(getprop ro.product.model 2>/dev/null)${R}"
echo -e "  ${IC}▸ Date    :${R} ${GD}$(date '+%a, %d %b %Y • %H:%M')${R}"
echo ""
echo -e "  ${D}Total 5 step, estimasi 3-5 menit. Jangan close Termux.${R}"
echo ""

# ─── STEP 1: Update ───
step "1/5" "Update package list"
spin_start "Updating..."
pkg update -y > /tmp/necro-install.log 2>&1
spin_stop "Package list updated"

# ─── STEP 2: Upgrade ───
step "2/5" "Upgrade semua package (2-5 menit)"
echo -e "  ${D}Kalau lama, itu normal. Jangan CTRL+C.${R}"
echo ""
spin_start "Upgrading..."
pkg upgrade -y >> /tmp/necro-install.log 2>&1
spin_stop "Upgrade selesai"

# ─── STEP 3: Install ───
step "3/5" "Install git + openssl-tool + nodejs"
spin_start "Downloading packages..."
pkg install git openssl-tool nodejs -y >> /tmp/necro-install.log 2>&1
spin_stop "Package installed"

# ─── STEP 4: Test Node.js ───
step "4/5" "Test Node.js"
spin_start "Checking node..."
if node -v > /dev/null 2>&1; then
  NODE_V=$(node -v)
  spin_stop "Node.js OK: ${NODE_V}"
else
  spin_stop "Node.js error, fixing..."
  spin_start "Reinstalling openssl + nodejs..."
  pkg reinstall openssl libcrypto libssl nodejs -y >> /tmp/necro-install.log 2>&1
  if node -v > /dev/null 2>&1; then
    spin_stop "Fixed: $(node -v)"
  else
    echo -e "  ${CR}${B}✗ Gagal install Node.js${R}"
    echo -e "  ${D}Log: /tmp/necro-install.log${R}"
    exit 1
  fi
fi

# ─── STEP 5: npm install ───
step "5/5" "Install dependencies project"
echo -e "  ${D}Kalau ada warning, abaikan saja.${R}"
echo ""
spin_start "npm install..."
npm install --no-audit --no-fund --loglevel=error >> /tmp/necro-install.log 2>&1
if [ $? -eq 0 ]; then
  spin_stop "Dependencies installed"
else
  spin_stop "npm install gagal, coba lagi..."
  npm install --no-audit --no-fund --loglevel=info
fi

# ═══════════════════════════════════════════════════════════
echo ""
echo -e "  ${VI}═════════════════════════════════════════════${R}"
echo -e "  ${GR}${B}   ✓ SEMUA INSTALL SELESAI!${R}"
echo -e "  ${VI}═════════════════════════════════════════════${R}"
echo ""
echo -e "  ${PK}${B}Jalanin project:${R}"
echo -e "     ${GD}node necro.js${R}"
echo ""
echo -e "  ${IC}Report :${R} ${GR}https://wa.me/6283102787569${R}"
echo -e "  ${IC}Channel:${R} ${GR}https://whatsapp.com/channel/0029Vb8ea8mICVfjXgDHSc2H${R}"
echo ""
