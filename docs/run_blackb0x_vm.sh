#!/bin/bash
# Script para executar BlackB0x ISO no QEMU

set -e

BLACKB0X_ISO="/home/ubuntu/blackb0x/BlackB0x-1.0-Terminal.iso"
VM_DIR="/home/ubuntu/vm_screenshots"
DISK_SIZE="2G"

echo "=== Executando BlackB0x ISO no QEMU ==="

# Criar diretório para screenshots
mkdir -p "$VM_DIR"

# Verificar se a ISO existe
if [ ! -f "$BLACKB0X_ISO" ]; then
    echo "Erro: ISO não encontrada em $BLACKB0X_ISO"
    exit 1
fi

echo "ISO encontrada: $BLACKB0X_ISO"
echo "Tamanho: $(du -h "$BLACKB0X_ISO" | cut -f1)"

# Criar disco virtual temporário
echo "Criando disco virtual temporário..."
qemu-img create -f qcow2 "$VM_DIR/blackb0x_temp.qcow2" "$DISK_SIZE"

echo "Iniciando máquina virtual..."
echo "Pressione Ctrl+Alt+G para liberar o mouse"
echo "Use Ctrl+Alt+2 para acessar o monitor QEMU"
echo "Digite 'quit' no monitor para sair"

# Executar QEMU com a ISO
qemu-system-x86_64 \
    -m 1024 \
    -smp 2 \
    -cdrom "$BLACKB0X_ISO" \
    -hda "$VM_DIR/blackb0x_temp.qcow2" \
    -boot d \
    -vga std \
    -display gtk \
    -netdev user,id=net0 \
    -device e1000,netdev=net0 \
    -monitor stdio \
    -name "BlackB0x Linux VM" \
    -enable-kvm 2>/dev/null || \
qemu-system-x86_64 \
    -m 1024 \
    -smp 2 \
    -cdrom "$BLACKB0X_ISO" \
    -hda "$VM_DIR/blackb0x_temp.qcow2" \
    -boot d \
    -vga std \
    -display gtk \
    -netdev user,id=net0 \
    -device e1000,netdev=net0 \
    -monitor stdio \
    -name "BlackB0x Linux VM"

echo "VM finalizada."

