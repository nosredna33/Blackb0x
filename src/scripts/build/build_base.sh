#!/bin/bash
# BlackB0x Linux Distribution Build Script
# Baseado em conceitos do TailOS com foco em privacidade

set -e

# Variáveis de configuração
BLACKB0X_ROOT="/home/ubuntu/blackb0x"
BUILD_DIR="$BLACKB0X_ROOT/build"
ROOTFS_DIR="$BUILD_DIR/rootfs"
ISO_ROOT="$BUILD_DIR/iso_root"
ASSETS_DIR="$BLACKB0X_ROOT/assets"

echo "=== BlackB0x Linux Distribution Builder ==="
echo "Iniciando construção do sistema base..."

# Criar estrutura básica do sistema de arquivos
create_base_structure() {
    echo "Criando estrutura básica do sistema de arquivos..."
    
    # Diretórios essenciais do sistema
    mkdir -p "$ROOTFS_DIR"/{bin,sbin,etc,dev,proc,sys,tmp,var,usr,home,root,boot,mnt,media,opt,srv}
    mkdir -p "$ROOTFS_DIR"/usr/{bin,sbin,lib,share,local}
    mkdir -p "$ROOTFS_DIR"/var/{log,tmp,cache,lib}
    mkdir -p "$ROOTFS_DIR"/etc/{init.d,systemd,network,tor}
    mkdir -p "$ROOTFS_DIR"/home/blackb0x
    
    # Configurar permissões
    chmod 1777 "$ROOTFS_DIR/tmp"
    chmod 755 "$ROOTFS_DIR"/{bin,sbin,usr,etc,var,home,root,boot,mnt,media,opt,srv}
    
    echo "Estrutura básica criada com sucesso."
}

# Lista de pacotes essenciais para BlackB0x
define_essential_packages() {
    cat > "$BUILD_DIR/packages.list" << 'EOF'
# Sistema base
linux-image-generic
linux-headers-generic
initramfs-tools
systemd
systemd-sysv
dbus

# Sistema de arquivos e criptografia
cryptsetup
f2fs-tools
zram-tools

# Rede e Tor
tor
torbrowser-launcher
network-manager
wireless-tools
wpasupplicant

# Interface gráfica leve
lightdm
lightdm-gtk-greeter
xfce4-minimal
xfce4-terminal
firefox-esr

# Ferramentas essenciais
bash
coreutils
util-linux
procps
psmisc
nano
vim-tiny
curl
wget
gnupg
ca-certificates

# Localização
locales
keyboard-configuration
console-setup
EOF
}

# Configurar sistema de arquivos F2FS
configure_f2fs() {
    echo "Configurando suporte a F2FS..."
    
    # Adicionar módulos F2FS ao initramfs
    mkdir -p "$ROOTFS_DIR/etc/initramfs-tools/modules"
    echo "f2fs" >> "$ROOTFS_DIR/etc/initramfs-tools/modules"
    
    # Configurar fstab para F2FS
    cat > "$ROOTFS_DIR/etc/fstab" << 'EOF'
# BlackB0x F2FS Configuration
# <file system> <mount point> <type> <options> <dump> <pass>
tmpfs /tmp tmpfs defaults,noatime,mode=1777 0 0
tmpfs /var/tmp tmpfs defaults,noatime,mode=1777 0 0
EOF
}

# Configurar zram para swap
configure_zram() {
    echo "Configurando zram para swap em RAM..."
    
    mkdir -p "$ROOTFS_DIR/etc/systemd/system"
    
    cat > "$ROOTFS_DIR/etc/systemd/system/zram-swap.service" << 'EOF'
[Unit]
Description=Compressed swap in RAM using zram
After=multi-user.target

[Service]
Type=oneshot
RemainAfterExit=true
ExecStart=/bin/bash -c 'echo lz4 > /sys/block/zram0/comp_algorithm && echo 2G > /sys/block/zram0/disksize && mkswap /dev/zram0 && swapon /dev/zram0'
ExecStop=/bin/bash -c 'swapoff /dev/zram0'

[Install]
WantedBy=multi-user.target
EOF
    
    # Habilitar serviço zram
    mkdir -p "$ROOTFS_DIR/etc/systemd/system/multi-user.target.wants"
    ln -sf ../zram-swap.service "$ROOTFS_DIR/etc/systemd/system/multi-user.target.wants/zram-swap.service"
}

# Executar funções
create_base_structure
define_essential_packages
configure_f2fs
configure_zram

echo "Configuração do sistema base concluída!"
echo "Próximos passos: configurar bootloader e criptografia"

