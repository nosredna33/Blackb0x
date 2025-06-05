#!/bin/bash
# Script de configuração do ambiente gráfico BlackB0x

set -e

BLACKB0X_ROOT="/home/ubuntu/blackb0x"
BUILD_DIR="$BLACKB0X_ROOT/build"
ROOTFS_DIR="$BUILD_DIR/rootfs"
ASSETS_DIR="$BLACKB0X_ROOT/assets"

echo "=== Configurando Ambiente Gráfico BlackB0x ==="

# Configurar LightDM
configure_lightdm() {
    echo "Configurando LightDM..."
    
    mkdir -p "$ROOTFS_DIR/etc/lightdm"
    
    # Configuração principal do LightDM
    cat > "$ROOTFS_DIR/etc/lightdm/lightdm.conf" << 'EOF'
[Seat:*]
autologin-user=blackb0x
autologin-user-timeout=0
user-session=xfce
greeter-session=lightdm-gtk-greeter
greeter-hide-users=false
greeter-allow-guest=false
greeter-show-manual-login=true
greeter-show-remote-login=false
EOF

    # Configuração do greeter GTK
    cat > "$ROOTFS_DIR/etc/lightdm/lightdm-gtk-greeter.conf" << 'EOF'
[greeter]
background=/usr/share/pixmaps/blackb0x_wallpaper.png
theme-name=Adwaita-dark
icon-theme-name=Adwaita
font-name=Monospace 11
xft-antialias=true
xft-dpi=96
xft-hintstyle=slight
xft-rgba=rgb
show-indicators=~host;~spacer;~clock;~spacer;~session;~language;~a11y;~power
show-clock=true
clock-format=%H:%M:%S
position=50%,center 50%,center
EOF
}

# Configurar XFCE
configure_xfce() {
    echo "Configurando XFCE..."
    
    mkdir -p "$ROOTFS_DIR/home/blackb0x/.config/xfce4/xfconf/xfce-perchannel-xml"
    
    # Configuração do desktop XFCE
    cat > "$ROOTFS_DIR/home/blackb0x/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-desktop.xml" << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<channel name="xfce4-desktop" version="1.0">
  <property name="backdrop" type="empty">
    <property name="screen0" type="empty">
      <property name="monitor0" type="empty">
        <property name="workspace0" type="empty">
          <property name="color-style" type="int" value="0"/>
          <property name="image-style" type="int" value="5"/>
          <property name="last-image" type="string" value="/usr/share/pixmaps/blackb0x_wallpaper.png"/>
        </property>
      </property>
    </property>
  </property>
</channel>
EOF

    # Configuração do painel XFCE
    cat > "$ROOTFS_DIR/home/blackb0x/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml" << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<channel name="xfce4-panel" version="1.0">
  <property name="configver" type="int" value="2"/>
  <property name="panels" type="array">
    <value type="int" value="1"/>
    <property name="panel-1" type="empty">
      <property name="position" type="string" value="p=6;x=0;y=0"/>
      <property name="length" type="uint" value="100"/>
      <property name="position-locked" type="bool" value="true"/>
      <property name="size" type="uint" value="28"/>
      <property name="plugin-ids" type="array">
        <value type="int" value="1"/>
        <value type="int" value="2"/>
        <value type="int" value="3"/>
        <value type="int" value="4"/>
        <value type="int" value="5"/>
      </property>
    </property>
  </property>
  <property name="plugins" type="empty">
    <property name="plugin-1" type="string" value="applicationsmenu"/>
    <property name="plugin-2" type="string" value="tasklist"/>
    <property name="plugin-3" type="string" value="separator"/>
    <property name="plugin-4" type="string" value="systray"/>
    <property name="plugin-5" type="string" value="clock"/>
  </property>
</channel>
EOF
}

# Configurar autostart do Tor Browser
configure_tor_autostart() {
    echo "Configurando autostart do Tor Browser..."
    
    mkdir -p "$ROOTFS_DIR/home/blackb0x/.config/autostart"
    
    # Script de inicialização do Tor Browser
    cat > "$ROOTFS_DIR/home/blackb0x/.config/autostart/tor-browser.desktop" << 'EOF'
[Desktop Entry]
Type=Application
Name=Tor Browser AutoStart
Comment=Inicia automaticamente o Tor Browser e navega para blackb0x.com.br
Exec=/usr/local/bin/blackb0x-tor-start
Icon=tor-browser
Hidden=false
NoDisplay=false
X-GNOME-Autostart-enabled=true
EOF

    # Script de inicialização personalizado
    mkdir -p "$ROOTFS_DIR/usr/local/bin"
    cat > "$ROOTFS_DIR/usr/local/bin/blackb0x-tor-start" << 'EOF'
#!/bin/bash
# Script de inicialização do Tor Browser para BlackB0x

# Aguardar carregamento completo do desktop
sleep 5

# Verificar se o Tor está rodando
if ! pgrep -x "tor" > /dev/null; then
    echo "Iniciando serviço Tor..."
    sudo systemctl start tor
    sleep 3
fi

# Aguardar Tor estar pronto
echo "Aguardando Tor estar pronto..."
while ! curl -s --socks5 127.0.0.1:9050 http://check.torproject.org/ > /dev/null; do
    sleep 2
done

# Iniciar Tor Browser
echo "Iniciando Tor Browser..."
if command -v torbrowser-launcher &> /dev/null; then
    torbrowser-launcher &
    
    # Aguardar Tor Browser carregar
    sleep 10
    
    # Navegar para a página padrão
    echo "Navegando para blackb0x.com.br..."
    # Usar xdotool para automatizar navegação se disponível
    if command -v xdotool &> /dev/null; then
        sleep 5
        xdotool key ctrl+l
        sleep 1
        xdotool type "https://blackb0x.com.br/BemVindo"
        sleep 1
        xdotool key Return
    fi
else
    echo "Tor Browser não encontrado, abrindo Firefox com proxy Tor..."
    firefox --new-instance --private-window "https://blackb0x.com.br/BemVindo" &
fi
EOF
    
    chmod +x "$ROOTFS_DIR/usr/local/bin/blackb0x-tor-start"
}

# Configurar serviço Tor
configure_tor_service() {
    echo "Configurando serviço Tor..."
    
    mkdir -p "$ROOTFS_DIR/etc/tor"
    
    # Configuração do Tor
    cat > "$ROOTFS_DIR/etc/tor/torrc" << 'EOF'
# Configuração Tor para BlackB0x
SocksPort 9050
ControlPort 9051
CookieAuthentication 1
DataDirectory /var/lib/tor

# Configurações de segurança
ExitPolicy reject *:*
StrictNodes 1
FascistFirewall 1

# Log
Log notice file /var/log/tor/notices.log
EOF

    # Habilitar serviço Tor
    mkdir -p "$ROOTFS_DIR/etc/systemd/system/multi-user.target.wants"
    ln -sf /lib/systemd/system/tor.service "$ROOTFS_DIR/etc/systemd/system/multi-user.target.wants/tor.service" 2>/dev/null || true
}

# Copiar papel de parede
copy_wallpaper() {
    echo "Copiando papel de parede..."
    
    mkdir -p "$ROOTFS_DIR/usr/share/pixmaps"
    cp "$ASSETS_DIR/blackb0x_wallpaper.png" "$ROOTFS_DIR/usr/share/pixmaps/"
    cp "$ASSETS_DIR/blackb0x_logo.png" "$ROOTFS_DIR/usr/share/pixmaps/"
}

# Executar configurações
configure_lightdm
configure_xfce
configure_tor_autostart
configure_tor_service
copy_wallpaper

echo "Configuração do ambiente gráfico concluída!"
echo "LightDM, XFCE e Tor Browser configurados com autostart"

