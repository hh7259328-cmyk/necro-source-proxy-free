#!/data/data/com.termux/files/usr/bin/bash
# NECRO SOURCE PROXY FREE — INSTALLER
# © 2026 NecroTeam

echo ""
echo "  ╔══════════════════════════════════════════════╗"
echo "  ║   NECRO SOURCE PROXY FREE — INSTALLER       ║"
echo "  ╚══════════════════════════════════════════════╝"
echo ""

echo "  [1/5] Update package list..."
pkg update -y >/dev/null 2>&1

echo "  [2/5] Upgrade semua package (2-5 menit)..."
pkg upgrade -y >/dev/null 2>&1

echo "  [3/5] Install git + openssl-tool + nodejs..."
pkg install git openssl-tool nodejs -y >/dev/null 2>&1

echo "  [4/5] Test Node.js..."
if node -v >/dev/null 2>&1; then
  echo "  ✓ Node.js OK: $(node -v)"
else
  echo "  ✗ Node.js error, coba fix..."
  pkg reinstall openssl libcrypto libssl nodejs -y >/dev/null 2>&1
  if node -v >/dev/null 2>&1; then
    echo "  ✓ Fixed: $(node -v)"
  else
    echo "  ✗ Gagal. Coba: termux-change-repo"
    exit 1
  fi
fi

echo "  [5/5] Install dependencies project..."
npm install

echo ""
echo "  ╔══════════════════════════════════════════════╗"
echo "  ║   ✓ INSTALL SELESAI!                        ║"
echo "  ╚══════════════════════════════════════════════╝"
echo ""
echo "  Jalanin: node necro.js"
echo ""
echo "  Report : https://wa.me/6283102787569"
echo "  Channel: https://whatsapp.com/channel/0029Vb8ea8mICVfjXgDHSc2H"
echo ""
