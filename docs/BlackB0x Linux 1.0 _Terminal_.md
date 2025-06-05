# BlackB0x Linux 1.0 "Terminal"

## Descrição
BlackB0x é uma distribuição Linux focada em privacidade e segurança, baseada em conceitos do TailOS.

## Características
- **Criptografia LUKS**: Sistema de arquivos criptografado
- **F2FS**: Sistema de arquivos otimizado para SSDs
- **Tor Browser**: Navegação anônima automática
- **ZRAM**: Swap em memória RAM
- **Localização**: Português brasileiro (pt_BR.UTF-8)
- **Interface**: XFCE com LightDM
- **Boot**: Compatível com BIOS legacy e UEFI

## Instalação
1. Grave a ISO em um pendrive usando `dd` ou Rufus
2. Boot pelo pendrive
3. O sistema iniciará automaticamente
4. Para instalação permanente, use o script `blackb0x-format`

## Uso
- O sistema inicia automaticamente o Tor Browser
- Navega automaticamente para https://blackb0x.com.br/BemVindo
- Usuário padrão: `blackb0x` (login automático)
- Timezone: America/Sao_Paulo (-3:00)

## Segurança
- Todo o sistema de arquivos é criptografado com LUKS
- Conexões de rede passam pelo Tor
- Sistemas temporários em RAM (tmpfs)
- Sem logs persistentes

## Suporte
- Website: https://blackb0x.com.br
- Documentação: https://blackb0x.com.br/docs
- Suporte: https://blackb0x.com.br/suporte

---
BlackB0x Linux - Privacidade e Segurança em Primeiro Lugar
