#!/bin/bash
# Script de configuração de localização para BlackB0x

set -e

BLACKB0X_ROOT="/home/ubuntu/blackb0x"
BUILD_DIR="$BLACKB0X_ROOT/build"
ROOTFS_DIR="$BUILD_DIR/rootfs"

echo "=== Configurando Localização Português Brasileiro ==="

# Configurar locale
configure_locale() {
    echo "Configurando locale pt_BR.UTF-8..."
    
    # Arquivo de configuração de locale
    cat > "$ROOTFS_DIR/etc/locale.gen" << 'EOF'
# Locales suportados pelo BlackB0x
en_US.UTF-8 UTF-8
pt_BR.UTF-8 UTF-8
EOF

    # Configuração padrão do locale
    cat > "$ROOTFS_DIR/etc/default/locale" << 'EOF'
LANG=pt_BR.UTF-8
LANGUAGE=pt_BR:pt:en
LC_ALL=pt_BR.UTF-8
LC_ADDRESS=pt_BR.UTF-8
LC_IDENTIFICATION=pt_BR.UTF-8
LC_MEASUREMENT=pt_BR.UTF-8
LC_MONETARY=pt_BR.UTF-8
LC_NAME=pt_BR.UTF-8
LC_NUMERIC=pt_BR.UTF-8
LC_PAPER=pt_BR.UTF-8
LC_TELEPHONE=pt_BR.UTF-8
LC_TIME=pt_BR.UTF-8
EOF

    # Configuração do environment
    cat > "$ROOTFS_DIR/etc/environment" << 'EOF'
PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
LANG=pt_BR.UTF-8
LANGUAGE=pt_BR:pt:en
LC_ALL=pt_BR.UTF-8
EOF
}

# Configurar timezone
configure_timezone() {
    echo "Configurando timezone America/Sao_Paulo..."
    
    # Criar link simbólico para timezone
    mkdir -p "$ROOTFS_DIR/etc"
    echo "America/Sao_Paulo" > "$ROOTFS_DIR/etc/timezone"
    
    # Configurar localtime (será criado durante a instalação)
    mkdir -p "$ROOTFS_DIR/usr/share/zoneinfo/America"
    # O arquivo será copiado durante a construção da ISO
}

# Configurar teclado
configure_keyboard() {
    echo "Configurando layout de teclado ABNT2..."
    
    # Configuração do teclado
    cat > "$ROOTFS_DIR/etc/default/keyboard" << 'EOF'
XKBMODEL="abnt2"
XKBLAYOUT="br"
XKBVARIANT=""
XKBOPTIONS=""
BACKSPACE="guess"
EOF

    # Configuração do console
    cat > "$ROOTFS_DIR/etc/default/console-setup" << 'EOF'
ACTIVE_CONSOLES="/dev/tty[1-6]"
CHARMAP="UTF-8"
CODESET="Lat15"
FONTFACE="TerminusBold"
FONTSIZE="16"
VIDEOMODE=
EOF
}

# Configurar formato de data e moeda
configure_formats() {
    echo "Configurando formatos brasileiros..."
    
    # Script para configurar formatos do usuário
    mkdir -p "$ROOTFS_DIR/home/blackb0x/.config"
    cat > "$ROOTFS_DIR/home/blackb0x/.config/user-dirs.locale" << 'EOF'
pt_BR
EOF

    # Configuração de diretórios do usuário em português
    cat > "$ROOTFS_DIR/home/blackb0x/.config/user-dirs.dirs" << 'EOF'
XDG_DESKTOP_DIR="$HOME/Área de Trabalho"
XDG_DOWNLOAD_DIR="$HOME/Downloads"
XDG_TEMPLATES_DIR="$HOME/Modelos"
XDG_PUBLICSHARE_DIR="$HOME/Público"
XDG_DOCUMENTS_DIR="$HOME/Documentos"
XDG_MUSIC_DIR="$HOME/Música"
XDG_PICTURES_DIR="$HOME/Imagens"
XDG_VIDEOS_DIR="$HOME/Vídeos"
EOF

    # Criar diretórios do usuário
    mkdir -p "$ROOTFS_DIR/home/blackb0x"/{Documentos,Downloads,Imagens,Música,Vídeos,Público,Modelos}
    mkdir -p "$ROOTFS_DIR/home/blackb0x/Área\ de\ Trabalho"
}

# Configurar variáveis de ambiente do XFCE
configure_xfce_locale() {
    echo "Configurando locale do XFCE..."
    
    mkdir -p "$ROOTFS_DIR/home/blackb0x/.config/xfce4/xfconf/xfce-perchannel-xml"
    
    # Configuração de locale do XFCE
    cat > "$ROOTFS_DIR/home/blackb0x/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-keyboard-shortcuts.xml" << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<channel name="xfce4-keyboard-shortcuts" version="1.0">
  <property name="commands" type="empty">
    <property name="default" type="empty">
      <property name="&lt;Alt&gt;F1" type="string" value="xfce4-popup-applicationsmenu"/>
      <property name="&lt;Alt&gt;F2" type="string" value="xfce4-appfinder --collapsed"/>
      <property name="&lt;Alt&gt;F3" type="string" value="xfce4-appfinder"/>
      <property name="&lt;Primary&gt;&lt;Alt&gt;Delete" type="string" value="xflock4"/>
      <property name="&lt;Primary&gt;&lt;Alt&gt;l" type="string" value="xflock4"/>
      <property name="&lt;Primary&gt;&lt;Alt&gt;t" type="string" value="exo-open --launch TerminalEmulator"/>
    </property>
  </property>
  <property name="xfwm4" type="empty">
    <property name="default" type="empty">
      <property name="&lt;Alt&gt;Insert" type="string" value="add_workspace_key"/>
      <property name="&lt;Alt&gt;Delete" type="string" value="del_workspace_key"/>
    </property>
  </property>
</channel>
EOF
}

# Configurar script de inicialização de locale
configure_locale_script() {
    echo "Criando script de configuração de locale..."
    
    cat > "$ROOTFS_DIR/usr/local/bin/blackb0x-locale-setup" << 'EOF'
#!/bin/bash
# Script de configuração de locale para BlackB0x

# Gerar locales
locale-gen pt_BR.UTF-8 en_US.UTF-8

# Configurar timezone
ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime
dpkg-reconfigure -f noninteractive tzdata

# Configurar teclado
dpkg-reconfigure -f noninteractive keyboard-configuration
dpkg-reconfigure -f noninteractive console-setup

# Atualizar locale
update-locale LANG=pt_BR.UTF-8

echo "Configuração de locale concluída!"
EOF
    
    chmod +x "$ROOTFS_DIR/usr/local/bin/blackb0x-locale-setup"
}

# Executar configurações
configure_locale
configure_timezone
configure_keyboard
configure_formats
configure_xfce_locale
configure_locale_script

echo "Configuração de localização concluída!"
echo "Sistema configurado para português brasileiro (pt_BR.UTF-8)"

