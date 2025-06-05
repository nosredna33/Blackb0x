#!/bin/bash
# Script de configuração LUKS e F2FS para BlackB0x

set -e

BLACKB0X_ROOT="/home/ubuntu/blackb0x"
BUILD_DIR="$BLACKB0X_ROOT/build"
ROOTFS_DIR="$BUILD_DIR/rootfs"

echo "=== Configurando LUKS e F2FS para BlackB0x ==="

# Configurar hooks do initramfs para LUKS
configure_luks_initramfs() {
    echo "Configurando initramfs para LUKS..."
    
    # Criar diretório para hooks
    mkdir -p "$ROOTFS_DIR/etc/initramfs-tools/hooks"
    mkdir -p "$ROOTFS_DIR/etc/initramfs-tools/scripts/init-premount"
    
    # Hook para incluir cryptsetup no initramfs
    cat > "$ROOTFS_DIR/etc/initramfs-tools/hooks/cryptsetup" << 'EOF'
#!/bin/sh
PREREQ=""
prereqs()
{
    echo "$PREREQ"
}

case $1 in
prereqs)
    prereqs
    exit 0
    ;;
esac

. /usr/share/initramfs-tools/hook-functions

# Copiar binários necessários
copy_exec /sbin/cryptsetup /sbin
copy_exec /sbin/dmsetup /sbin
copy_exec /lib/cryptsetup/askpass /lib/cryptsetup

# Copiar módulos do kernel
manual_add_modules dm-crypt
manual_add_modules aes
manual_add_modules xts
manual_add_modules sha256
manual_add_modules f2fs

exit 0
EOF
    
    chmod +x "$ROOTFS_DIR/etc/initramfs-tools/hooks/cryptsetup"
}

# Configurar script de desbloqueio LUKS
configure_luks_unlock() {
    echo "Configurando script de desbloqueio LUKS..."
    
    cat > "$ROOTFS_DIR/etc/initramfs-tools/scripts/init-premount/cryptroot" << 'EOF'
#!/bin/sh
PREREQ=""
prereqs()
{
    echo "$PREREQ"
}

case $1 in
prereqs)
    prereqs
    exit 0
    ;;
esac

# Aguardar dispositivos
/sbin/udevadm settle

# Verificar se existe partição criptografada
if [ -b /dev/disk/by-label/BlackB0x-crypt ]; then
    echo "Detectada partição criptografada BlackB0x"
    
    # Solicitar senha
    while true; do
        echo -n "Digite a senha para desbloqueio do BlackB0x: "
        read -s password
        echo
        
        # Tentar desbloqueio
        if echo "$password" | /sbin/cryptsetup luksOpen /dev/disk/by-label/BlackB0x-crypt blackb0x-root; then
            echo "Partição desbloqueada com sucesso!"
            break
        else
            echo "Senha incorreta. Tente novamente."
        fi
    done
fi

exit 0
EOF
    
    chmod +x "$ROOTFS_DIR/etc/initramfs-tools/scripts/init-premount/cryptroot"
}

# Configurar crypttab
configure_crypttab() {
    echo "Configurando crypttab..."
    
    cat > "$ROOTFS_DIR/etc/crypttab" << 'EOF'
# <target name> <source device> <key file> <options>
blackb0x-root /dev/disk/by-label/BlackB0x-crypt none luks,tries=3
EOF
}

# Configurar fstab para F2FS criptografado
configure_encrypted_fstab() {
    echo "Configurando fstab para F2FS criptografado..."
    
    cat > "$ROOTFS_DIR/etc/fstab" << 'EOF'
# BlackB0x F2FS + LUKS Configuration
# <file system> <mount point> <type> <options> <dump> <pass>

# Sistema de arquivos principal criptografado
/dev/mapper/blackb0x-root / f2fs defaults,noatime 0 1

# Sistemas temporários em RAM
tmpfs /tmp tmpfs defaults,noatime,mode=1777 0 0
tmpfs /var/tmp tmpfs defaults,noatime,mode=1777 0 0
tmpfs /var/log tmpfs defaults,noatime,mode=0755 0 0

# Sistemas especiais
proc /proc proc defaults 0 0
sysfs /sys sysfs defaults 0 0
devpts /dev/pts devpts defaults 0 0
EOF
}

# Criar script de formatação para instalação
create_format_script() {
    echo "Criando script de formatação para instalação..."
    
    cat > "$ROOTFS_DIR/usr/local/bin/blackb0x-format" << 'EOF'
#!/bin/bash
# Script de formatação e configuração LUKS + F2FS para BlackB0x

set -e

if [ "$EUID" -ne 0 ]; then
    echo "Este script deve ser executado como root"
    exit 1
fi

DEVICE="$1"
if [ -z "$DEVICE" ]; then
    echo "Uso: $0 <dispositivo>"
    echo "Exemplo: $0 /dev/sdb"
    exit 1
fi

echo "=== BlackB0x Formatação LUKS + F2FS ==="
echo "ATENÇÃO: Todos os dados em $DEVICE serão perdidos!"
read -p "Continuar? (s/N): " confirm

if [ "$confirm" != "s" ] && [ "$confirm" != "S" ]; then
    echo "Operação cancelada."
    exit 0
fi

# Criar partição
echo "Criando partição..."
parted -s "$DEVICE" mklabel msdos
parted -s "$DEVICE" mkpart primary 0% 100%
parted -s "$DEVICE" set 1 boot on

PARTITION="${DEVICE}1"

# Configurar LUKS
echo "Configurando criptografia LUKS..."
cryptsetup luksFormat "$PARTITION" --label=BlackB0x-crypt

# Abrir partição criptografada
echo "Abrindo partição criptografada..."
cryptsetup luksOpen "$PARTITION" blackb0x-root

# Formatar com F2FS
echo "Formatando com F2FS..."
mkfs.f2fs -l BlackB0x-root /dev/mapper/blackb0x-root

echo "Formatação concluída!"
echo "Use 'mount /dev/mapper/blackb0x-root /mnt' para montar"
EOF
    
    chmod +x "$ROOTFS_DIR/usr/local/bin/blackb0x-format"
}

# Executar configurações
configure_luks_initramfs
configure_luks_unlock
configure_crypttab
configure_encrypted_fstab
create_format_script

echo "Configuração LUKS e F2FS concluída!"
echo "Sistema configurado para criptografia de disco completa"

