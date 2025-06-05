#!/bin/bash
# Script de configuração do GRUB para BlackB0x

set -e

BLACKB0X_ROOT="/home/ubuntu/blackb0x"
BUILD_DIR="$BLACKB0X_ROOT/build"
ISO_ROOT="$BUILD_DIR/iso_root"
GRUB_DIR="$ISO_ROOT/boot/grub"

echo "=== Configurando GRUB para BlackB0x ==="

# Criar estrutura de diretórios para GRUB
mkdir -p "$GRUB_DIR"/{i386-pc,fonts,locale}

# Copiar módulos GRUB necessários para BIOS legacy
echo "Copiando módulos GRUB para BIOS legacy..."
if [ -d "/usr/lib/grub/i386-pc" ]; then
    cp -r /usr/lib/grub/i386-pc/* "$GRUB_DIR/i386-pc/"
else
    echo "Aviso: Módulos GRUB i386-pc não encontrados"
fi

# Copiar fontes GRUB
if [ -d "/usr/share/grub" ]; then
    find /usr/share/grub -name "*.pf2" -exec cp {} "$GRUB_DIR/fonts/" \; 2>/dev/null || true
fi

# Criar arquivo de configuração para isolinux (fallback)
mkdir -p "$ISO_ROOT/isolinux"
cat > "$ISO_ROOT/isolinux/isolinux.cfg" << 'EOF'
DEFAULT blackb0x
TIMEOUT 50
PROMPT 1

LABEL blackb0x
  MENU LABEL BlackB0x Linux 1.0
  KERNEL /boot/vmlinuz
  APPEND initrd=/boot/initrd.img root=live:CDLABEL=BlackB0x rd.live.image quiet splash

LABEL safe
  MENU LABEL BlackB0x Linux 1.0 (Modo Seguro)
  KERNEL /boot/vmlinuz
  APPEND initrd=/boot/initrd.img root=live:CDLABEL=BlackB0x rd.live.image nomodeset quiet

LABEL check
  MENU LABEL Verificar Mídia
  KERNEL /boot/vmlinuz
  APPEND initrd=/boot/initrd.img root=live:CDLABEL=BlackB0x rd.live.image rd.live.check quiet
EOF

# Copiar isolinux.bin se disponível
if [ -f "/usr/lib/ISOLINUX/isolinux.bin" ]; then
    cp /usr/lib/ISOLINUX/isolinux.bin "$ISO_ROOT/isolinux/"
elif [ -f "/usr/lib/syslinux/modules/bios/isolinux.bin" ]; then
    cp /usr/lib/syslinux/modules/bios/isolinux.bin "$ISO_ROOT/isolinux/"
fi

# Copiar ldlinux.c32 se disponível
if [ -f "/usr/lib/syslinux/modules/bios/ldlinux.c32" ]; then
    cp /usr/lib/syslinux/modules/bios/ldlinux.c32 "$ISO_ROOT/isolinux/"
fi

echo "Configuração do GRUB concluída!"
echo "Arquivos de boot preparados para BIOS legacy"

