# Instruções de Instalação - BlackB0x Linux

## Requisitos Mínimos
- RAM: 2GB (recomendado 4GB)
- Armazenamento: 8GB (recomendado 16GB)
- Processador: x86_64 compatível
- BIOS: Legacy ou UEFI

## Gravação em Pendrive

### Linux
```bash
sudo dd if=BlackB0x-1.0-Terminal.iso of=/dev/sdX bs=4M status=progress
sudo sync
```

### Windows
Use Rufus ou balenaEtcher para gravar a ISO no pendrive.

### macOS
```bash
sudo dd if=BlackB0x-1.0-Terminal.iso of=/dev/diskX bs=4m
```

## Boot
1. Configure o BIOS para boot por USB
2. Selecione o pendrive como dispositivo de boot
3. Escolha "BlackB0x Linux 1.0 (Terminal)" no menu GRUB

## Primeira Inicialização
1. O sistema solicitará a senha de desbloqueio (se instalado)
2. Login automático como usuário `blackb0x`
3. Tor Browser iniciará automaticamente
4. Navegação para blackb0x.com.br/BemVindo

## Instalação Permanente
Para instalar permanentemente no disco:
```bash
sudo blackb0x-format /dev/sdX
```

## Verificação de Integridade
Antes da instalação, verifique os checksums:
```bash
md5sum -c BlackB0x-1.0-Terminal.iso.md5
sha256sum -c BlackB0x-1.0-Terminal.iso.sha256
```
